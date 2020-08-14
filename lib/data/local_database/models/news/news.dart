class News {
  final int id;
  final String name;
  final int hits;

  News({this.id, this.name, this.hits});

  Map<String, dynamic> toMap() {
    return {'name': name, 'hits': hits};
  }

  factory News.fromMap(dynamic id, dynamic map) {
    return News(
      id: id as int,
      name: map['name'] as String,
      hits: map['hits'] as int,
    );
  }

  News copyWith({int id, String name, int hits}) {
    return News(
      id: id ?? this.id,
      name: name ?? this.name,
      hits: hits ?? this.hits,
    );
  }
}
