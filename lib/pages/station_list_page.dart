// lib/pages/station_list_page.dart
import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String mode; // '출발역' 또는 '도착역' 구분

  StationListPage({required this.mode});

  // 고정된 기차역 리스트
  final List<String> stations = [
    '수서',
    '동탄',
    '평택지제',
    '천안아산',
    '오송',
    '대전',
    '김천구미',
    '동대구',
    '경주',
    '울산',
    '부산',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mode), // 출발역 또는 도착역
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // 역을 선택하면 해당 값을 전달하며 뒤로가기
              Navigator.pop(context, stations[index]);
            },
            child: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              child: Text(
                stations[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
