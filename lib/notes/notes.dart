class Notes {
  String id;
  bool isImportant;
  String title;
  String description;
  DateTime time;

  Notes({required this.id, required this.isImportant, required this.title, required this.description, required this.time});

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      id: json['id'].toString(),
      isImportant: json['isImportant'] == true,
      title: json['last_name'].toString(),
      description: json['last_name'].toString(),
      time: DateTime.parse(json['time'].toString()),
    );
  }
}