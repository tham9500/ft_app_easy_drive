import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widget/custom_shape.dart';

class Login_page extends StatefulWidget {
  Login_page({Key? key}) : super(key: key);

  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  bool _isVisible = false;

  void updateStatus() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(270.0),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/appbars/appbar.png"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Title_appbar(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          title: Text(
            "ลงทะเบียนเข้าใช้งาน",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: <Widget>[Form_username(), Form_password()],
          ),
        ),
      ),
    );
  }

  Widget Title_appbar() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            Container(
              child: Image(
                image: AssetImage("assets/images/logo/logo.png"),
              ),
            ),
            Container(
              child: Text(
                "Welcome to",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Container(
              child: Text(
                "Easy Drive",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                "Log in to continue",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Form_username() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'username@mail.com',
        labelText: 'Username *',
      ),
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }

  Widget Form_password() {
    return TextFormField(
      obscureText: _isVisible ? false : true,
      decoration: const InputDecoration(
        icon: Icon(Icons.lock),
        hintText: 'Password',
        labelText: 'Password *',
      ),
      onSaved: (String? value) {
        // This optional block of code can be used to run
        // code when the user saves the form.
      },
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }
}
