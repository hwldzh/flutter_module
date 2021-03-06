import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FourthWidget extends StatelessWidget {
  final String params;

  FourthWidget({Key key, this.params}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _callbackMsg = "";
  String _msgFromNative = "";

  static const nativeChannel = const MethodChannel('com.example.flutter/native');
  static const eventChannel = const EventChannel('com.example.flutter/flutter');

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  _onEvent(Object event) {
    setState(() {
      _msgFromNative = event;
    });
  }

  _onError(Object error) {
    setState(() {
      _msgFromNative = error;
    });
  }

  //跳转到原生页面，通过MethodChannel
  _jumpToNativePage() async {
    String result = await nativeChannel.invokeMethod("gotoNativePage", "args from flutter");
    setState(() {
      _callbackMsg = result;
    });
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
                '这是第二个Flutter页面\n点击跳转到原生页面',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.green
                ),
              ),
              onTap: () {
                _jumpToNativePage();
              },
            ),
            Text(
              _callbackMsg,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue
              ),
            ),
            Text(
              _msgFromNative,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.orange
              ),
            )
          ],
        ),
      ),
    );
  }
}