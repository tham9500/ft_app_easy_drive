import 'dart:ui';

import 'package:flutter/material.dart';

class Verify_read extends StatefulWidget {
  Verify_read({Key? key}) : super(key: key);

  @override
  State<Verify_read> createState() => _Verify_readState();
}

class _Verify_readState extends State<Verify_read> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          title: Text("เงื่อนไขการสมัครสมาชิก"),
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
            //variable formfieldbulder
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "ข้อตกลงและเงื่อนไขการใช้งาน",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                                "   ผู้ขอสมัครสมาชิก กรุณาอ่านข้อความตกลงด้านล่างนี้โดยละเอียดเพื่อรักษาสิทธิประโยชน์ในการเป็นสมาชิกของท่าน"),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Container(
                                  child: Text(
                                      "   1. การสมัครสมาชิก แอปพลิเคชัน Easy Drive ไม่ต้องเสียค่าใช้จ่ายใดๆ ทั้งสิ้น"),
                                ),
                                Container(
                                  child: Text(
                                      "   2. ผู้สมัคร จะต้องกรอกข้อมูลรายละเอียดต่างๆ ตามจริงให้ครบถ้วน ทั้งนี้เพื่อประโยชน์แก่ตัวผู้สมัคร หากตรวจพบว่าข้อมูลของ ผู้สมัครไม่เป็นความจริง ผู้ดูแลระบบจะระงับการใช้งานของผู้สมัครโดยไม่ต้องแจ้งให้ทราบล่วงหน้า"),
                                ),
                                Container(
                                  child: Text(
                                      "   3. ผู้สมัครจะต้องรักษารหัสผ่าน หรือชื่อเข้าใช้งานในระบบสมาชิกเป็นความลับ และหากมีผู้อื่นสามารถเข้าใช้จากทางชื่อของผู้สมัครได้ ผู้ดูแลจะไม่รับผิดชอบใดๆ ทั้งสิ้น"),
                                ),
                                Container(
                                  child: Text(
                                      "   4. ทางแอปพลิเคชันขอเข้าถึงการส่งอีเมลไปยังผู้สมัครเพื่อยืนยันการใช้งานของผู้สมัคร"),
                                ),
                                Container(
                                  child: Text(
                                      "   ข้าพเจ้าผู้สมัคร ได้อ่านเงื่อนไขการสมัครแล้วและยินยอมให้ แอปพลิเคชัน Easy Drive การตรวจสอบข้อมูลส่วนตัว และ/หรือข้อมูลอื่นใดที่ผู้สมัครระบุในการสมัครสมาชิก ถ้าผู้สมัครตกลงยินยอมผูกพันและปฏิบัติตามข้อตกลงและเงื่อนไขต่างๆ ตามที่ระบุไว้ในข้อตกลงดังกล่าว รวมทั้งข้อตกลงและเงื่อนไขอื่นๆ"),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
