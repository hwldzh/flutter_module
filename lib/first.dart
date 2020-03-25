import 'package:flutter/material.dart';
import 'package:flutter_module/fourth.dart';
import 'package:flutter_module/third.dart';
import 'second.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '第一个Flutter页面'),
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
  static const flutterChannel = const MethodChannel("com.example.flutter/flutter");
  static const nativeChannel = const MethodChannel('com.example.flutter/native');
  String _result = "";

  @override
  void initState() {
    super.initState();
    Future<dynamic> handler(MethodCall call) async {
      switch (call.method) {
        case 'backAction':
          setState(() {
            _result = call.arguments;
          });
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          } else {
            nativeChannel.invokeMethod('backAction', 'hello2');
          }
          break;
      }
    }
    flutterChannel.setMethodCallHandler(handler);
  }

  //跳转到第二个Flutter页面
  _jumpToSecond() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return SecondWidget();
    }));
  }

  _goback() {
    print("gotoback calling");
    _callBackAction();
  }

  Future<void> _callBackAction() async {
    try {
      if(Navigator.canPop(context)) {
        Navigator.of(context).pop();
      } else {
        nativeChannel.invokeMethod("backAction", "hello1");
      }
    } on PlatformException catch (e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: BackButton(
          onPressed: _goback,
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Text(
                '这是第一个Flutter页面\n点击跳转到第二个Flutter页面',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue
                ),
              ),
              onTap: () {
                _jumpToSecond();
              },
            ),
            Text(
              _result
            )
          ],
        ),
      ),
    );
  }
}
