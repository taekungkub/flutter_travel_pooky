import 'package:firebase_database/firebase_database.dart';

class Test {
  String _id;
  String _name;
  String _email;
  String _tel;
  String _title;
  String _issue;

  Test(
    this._name,
    this._email,
    this._tel,
    this._title,
    this._issue,
  );

  Test.map(dynamic obj) {
    this._id = obj['id'];
    this._name = obj['name'];
    this._email = obj['email'];
    this._tel = obj['time'];
    this._title = obj['title'];
    this._issue = obj['issue'];
  }

  String get id => _id;
  String get name => _name;
  String get email => _email;
  String get tel => _tel;
  String get title => _title;
  String get issue => _issue;

  Test.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _name = snapshot.value['name'];
    _email = snapshot.value['email'];
    _tel = snapshot.value['tel'];
    _title = snapshot.value['title'];
    _issue = snapshot.value['issue'];
  }
}
