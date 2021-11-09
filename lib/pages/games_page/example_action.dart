import 'package:flutter/material.dart';

class Example_action extends StatefulWidget {
  Example_action({Key? key}) : super(key: key);

  @override
  _Example_actionState createState() => _Example_actionState();
}

class _Example_actionState extends State<Example_action> {
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);
  Color _color = Colors.black;
  Color _color2 = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("เกมส์ทดสอบสายตาทางลึก"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Container(
                    height: 400,
                    width: 150,
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: _borderRadius,
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(),
                        Container(),
                        Container(),
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                child: Center(
                  child: Container(
                    height: 30,
                    width: 300,
                    decoration: BoxDecoration(
                      color: _color2,
                      borderRadius: _borderRadius,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                child: Center(
                  child: Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: _borderRadius,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Btn_1(),
                        SizedBox(width: 25),
                        Btn_2(),
                        SizedBox(width: 25),
                        Btn_3(),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget Btn_1() {
    return Container(

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Text("Red"),
            onPressed: () {}));
  }

  Widget Btn_2() {
    return Container(

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.yellow.shade700),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Text("Yellow"),
            onPressed: () {}));
  }

  Widget Btn_3() {
    return Container(

        // color: Colors.amber.shade200,
        child: ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
            child: Text("Green"),
            onPressed: () {}));
  }
}
