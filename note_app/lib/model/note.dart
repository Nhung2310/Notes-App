class Note {
  final String id;
  final String title;
  final String content;
  final int backgroundColor;
  final int textColor;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.backgroundColor = 0xFF000000,
    this.textColor = 0xFFFFFFFF,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id']?.toString() ?? '',
      title: map['title']?.toString() ?? '',
      content: map['content']?.toString() ?? '',
      backgroundColor:
          map['backgroundColor'] is int ? map['backgroundColor'] : 0xFF000000,
      textColor: map['textColor'] is int ? map['textColor'] : 0xFFFFFFFF,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'backgroundColor': backgroundColor,
      'textColor': textColor,
    };
  }
}
