class Todo {
  int? id;
  String? title;
  String? description;
  bool? completed;
  DateTime? createdAt;
  DateTime? updatedAt;

  Todo({
    this.id,
    this.title,
    this.description,
    this.completed,
    this.createdAt,
    this.updatedAt,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        completed: json['completed'] as bool?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'completed': completed,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}