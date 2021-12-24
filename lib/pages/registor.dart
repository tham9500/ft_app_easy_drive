import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ft_app_easy_drive/pages/login.dart';

class Registor_page extends StatefulWidget {
  Registor_page({Key? key}) : super(key: key);

  @override
  _Registor_pageState createState() => _Registor_pageState();
}

class _Registor_pageState extends State<Registor_page> {
  String firstName = "",
      lastName = "",
      e_mail = "",
      passWord = "",
      confirmPassword = "";
  bool isChecked = false;
  bool _isVisible_password = true;
  bool _isVisible_confirm = true;
  final form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200.0),
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
                        children: [SizedBox(height: 30), Title_appbar()],
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
      body: SingleChildScrollView(
        child: Form(
          key: form_key,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Form_firstname(),
                  Form_lastname(),
                  Form_email(),
                  Form_password(),
                  Form_confirm(),
                  Check_verify(),
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

  Widget Title_appbar() {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            Container(
              child: Image(
                image: AssetImage("assets/images/logo/logo.png"),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                "ลงทะเบียนสมาชิก",
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

  Widget Form_firstname() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'กรุณากรอกชื่อ',
        labelText: 'ชื่อ *',
      ),
      onChanged: (value) => setState(() {
        firstName = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: "กรุณากรอกชื่อ")
      ]),
    );
  }

  Widget Form_lastname() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'กรุณากรอกนามสกุล',
        labelText: 'นามสกุล *',
      ),
      onChanged: (value) => setState(() {
        lastName = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: "กรุณากรอกนามสกุล")
      ]),
    );
  }

  Widget Form_email() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.mail),
        hintText: 'username@mail.com',
        labelText: 'E-mail *',
      ),
      onChanged: (value) => setState(() {
        e_mail = value;
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
      obscureText: _isVisible_password,
      decoration: InputDecoration(
          icon: Icon(Icons.vpn_key),
          hintText: 'Password',
          labelText: 'Password *',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isVisible_password = !_isVisible_password;
                });
              },
              icon: Icon(_isVisible_password
                  ? Icons.visibility_off
                  : Icons.visibility))),
      onChanged: (value) => setState(() {
        passWord = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: "กรุณากรอกรหัสผ่าน"),
        FormBuilderValidators.minLength(context, 8,
            errorText: "กรุณากรอกอย่างน้อย 8 ตัวอักษร"),
        FormBuilderValidators.match(context, confirmPassword,
            errorText: "รหัสไม่ถูกต้อง")
      ]),
    );
  }

  Widget Form_confirm() {
    return TextFormField(
      obscureText: _isVisible_confirm,
      decoration: InputDecoration(
          icon: Icon(Icons.vpn_key_outlined),
          hintText: 'Comform password',
          labelText: 'Confirm Password *',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isVisible_confirm = !_isVisible_confirm;
                });
              },
              icon: Icon(_isVisible_confirm
                  ? Icons.visibility_off
                  : Icons.visibility))),
      onChanged: (value) => setState(() {
        confirmPassword = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: "กรุณากรอกรหัสผ่าน"),
        FormBuilderValidators.minLength(context, 8,
            errorText: "กรุณากรอกอย่างน้อย 8 ตัวอักษร"),
        FormBuilderValidators.match(context, passWord,
            errorText: "รหัสไม่ถูกต้อง")
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
          "ยืนยันลงทะเบียน",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        onPressed: () {
          print("Submit click");
          form_key.currentState!.save();

          if (form_key.currentState!.validate()) {
            if (isChecked == false) {
              _showMyDialogVerify("กรุณายีนยันนโยบายก่อนทำ\nการลงทะเบียน");
            } else {
              print("verify register");
              print("firstname = ${firstName}");
              print("lastname = ${lastName}");
              print("email = ${e_mail}");
              print("password = ${passWord}");
              //regitorThead();
              checkUser();
            }
            // postdataUser();

          }
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => Login_page()));
        },
      ),
    );
  }

  Future<Null> checkUser() async {
    Dio dio = new Dio();
    String url =
        'http://10.0.2.2/easy_drive_backend/user/mobile/validateUser.php?isAdd=true&email=$e_mail';
    // String url =
    //     'http://127.0.0.1/easy_drive_backend/user/mobile/validateUser.php?isAdd=true&email=$e_mail';
    try {
      Response response = await Dio().get(url);
      print("response = ${response}");
      if (response.toString() == "haveUser") {
        _showMyDialogVerify("มี Email อยู่ในระบบกรุณาใช้ \nEmail อื่น");
      } else if (response.toString() != "null") {
        regitorThead();
      }
    } catch (e) {
      print("ERROR");
    }
  }

  Future<Null> regitorThead() async {
    Dio dio = new Dio();
    String url = 'http://10.0.2.2/easy_drive_backend/user/mobile/register.php';
    // String url =
    //     'http://127.0.0.1/easy_drive_backend/user/mobile/register.php?New_user=true&email=$e_mail&password=$Password&first_name=$firstName&last_name=$lastName';
    //String url =
    //'http://172.27.7.226/easy_drive_backend/user/mobile/register.php';
    var dataReq = {};
    dataReq["email"] = e_mail;
    dataReq["password"] = passWord;
    dataReq["first_name"] = firstName;
    dataReq["last_name"] = lastName;

    var data = jsonEncode(dataReq);
    print("data send = ${data}");
    var response = await Dio().post(url, data: data);
    print(response.toString());
    try {
      print(url);

      if (response.toString() == 'workingcomplete') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login_page()));
      } else if (response.toString() == 'workinghaveUser') {
        _showMyDialogVerify("มี email นี้อยู่ในระบบแล้ว");
      }
    } catch (e) {
      print("ERROR");
    }
  }

  Widget Check_verify() {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
              child: Checkbox(
                  value: isChecked,
                  onChanged: (verify) {
                    setState(() {
                      isChecked = verify!;
                    });
                  })),
          Container(
            child: Text("data"),
          ),
        ],
      ),
    );
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
