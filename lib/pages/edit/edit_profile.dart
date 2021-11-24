import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Edit_profile extends StatefulWidget {
  Edit_profile({Key? key}) : super(key: key);

  @override
  _Edit_profileState createState() => _Edit_profileState();
}

class _Edit_profileState extends State<Edit_profile> {
  String firstname = "", lastname = "", email = "", password = "";
  bool isChecked = false;
  bool _isVisible_password = true;
  bool _isVisible_confirm = true;
  final form_key = GlobalKey<FormState>();
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
                  Form_password()
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
        FormBuilderValidators.match(context, password,
            errorText: "รหัสไม่ถูกต้อง")
      ]),
    );
  }
}
