import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondWidget extends StatelessWidget {
  final String params;

  SecondWidget({Key key, this.params}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: '第二个Flutter页面');
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
  String _callbackFromNative = "";

  static const nativeChannel = const MethodChannel('com.example.flutter/native');


  @override
  void initState() {
    super.initState();
    Future<dynamic> handler(MethodCall call) {
      if(call.method == "gotoFlutterPage") {
        setState(() {
          _callbackFromNative = call.arguments;
        });
      }
    }
    nativeChannel.setMethodCallHandler(handler);
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
      appBar: AppBar(
        title: Text(widget.title),
        leading: BackButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.of(context).pop();
            }
          },
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              child: Text(
                '这是第二个Flutter页面\n点击跳转到原生页面',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue
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
              _callbackFromNative,
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