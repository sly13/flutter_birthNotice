import 'package:birt/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignInPage> {
  String _email;
  String _password;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/logo-bn.png');
    var image = new Image(image: assetsImage, width: 400.0);

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
                          initialValue: 'vadim@gmail.com',
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
                          initialValue: '123456',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: RaisedButton(
                            color: Colors.teal,
                            onPressed: signIn,
                            child: Text(
                              'Sign In',
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
                      text: 'Don\'t have an account yet? ',
                      style: new TextStyle(color: Colors.black),
                    ),
                    new TextSpan(
                      text: 'Sign Up.',
                      style: new TextStyle(color: Colors.teal),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(context, '/signUp'),
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

  Future<void> signIn() async {
    final formState = formKey.currentState;
    if (formState.validate()) {
      formState.save();
      print('form is valid. Email: $_email, password:$_password');
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print(user);
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
