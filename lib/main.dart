// main.dart
import 'package:flutter/material.dart';
import 'pages/home_page.dart'; // HomePage 파일 import

void main() {
  runApp(MyApp());
}

/// 앱 진입 위젯
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // <도전과제> 현재 시간 가져오기
    final now = DateTime.now();
    final currentHour = now.hour;
    
    // <도전과제> 시간 범위에 따른 테마 설정
    // PM 20:00 ~ AM 07:59: 다크 테마
    // AM 08:00 ~ PM 19:59: 라이트 테마
    final isDarkMode = currentHour >= 20 || currentHour < 8;
    
    return MaterialApp(
      title: '기차 예매',
      theme: isDarkMode ? _buildDarkTheme() : _buildLightTheme(),
      debugShowCheckedModeBanner: false,
      home: HomePage(), // 첫 화면으로 HomePage 연결
    );
  }
  
  // <도전과제> 라이트 테마 설정 (AM 08:00 ~ PM 19:59)
  ThemeData _buildLightTheme() {
    return ThemeData(
      primarySwatch: Colors.purple,
      scaffoldBackgroundColor: Colors.grey[200], // 밝은 회색 배경
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
  
  // <도전과제> 다크 테마 설정 (PM 20:00 ~ AM 07:59)
  ThemeData _buildDarkTheme() {
    return ThemeData(
      primarySwatch: Colors.purple,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey[900], // 어두운 회색 배경
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[850], // 어두운 앱바
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple[600], // 다크 테마용 보라색
          foregroundColor: Colors.white,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.grey[850], // 어두운 카드 배경
        elevation: 2,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey[700], // 어두운 구분선
      ),
    );
  }
}
