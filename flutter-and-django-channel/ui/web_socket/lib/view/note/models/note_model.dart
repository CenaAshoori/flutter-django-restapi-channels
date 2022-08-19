class Note {
  int? id;
  String? title;
  String? text;
  int? user;

  Note({this.id, this.title, this.text, this.user});

  Note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    text = json['text'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['text'] = this.text;
    data['user'] = this.user;
    return data;
  }
}
