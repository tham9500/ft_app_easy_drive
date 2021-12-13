import 'package:flutter/material.dart';
import 'package:ft_app_easy_drive/pages/profile.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

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
          hintText: 'Password',
          labelText: 'Password *',
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
        FormBuilderValidators.match(context, confirmpassword,
            errorText: "รหัสไม่ถูกต้อง")
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
              "ยืนยันลงทะเบียน",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            onPressed: () {
              print("Submit click");
              form_key.currentState!.save();

              if (form_key.currentState!.validate()) {
                if (isChecked == false) {
                  _showMyDialogVerify("confirm");
                } else {
                  print("verify register");

                  print("password = ${password}");
                }
                // postdataUser();

              }
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Login_page()));
            }));
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
                      "กรุณาตกลงยอมรับเงื่อนไขการลงทะเบียน",
                      style: TextStyle(color: Colors.black),
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
