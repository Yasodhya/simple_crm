class Note {
  int? id;
  int customerId; // Foreign key to Customer
  String title;
  String description;
  String date;

  Note({
    this.id,
    required this.customerId,
    required this.title,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'title': title,
      'description': description,
      'date': date,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      customerId: map['customerId'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
    );
  }
}

