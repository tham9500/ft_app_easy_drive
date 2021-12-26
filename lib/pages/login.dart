import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ft_app_easy_drive/models/user_madel.dart';
import 'package:ft_app_easy_drive/pages/forget_page.dart';
import 'package:ft_app_easy_drive/pages/home.dart';
import 'package:ft_app_easy_drive/pages/home_login.dart';
import 'package:ft_app_easy_drive/pages/registor.dart';
import 'package:ft_app_easy_drive/pages/verify_email.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget/custom_shape.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Login_page extends StatefulWidget {
  Login_page({Key? key}) : super(key: key);

  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  String username = "", Password = "";
  final form_key = GlobalKey<FormState>();
  List<dynamic> data_user = [];
  bool _isVisible = true;
  var user_data;

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
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
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
          // title: Text(
          //   "ลงทะเบียนเข้าใช้งาน",
          //   style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          // ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: form_key,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Form_username(),
                  Form_password(),
                  Container(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: <Widget>[
                          Btn_ForgetPassword(),
                        ],
                      ),
                    ),
                  ),
                  Btn_StateLogin(),
                  SizedBox(height: 20),
                  Btn_registor(),
                ],
              ),
            ),
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
      onChanged: (value) => setState(() {
        username = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: "กรุณากรอก Email"),
        FormBuilderValidators.email(context,
            errorText: "Email ไม่ถูกต้องตัวอย่างเช่น name@mail.com")
      ]),
    );
  }

  Widget Form_password() {
    return TextFormField(
      obscureText: _isVisible,
      decoration: InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Password',
          labelText: 'Password *',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isVisible = !_isVisible;
                });
              },
              icon:
                  Icon(_isVisible ? Icons.visibility_off : Icons.visibility))),
      onChanged: (value) => setState(() {
        Password = value;
      }),
      validator: (String? value) {
        return (value != null && value.contains('@'))
            ? 'Do not use the @ char.'
            : null;
      },
    );
  }

  Widget Btn_registor() {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ))),
            child: Text(
              "ลงทะเบียน",
              style: TextStyle(fontSize: 18, color: Colors.orange.shade800),
            ),
            onPressed: () {
              print("registor click");

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Registor_page()));
            }));
  }

  Future<void> login() async {
    // var dio = Dio();
    // final response = await dio.get('https://google.com');
    // print(response.data);
    Dio dio = new Dio();
    // String url = "http://172.27.7.226/easy_drive_backend/user/mobile/login.php";
    String url = "http://10.0.2.2/easy_drive_backend/user/mobile/login.php";
    var dataReq = {};
    dataReq["email"] = username;
    dataReq["password"] = Password;
    String data = jsonEncode(dataReq);
    var response = await Dio().post(url, data: data);
    print("response = ${response.toString()}");
    if (response.toString() == "email or passwoed incorret") {
      _showMyDialogPass("email และ password ของท่าน\nไม่ถูกต้องกรุณาลองใหม่");
    } else if (response.toString() == "email not verified") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('verify_email', username);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Verify_email()));
    } else if (response.toString() == "suspended") {
      _showMyDialogPass(
          "บัญชีของท่านถูระงับการใช้งาน \nกรุณาติดต่อ \nserviceeasydrive@gmail.com");
    } else {
      var result = json.decode(response.data);
      print("result = ${result}");
      print(result.runtimeType);
      for (var map in result) {
        try {
          User_model user_model = User_model.fromJson(map);
          routeService(user_model);
          print("login complete");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home_login()));
        } catch (e) {
          print("ERROR LOGIN");
        }
      }
    }

    print("user_data=${data_user.toString()}");
  }

//verify query datbase check active OTP

//set account to device
  Future<Null> routeService(User_model user_model) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('ID', user_model.userId);
    preferences.setString('EMAIL', user_model.email);
    preferences.setString('FIRSTNAME', user_model.firstName);
    preferences.setString('LASTNAME', user_model.lastName);
    preferences.setString('STATUS', "login");
  }

  Future<Null> setemail_verify() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('Email', username);
  }

  Widget Btn_ForgetPassword() {
    return Container(
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black45,
          textStyle: const TextStyle(
            fontSize: 16,
          ),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => forget_page()));
        },
        child: Text(
          'ลืมรหัสผ่าน ?',
          textAlign: TextAlign.right,
        ),
      ),
    );
  }

  Widget Btn_StateLogin() {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.orange.shade700),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ))),
            child: Text(
              "เข้าสู่ระบบ",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              print("login click");
              form_key.currentState!.save();

              if (form_key.currentState!.validate()) {
                print("username = ${username}");
                print("username = ${Password}");
                setemail_verify();
                login();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Home_login()));
                // postdataUser();

              }
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Registor_page()));
            }));
  }

  Future<void> _showMyDialogPass(content) async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  SizedBox(width: 20),
                  Container(
                    child: Text(
                      "${content}",
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    child: TextButton(
                      child: const Text(
                        'ตกลง',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                      onPressed: () => Navigator.pop(context, true),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
