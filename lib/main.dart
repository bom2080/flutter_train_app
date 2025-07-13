import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Emulator Test',
      home: Scaffold(
        appBar: AppBar(
          title: Text('에뮬레이터 연동 확인'),
        ),
        body: Center(
          child: Text(
            '에뮬레이터 연결 성공!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
