class Note { 
  final int? id;
  final String title;
  final String body;

  Note({
     this.id,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toMap() {
    return {
       'id': id,
      'title': title,
      'body': body,
    };
  }

  static Note fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      body: map['body'],
    );
  }

  String getTitle() {
    return this.title;
  }

  String getBody() {
    return this.body;
  }

}