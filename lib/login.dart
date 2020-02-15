import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'user.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String _errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    checkAuth(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: stack(),
    );
  }

  Widget stack() {
    return Stack(
      children: <Widget>[
        Form(
          key: _formKey,
          child: showBody(),
        ),
        _showCircularProgress(),
        showAppbar(),
      ],
    );
  }

  Widget showBody() {
    return ListView(
      children: <Widget>[
        showLogo(),
        SizedBox(
          height: 30,
        ),
        showEmailInput(),
        SizedBox(
          height: 20,
        ),
        showPasswordInput(),
        SizedBox(
          height: 40,
        ),
        showLoginButton(),
        SizedBox(
          height: 20,
        ),
        // showSignup()
      ],
    );
  }

  Widget showLogo() {
    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Icon(
                Icons.people,
                color: Colors.blue,
                size: 60,
              ),
              Text(
                "Welcome",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                    fontSize: 30),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          width: double.infinity,
        ),
      ],
    );
  }

  Widget showEmailInput() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: TextFormField(
          autofocus: false,
          controller: emailController,
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: Icon(Icons.people),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
          ),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        ));
  }

  Widget showPasswordInput() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: TextFormField(
          autofocus: false,
          controller: passwordController,
          maxLines: 1,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
            ),
          ),
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
        ));
  }

  Widget showLoginButton() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              color: Colors.blue),
          child: FlatButton(
            child: Text(
              "Login",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18),
            ),
            onPressed: () {
              signIn();
              print("signIn");
            },
          ),
        ));
  }

  Widget showSignup() {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            "FORGOT PASSWORD ?",
            style: TextStyle(
                color: Colors.blue, fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Don't have an Account ? ",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
            ),
            InkWell(
              child: Text("Sign Up ",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      decoration: TextDecoration.underline)),
              // onTap: () => Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => RegisterPage())),
            ),
          ],
        )
      ],
    );
  }

  Widget showAppbar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 20.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showErrorSnackbar(_errorMessage) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(_errorMessage, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
    ));
  }

  void signIn() async {
    setState(() {
      _isLoading = true;
    });
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
    }
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseUser user = result.user;

      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserPage(user)));
      }
      print('${user.email}');
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.message;
        showErrorSnackbar(_errorMessage);
      });
      print(e.message);
    }
  }

  Future checkAuth(BuildContext context) async {
    FirebaseUser user = await _auth.currentUser();

    if (user != null) {
      setState(() {
        _isLoading = true;
      });

      final userRef =
          FirebaseDatabase.instance.reference().child('users').child(user.uid);

      print("Already singed-in with");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserPage(user)));
    } else {
      print("no have user");
    }
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}
