import 'package:firebase_database/firebase_database.dart';

class Travel {
  String _id;
  String _title;
  String _name;
  String _time;
  String _call;
  String _address;
  String _track;
  String _desc;
  String _imageUrl;
  String _imageUrl2;
  String _imageUrl3;
  String _imageUrl4;
  int _view;

  Travel(
    this._id,
    this._title,
    this._name,
    this._time,
    this._call,
    this._address,
    this._track,
    this._desc,
    this._imageUrl,
    this._imageUrl2,
    this._imageUrl3,
    this._imageUrl4,
    this._view,
  );

  Travel.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._name = obj['name'];
    this._time = obj['time'];
    this._call = obj['call'];
    this._address = obj['address'];
    this._track = obj['track'];
    this._desc = obj['desc'];
    this._imageUrl = obj['imageURL'];
    this._imageUrl2 = obj['imageURL2'];
    this._imageUrl3 = obj['imageURL3'];
    this._imageUrl4 = obj['imageURL4'];
    this._view = obj['view'];
  }

  String get id => _id;
  String get title => _title;
  String get name => _name;
  String get time => _time;
  String get call => _call;
  String get address => _address;
  String get track => _track;
  String get desc => _desc;
  String get imageUrl => _imageUrl;
  String get imageUrl2 => _imageUrl2;
  String get imageUrl3 => _imageUrl3;
  String get imageUrl4 => _imageUrl4;
  int get view => _view;

  Travel.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.value['title'];
    _name = snapshot.value['name'];
    _time = snapshot.value['time'];
    _call = snapshot.value['call'];
    _address = snapshot.value['address'];
    _track = snapshot.value['track'];
    _desc = snapshot.value['desc'];
    _imageUrl = snapshot.value['imageURL'];
    _imageUrl2 = snapshot.value['imageURL2'];
    _imageUrl3 = snapshot.value['imageURL3'];
    _imageUrl4 = snapshot.value['imageURL4'];
    _view = snapshot.value['view'];
  }
}
