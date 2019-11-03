import 'package:birt/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email;
  String _password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/logo-bn.png');
    var image = new Image(image: assetsImage, width: 500.0);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              image,
              Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, right: 25.0, bottom: 20.0, left: 25.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          validator: (value) =>
                              value.isEmpty ? 'Please type an email' : null,
                          onSaved: (value) => _email = value,
                          decoration: InputDecoration(labelText: 'Email'),
                          // autofocus: true,
                        ),
                        TextFormField(
                          validator: (value) => value.length < 6
                              ? 'Your password need to be atleast 6 characters'
                              : null,
                          onSaved: (value) => _password = value,
                          decoration: InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: RaisedButton(
                            color: Colors.teal,
                            onPressed: signUp,
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
              RichText(
                text: new TextSpan(
                  children: [
                    new TextSpan(
                      text: 'Already have an account. ',
                      style: new TextStyle(color: Colors.black),
                    ),
                    new TextSpan(
                      text: 'Sign In.',
                      style: new TextStyle(color: Colors.teal),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(context, '/signIn'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      print('form is valid. Email: $_email, password:$_password');
      try {
        AuthResult user = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _email, password: _password));
        print(user);
        // print('signed in as ${user.uid}');
        formState.reset();
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } catch (e) {
        print(e.message);
      }
    } else {
      print('form is invalid. Email: $_email, password:$_password');
    }
  }
}
