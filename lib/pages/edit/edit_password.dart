import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/profile.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit_password extends StatefulWidget {
  Edit_password({Key? key}) : super(key: key);

  @override
  _Edit_passwordState createState() => _Edit_passwordState();
}

class _Edit_passwordState extends State<Edit_password> {
  String password = "", confirmpassword = "", old_password = "";
  bool isChecked = false;
  bool _isVisible_password_old = true;
  bool _isVisible_password = true;
  bool _isVisible_confirm = true;
  final form_key = GlobalKey<FormState>();
  String id = "";
  String status = "";
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
      id = preferences.getString("ID")!;
    });
    print("ID = ${id}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false, //move back button
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
                    image: AssetImage("assets/images/appbars/appbar1.png"),
                    fit: BoxFit.fill),
              ),
              padding: EdgeInsets.all(35),
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
                              children: <Widget>[],
                            ),
                          ),
                          SizedBox(height: 30),
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
              padding: const EdgeInsets.all(30),
              child: Column(
                children: <Widget>[
                  Title_appbar(),
                  Form_Old_password(),
                  Form_password(),
                  Form_confirm(),
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
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade50,
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage("assets/images/logo/pass-setting.png"),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              child: Text(
                "แก้ไขรหัสผ่าน",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Form_Old_password() {
    return TextFormField(
      obscureText: _isVisible_password_old,
      decoration: InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Old Password',
          labelText: 'Old Password *',
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isVisible_password_old = !_isVisible_password_old;
                });
              },
              icon: Icon(_isVisible_password_old
                  ? Icons.visibility_off
                  : Icons.visibility))),
      onChanged: (value) => setState(() {
        old_password = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context,
            errorText: "กรุณากรอกรหัสผ่านเก่า"),
        FormBuilderValidators.minLength(context, 8,
            errorText: "กรุณากรอกอย่างน้อย 8 ตัวอักษร"),
      ]),
    );
  }

  Widget Form_password() {
    return TextFormField(
      obscureText: _isVisible_password,
      decoration: InputDecoration(
          icon: Icon(Icons.vpn_key),
          hintText: 'New Password',
          labelText: 'New Password *',
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
        FormBuilderValidators.required(context,
            errorText: "กรุณากรอกรหัสผ่านใหม่"),
        FormBuilderValidators.minLength(context, 8,
            errorText: "กรุณากรอกอย่างน้อย 8 ตัวอักษร"),
        FormBuilderValidators.match(context, confirmpassword,
            errorText: "รหัสไม่ถูกต้อง")
      ]),
    );
  }

  Widget Form_confirm() {
    return TextFormField(
      obscureText: _isVisible_confirm,
      decoration: InputDecoration(
          icon: Icon(Icons.vpn_key_outlined),
          hintText: 'Comform New password',
          labelText: 'Confirm New Password *',
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
        confirmpassword = value;
      }),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(context,
            errorText: "กรุณากรอกรหัสผ่านใหม่"),
        FormBuilderValidators.minLength(context, 8,
            errorText: "กรุณากรอกอย่างน้อย 8 ตัวอักษร"),
        FormBuilderValidators.match(context, password,
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
              "ยืนยัน",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () {
              print("Submit click");
              form_key.currentState!.save();

              if (form_key.currentState!.validate()) {
                Submit();
              } else {
                _showMyDialogPass("รหัสผ่านใหม่ไม่ถูกต้อง \nกรุณากรอกใหม่");
              }
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Login_page()));
            }));
  }

  Future<void> Submit() async {
    Dio dio = new Dio();
    String url =
        "http://10.0.2.2/easy_drive_backend/user/mobile/edit_password.php?user_id=$id";
    var dataReq = {};

    dataReq["password_old"] = old_password;
    dataReq["password_new"] = password;
    String data = jsonEncode(dataReq);
    var response = await Dio().put(url, data: data);
    print(response);
    print("res = ${response.toString()}");
    print("return = ${response}");
    print(data);

    try {
      if (response.toString() == "password old correctcomplete") {
        _showMyDialogPass("บันทึกสำเร็จ");
      } else if (response.toString() == "password old incorrect") {
        _showMyDialogPass("บันทึกไม่สำเร็จ");
      }
    } catch (e) {}
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
                      onPressed: () {
                        if (content == "บันทึกไม่สำเร็จ") {
                          Navigator.pop(context, true);
                        } else if (content == "บันทึกสำเร็จ") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile_user()));
                        }
                      },
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
