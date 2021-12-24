import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ft_app_easy_drive/models/user_madel.dart';
import 'package:ft_app_easy_drive/pages/home.dart';
import 'package:ft_app_easy_drive/pages/home_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Verify_email extends StatefulWidget {
  Verify_email({Key? key}) : super(key: key);

  @override
  _Verify_emailState createState() => _Verify_emailState();
}

class _Verify_emailState extends State<Verify_email> {
  final form_key = GlobalKey<FormState>();
  bool isChecked = false;
  String codeOTP = "";
  String displayEmail = "";
  void initState() {
    // TODO: implement initState
    super.initState();

    User_data();
  }

  Future<Null> User_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      displayEmail = preferences.getString("Email")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Home_page()));
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
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[],
                            ),
                          ),
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
        child: Form(
          key: form_key,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Image(
                              image: AssetImage("assets/images/logo/logo.png"),
                            ),
                          ),
                          Container(
                            child: Text(
                              "Easy Drive",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo.shade800),
                            ),
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Center(
                              child: Text(
                                "กรุณากรอกรหัส OTP จาก E-mail",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.indigo.shade700),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                "ที่ทำการลงทะเบียนเพื่อยืนยันการเข้าใช้งาน",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.indigo.shade700),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 45),
                  Form_otp(),
                  SizedBox(height: 50),
                  Btn_Submit()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Text_confirm() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          "กรุณากรอกรหัส OTP จาก E-mail ที่ทำการลงทะเบียนเพื่อยืนยันการเข้าใช้งาน",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.blue.shade700),
        ),
      ),
    );
  }

  Widget Form_otp() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.vpn_key),
        hintText: 'กรุณากรอกรหัส "123456"',
        labelText: 'code OTP *',
      ),
      onChanged: (value) => setState(() {
        codeOTP = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context,
            errorText: "กรุณากรอกรหัส OTP ของคุณ")
      ]),
    );
  }

  Widget Btn_Submit() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,

      // color: Colors.amber.shade200,
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.orange.shade800),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(35.0),
            ))),
        child: Text(
          "ยืนยัน OTP",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressed: () {
          print("Submit click");
          form_key.currentState!.save();

          if (form_key.currentState!.validate()) {
            print("verify OTP");
            print("OTP = ${codeOTP}");
            //regitorThead();
            regitor_OTP();
            // postdataUser();

          }
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Login_page()));
        },
      ),
    );
  }

  Future<Null> regitor_OTP() async {
    String url =
        'http://10.0.2.2/easy_drive_backend/user/mobile/activate_email.php';
    // String url =
    //     'http://127.0.0.1/easy_drive_backend/user/mobile/register.php?New_user=true&email=$e_mail&password=$Password&first_name=$firstName&last_name=$lastName';
    //String url =
    //'http://172.27.7.226/easy_drive_backend/user/mobile/register.php';
    var dataReq = {};
    dataReq["email"] = displayEmail;
    dataReq["otp"] = codeOTP;
    print(dataReq);
    print("email = ${displayEmail}");
    print("OTP = ${codeOTP}");
    String data = jsonEncode(dataReq);
    print("${data}");
    var response = await Dio().post(url, data: data);
    print("response = ${response.toString()}");
    try {
      if (response.toString() == 'error0') {
        _showMyDialogVerify(
            "รหัส OTP ของท่านไม่ถูกต้อง\nการุณาตรวจสอบ Email อีกครั้ง");
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
          } catch (e) {}
        }
      }
    } catch (e) {
      print("ERROR");
    }
  }

  Future<Null> routeService(User_model user_model) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('ID', user_model.userId);
    preferences.setString('EMAIL', user_model.email);
    preferences.setString('FIRSTNAME', user_model.firstName);
    preferences.setString('LASTNAME', user_model.lastName);
    preferences.setString('STATUS', "login");
  }

  Future<void> _showMyDialogVerify(content) async {
    return showDialog<void>(
      context: this.context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: <Widget>[
          //       Container(
          //           // child: Center(
          //           //   child: Text("$content"),
          //           // ),
          //           ),
          //     ],
          //   ),
          // ),
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  // Container(
                  //   padding: const EdgeInsets.all(12),
                  //   child: Image(
                  //       image: AssetImage("assets/images/game_icon/exit.png")),
                  // ),
                  SizedBox(width: 20),
                  Container(
                    child: Text(
                      "${content}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
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
