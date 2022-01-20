import 'package:flutter/material.dart';
import 'package:form_login/src/blocs/login_bloc.dart';
import 'package:form_login/src/resources/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc bloc = new LoginBloc();

  bool _showPass = false;
  TextEditingController _userController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false, // set it to false
      body: Container(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Container(
                  width: 70,
                  height: 70,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey[400]),
                  child: const FlutterLogo(),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Text(
                  "Hello\nWelcome Back",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: StreamBuilder(
                    stream: bloc.userStream,
                    builder: (context, snapshot) => TextField(
                      style: TextStyle(fontSize: 18),
                      controller: _userController,
                      decoration: InputDecoration(
                        labelText: "USERNAME",
                        errorText: snapshot.hasError
                            ? snapshot.error.toString()
                            : null,
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: <Widget>[
                    StreamBuilder(
                      stream: bloc.passStream,
                      builder: (context, snapshot) => TextField(
                        style: TextStyle(fontSize: 18),
                        controller: _passController,
                        obscureText: !_showPass,
                        decoration: InputDecoration(
                          labelText: "PASSWORD",
                          errorText: snapshot.hasError
                              ? snapshot.error.toString()
                              : null,
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onToggleShowPass,
                      child: Text(
                        _showPass ? "HIDE" : "SHOW",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: RaisedButton(
                    color: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    onPressed: onSignInClicked,
                    child: const Text(
                      "SIGN IN",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 130,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "NEW USER? SIGN UP",
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    const Text(
                      "FORGOT PASSWORD?",
                      style: TextStyle(fontSize: 15, color: Colors.blue),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void onSignInClicked() {
    if (bloc.isValidInfo(_userController.text, _passController.text)) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  Widget goToHome(BuildContext context) {
    return HomePage();
  }
}
