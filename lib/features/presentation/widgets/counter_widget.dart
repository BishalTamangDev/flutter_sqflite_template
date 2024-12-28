import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqflite_git/features/data/data_sources/source.dart';

class CounterWidget extends StatefulWidget {
  CounterWidget({
    super.key,
    required this.id,
    required this.count,
  });

  final int id;
  int count;

  @override
  State<StatefulWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  Source source = Source.getInstance();

  bool visible = true;

  // function // update counter
  Future<void> _updateCounter(int id, int count) async {
    bool response = await source.updateCounter(id, count);
    if (response) {
      setState(() {
        widget.count = count;
      });
    }
  }

  // delete counter
  Future<void> _deleteCounter(int id) async {
    bool response = await source.deleteCounter(id);
    if (response) {
      setState(() {
        visible = false;
      });
    }
    log("Counter deletion: $response");
  }

  @override
  Widget build(BuildContext context) {
    return !visible
        ? Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              child: Center(
                child: Opacity(
                  opacity: 0.5,
                  child: const Text("Counter deleted"),
                ),
              ),
            ),
          )
        : Card(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
                bottom: 10.0,
                left: 16.0,
                right: 16.0,
              ),
              child: Column(
                spacing: 14.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    spacing: 8.0,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        " Count",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        widget.count.toString(),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 1.0,
                    color: Colors.grey,
                  ),
                  Row(
                    spacing: 8.0,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 8.0,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              _updateCounter(widget.id, widget.count + 1);
                            },
                            child: const Text("Increase"),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              if (widget.count > 0) {
                                _updateCounter(widget.id, widget.count - 1);
                              }
                            },
                            child: const Text("Decrease"),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          _deleteCounter(widget.id);
                        },
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
