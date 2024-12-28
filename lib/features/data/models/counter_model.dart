class Counter {
  int? id;
  int? count;
  String? name;

//<editor-fold desc="Data Methods">
  Counter({
    this.id = 0,
    this.count = 0,
    this.name = "Counter",
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Counter &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          count == other.count &&
          name == other.name);

  @override
  int get hashCode => id.hashCode ^ count.hashCode ^ name.hashCode;

  @override
  String toString() {
    return 'Counter{' + ' id: $id,' + ' count: $count,' + ' name: $name,' + '}';
  }

  Counter copyWith({
    int? id,
    int? count,
    String? name,
  }) {
    return Counter(
      id: id ?? this.id,
      count: count ?? this.count,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'count': count,
      'name': name,
    };
  }

  factory Counter.fromMap(Map<String, dynamic> map) {
    return Counter(
      id: map['id'] as int,
      count: map['count'] as int,
      name: map['name'] as String,
    );
  }

//</editor-fold>
}