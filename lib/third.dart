import 'package:flutter/material.dart';
import 'fourth.dart';

class ThirdWidget extends StatelessWidget {
  final String params;

  ThirdWidget({Key key, this.params}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //跳转到第二个Flutter页面
  _jumpToSecond() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return FourthWidget();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Text(
                '这是第一个Flutter页面\n点击跳转到第二个Flutter页面',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.green
                ),
              ),
              onTap: () {
                _jumpToSecond();
              },
            ),
          ],
        ),
      ),
    );
  }
}