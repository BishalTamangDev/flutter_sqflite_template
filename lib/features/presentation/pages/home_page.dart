import 'package:flutter/material.dart';
import 'package:sqflite_git/features/data/data_sources/source.dart';
import 'package:sqflite_git/features/presentation/pages/error_page.dart';

import '../widgets/counter_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // variables
  Source source = Source.getInstance();

  late Future<List<Map<String, dynamic>>> _data;

  @override
  void initState() {
    super.initState();
    _data = _fetchData();
  }

  // fetch data
  Future<List<Map<String, dynamic>>> _fetchData() async {
    return await source.getCounters();
  }

  // refresh data
  void _refreshData() {
    setState(() {
      _data = _fetchData(); // Recreate the Future
    });
  }

  // add new counter
  Future<void> addNewCounter() async {
    bool response = await source.insertCounter();
    if (mounted) {
      _refreshData();

      if (ScaffoldMessenger.of(context).mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response ? "New counter added." : "An error occurred!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Local Database")),
      body: FutureBuilder(
        future: _data,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return ErrorPage(error: snapshot.error.toString());
          } else {
            if (!snapshot.hasData) {
              return Center(
                child: Text("Empty!"),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16.0,
                  children: [
                    const SizedBox(),

                    // reset database
                    OutlinedButton(
                        onPressed: () async {
                          bool response = await source.resetDb();
                          if (response) {
                            _refreshData();
                          }
                        },
                        child: const Text("Reset Database")),

                    ...snapshot.data!.map(
                      (counter) => CounterWidget(
                        id: counter['id'],
                        count: counter['count'],
                      ),
                    ),

                    const SizedBox(height: 60.0),
                  ],
                ),
              ),
            );
          }
        },
      ),

      //   floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await addNewCounter();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
