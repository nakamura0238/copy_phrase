class Phrase {
  int? id;
  String? title;
  String? phrase;

  Phrase({this.title, this.phrase});
  Phrase.withId({this.id, this.title, this.phrase});

  Map<String, dynamic> phraseMap() {
    final map = <String, dynamic>{};
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['phrase'] = phrase;

    return map;
  }

  Phrase fromMap(Map<String, dynamic> map) {
    return Phrase.withId(
      id: map['id'], title: map['title'], phrase: map['phrase']
    );
  }
}