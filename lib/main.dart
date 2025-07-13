// main.dart
import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // HomePage 파일 import

void main() {
  runApp(MyApp());
}

/// 앱 진입 위젯
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '기차 예매',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.grey[200], // 기본 배경색 설정
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(), // 첫 화면으로 HomePage 연결
    );
  }
}
