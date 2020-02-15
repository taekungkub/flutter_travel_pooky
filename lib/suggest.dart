import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();
GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

final userRef = FirebaseDatabase.instance.reference().child('suggestion');

final nameCon = TextEditingController();
final emailCon = TextEditingController();
final telCon = TextEditingController();
final titleCon = TextEditingController();
final issueCon = TextEditingController();

class SuggestPage extends StatefulWidget {
  @override
  _SuggestPageState createState() => _SuggestPageState();
}

class _SuggestPageState extends State<SuggestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Send Feedback"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  nameInput(),
                  emailInput(),
                  telInput(),
                  titleInput(),
                  issueInput(),
                  SizedBox(
                    height: 20,
                  ),
                  btnSubmit(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget nameInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: TextFormField(
        autofocus: false,
        controller: nameCon,
        decoration: InputDecoration(
          labelText: 'ชื่อ-สกุล',
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(5.0),
            ),
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'This field can\'t be empty' : null,
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: TextFormField(
        autofocus: false,
        controller: emailCon,
        decoration: InputDecoration(
          labelText: 'อีเมลล์',
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(5.0),
            ),
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'This field can\'t be empty' : null,
      ),
    );
  }

  Widget telInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: TextFormField(
        autofocus: false,
        controller: telCon,
        maxLength: 10,
        keyboardType: TextInputType.numberWithOptions(),
        decoration: InputDecoration(
          labelText: 'เบอร์โทรศัพท์',
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(5.0),
            ),
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'This field can\'t be empty' : null,
      ),
    );
  }

  Widget titleInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: TextFormField(
        autofocus: false,
        controller: titleCon,
        decoration: InputDecoration(
          labelText: 'เรื่อง',
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(5.0),
            ),
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'This field can\'t be empty' : null,
      ),
    );
  }

  Widget issueInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: TextFormField(
        maxLines: 8,
        autofocus: false,
        controller: issueCon,
        decoration: InputDecoration(
          labelText: 'รายละเอียด',
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(5.0),
            ),
          ),
        ),
        validator: (value) =>
            value.isEmpty ? 'This field can\'t be empty' : null,
      ),
    );
  }

  Widget btnSubmit() {
    return Container(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(5.0),
          ),
          onPressed: () {
            submit();
          },
          color: Colors.blueAccent,
          textColor: Colors.white,
          child: Text('Submit'),
        ),
      ),
    );
  }

  void submit() {
    final form = _formKey.currentState;

    if (form.validate()) {
      final userRef =
          FirebaseDatabase.instance.reference().child('suggestion').push().set({
        "name": nameCon.text,
        "email": emailCon.text,
        "tel": telCon.text,
        "title": titleCon.text,
        "issue": issueCon.text,
      });

      nameCon.text = '';
      emailCon.text = '';
      telCon.text = '';
      titleCon.text = '';
      issueCon.text = '';
    }
  }
}
