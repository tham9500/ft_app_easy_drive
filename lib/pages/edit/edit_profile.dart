import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:ft_app_easy_drive/connect/connect.dart';
import 'package:ft_app_easy_drive/models/user_madel.dart';
import 'package:ft_app_easy_drive/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit_profile extends StatefulWidget {
  Edit_profile({Key? key}) : super(key: key);

  @override
  _Edit_profileState createState() => _Edit_profileState();
}

class _Edit_profileState extends State<Edit_profile> {
  String id = "", firstname = "", lastname = "", email = "", password = "";
  bool isChecked = false;
  bool _isVisible_password = true;
  bool _isVisible_confirm = true;
  final form_key = GlobalKey<FormState>();

  String displayID = "";
  String displayFirstname = "";
  String displayLastname = "";
  String displayEmail = "";
  String status = "";
  TextEditingController f_name = TextEditingController();
  TextEditingController l_name = TextEditingController();
  TextEditingController e_Mail = TextEditingController();

  void initState() {
    // TODO: implement initState
    super.initState();

    Check_status();
  }

  Future<Null> Check_status() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      status = preferences.getString("STATUS")!;
    });
    if (status == "login") {
      print("login complete");
      User_data();
    } else {
      print("Not login");
    }
  }

  Future<Null> User_data() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      displayID = preferences.getString("ID")!;
      displayFirstname = preferences.getString("FIRSTNAME")!;
      displayLastname = preferences.getString("LASTNAME")!;
      displayEmail = preferences.getString("EMAIL")!;
      f_name.text = preferences.getString("FIRSTNAME")!;
      l_name.text = preferences.getString("LASTNAME")!;
      e_Mail.text = preferences.getString("EMAIL")!;
      id = preferences.getString("ID")!;
    });
    print("ID = ${displayID}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
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
                children: <Widget>[],
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
        padding: const EdgeInsets.all(12),
        child: Form(
          key: form_key,
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Title_appbar(),
                  Form_firstname(),
                  Form_lastname(),
                  Form_email(),
                  Form_password(),
                  SizedBox(height: 20),
                  Btn_StateSubmit()
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
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade50,
                shape: BoxShape.circle,
                // image: const DecorationImage(
                //   image: AssetImage("assets/images/logo/profile-setting.png"),
                // ),
              ),
              child: Icon(
                Icons.person_rounded,
                size: 50,
                color: Colors.red.shade700,
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                "โปรไฟล์ของฉัน",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.blue.shade800),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Form_firstname() {
    return TextFormField(
      controller: f_name,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        // hintText: 'กรุณากรอกชื่อ',
        labelText: 'ชื่อ *',
      ),
      onChanged: (value) => setState(() {
        firstname = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: "กรุณากรอกชื่อ")
      ]),
    );
  }

  Widget Form_lastname() {
    return TextFormField(
      controller: l_name,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'กรุณากรอกนามสกุล',
        labelText: 'นามสกุล *',
      ),
      onChanged: (value) => setState(() {
        lastname = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: "กรุณากรอกนามสกุล")
      ]),
    );
  }

  Widget Form_email() {
    return TextFormField(
      controller: e_Mail,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        enabled: false,
        icon: Icon(Icons.mail),
        hintText: 'username@mail.com',
        labelText: 'E-mail *',
      ),
      onChanged: (value) => setState(() {
        email = value;
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
        password = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context, errorText: "กรุณากรอกรหัสผ่าน"),
        FormBuilderValidators.minLength(context, 8,
            errorText: "กรุณากรอกอย่างน้อย 8 ตัวอักษร"),
        FormBuilderValidators.match(context, password,
            errorText: "รหัสไม่ถูกต้อง")
      ]),
    );
  }

  Widget Btn_StateSubmit() {
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
              "ยืนยัน",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              print("submit click");
              form_key.currentState!.save();

              if (form_key.currentState!.validate()) {
                routeService();
                login();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Home_login()));
                // postdataUser();

              }
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Registor_page()));
            }));
  }

  Future<void> login() async {
    Dio dio = new Dio();
    String url =
        "${Domain_name().domain}/easy_drive_backend/user/mobile/edit_name.php?user_id=$id";
    var dataReq = {};
    if (firstname == "") {
      firstname = displayFirstname;
    } else if (lastname == "") {
      lastname = displayLastname;
    } else if (email == "") {
      email = displayEmail;
    }
    dataReq["first_name"] = firstname;
    dataReq["last_name"] = lastname;
    dataReq["password"] = password;
    String data = jsonEncode(dataReq);
    var response = await Dio().put(url, data: data);
    print(response);
    print("res = ${response.toString()}");
    print("return = ${response}");
    if (response.toString() == "password incorrect") {
      _showMyDialogPass("รหัสของท่านไม่ถูกต้อง \nกรุณาลองใหม่");
    } else if (response.toString() == "password correctcomplete") {
      _showMyDialogPass("บันทึกสำเร็จ");
    }
    try {} catch (e) {}
  }

  Future<Null> routeService() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('FIRSTNAME', firstname);
    preferences.setString('LASTNAME', lastname);
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
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Profile_user())),
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
