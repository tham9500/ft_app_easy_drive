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
            SizedBox(height: 30),
            Container(
              child: Image(
                image: AssetImage("assets/images/logo/logo.png"),
              ),
            ),
            SizedBox(height: 25),
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
      decoration: const InputDecoration(
        icon: Icon(Icons.vpn_key),
        hintText: 'Password',
        labelText: 'Password *',
      ),
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
      decoration: const InputDecoration(
        icon: Icon(Icons.vpn_key_outlined),
        hintText: 'Comform password',
        labelText: 'Confirm Password *',
      ),
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
                // postdataUser();

              }
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Login_page()));
            }));
  }

  Widget Check_verify() {
    return Container();
  }
}
