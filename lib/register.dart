import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'services/auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final nameController = TextEditingController();
  final emailCon = TextEditingController();
  final passwordCon = TextEditingController();
  final cfPasswordCon = TextEditingController();

  bool passwordVisible = true;
  bool cfpasswordVisible = true;

  @override
  void initState() {
    passwordVisible = true;
    cfpasswordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("เพิ่มแอดมิน"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                nameInput(),
                emailInpit(),
                passwordInput(),
                cgPasswordInput(),
                SizedBox(
                  height: 20,
                ),
                btnSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nameInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16, right: 16),
      child: TextFormField(
        autofocus: false,
        controller: nameController,
        decoration: InputDecoration(
          labelText: 'ชื่อ-สกุล',
          prefixIcon: Icon(FontAwesomeIcons.user),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
        validator: (value) => value.isEmpty ? 'Title can\'t be empty' : null,
      ),
    );
  }

  Widget emailInpit() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: TextFormField(
        autofocus: false,
        controller: emailCon,
        decoration: InputDecoration(
          labelText: 'Email',
          prefixIcon: Icon(Icons.email),
          border: new OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0),
            ),
          ),
        ),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: passwordCon,
          obscureText: passwordVisible, //This will obscure text dynamically
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(FontAwesomeIcons.lock),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            ),
          ),
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
        ));
  }

  Widget cgPasswordInput() {
    return Padding(
        padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
        child: TextFormField(
          keyboardType: TextInputType.text,
          controller: cfPasswordCon,
          obscureText: cfpasswordVisible, //This will obscure text dynamically
          decoration: InputDecoration(
            labelText: 'Confirm, Password',
            prefixIcon: Icon(FontAwesomeIcons.lock),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                cfpasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () {
                // Update the state i.e. toogle the state of passwordVisible variable
                setState(() {
                  cfpasswordVisible = !cfpasswordVisible;
                });
              },
            ),
          ),
          validator: (value) =>
              value.isEmpty ? 'Confirm Password can\'t be empty' : null,
        ));
  }

  Widget btnSubmit() {
    return Container(
      padding: EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.white)),
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

  Widget showSuccress(_successMsg) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(_successMsg, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.green,
    ));
  }

  Widget showErrorSnackbar(_errorMessage) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(_errorMessage, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
    ));
  }

  void submit() {
    String name = nameController.text.trim();
    String email = emailCon.text.trim();

    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);

    String password = passwordCon.text;
    String confirmPassword = cfPasswordCon.text.trim();

    var role = "admin";

    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (emailValid == false) {
        var _errorMessage = "Email is not format.";
        showErrorSnackbar(_errorMessage);
      }
      if (password == confirmPassword && password.length >= 6) {
        AuthService.signUpUser(context, name, email, password, role);
        var text = "Success Account has Created";
        showSuccress(text);

        nameController.text = '';
        emailCon.text = '';
        passwordCon.text = '';
        cfPasswordCon.text = '';
      } else {
        var _errorMessage = "Password and Confirm-password is not match.";
        showErrorSnackbar(_errorMessage);
      }
    }
    setState(() {});

    print(email);
  }
}
