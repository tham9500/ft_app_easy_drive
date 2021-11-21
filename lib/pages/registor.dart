import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Registor_page extends StatefulWidget {
  Registor_page({Key? key}) : super(key: key);

  @override
  _Registor_pageState createState() => _Registor_pageState();
}

class _Registor_pageState extends State<Registor_page> {
  String firstname = "",
      lastname = "",
      email = "",
      password = "",
      confirmpassword = "";
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
        firstname = value;
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
        lastname = value;
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
        FormBuilderValidators.required(context, errorText: "กรุณากรอกรหัสผ่าน"),
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
                  print("firstname = ${firstname}");
                  print("lastname = ${lastname}");
                  print("email = ${email}");
                  print("password = ${password}");
                }
                // postdataUser();

              }
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Login_page()));
            }));
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
