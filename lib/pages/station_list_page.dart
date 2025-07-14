// lib/pages/station_list_page.dart
import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String mode; // '출발역' 또는 '도착역' 구분
  final String? excludeStation; // <도전> 제외할 역(출발역 또는 도착역)을 전달받음

  const StationListPage({ // <도전수정> const 추가 및 key 명시
    super.key,
    required this.mode,
    this.excludeStation,
  }); // <도전수정> StatelessWidget이므로 key 전
  // <도전수정> excludeStation이 null이 아니면 해당 역을 제외한 리스트 생성
  static const List<String> allStations = [
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
    // <도전과제> 제외할 역을 필터링하여 목록 생성
    final filteredStations = excludeStation != null
        ? allStations.where((station) => station != excludeStation).toList()
        : allStations; // <도전> 제외된 역 필터링 -> <도전수정>excludeStation이 있으면 필터링 적용

    return Scaffold(
      appBar: AppBar(
        title: Text(mode), // 출발역 또는 도착역
      ),
      body: ListView.builder(
        itemCount: filteredStations.length, // <도전수정> 변경된 리스트 적용
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // 역을 선택하면 해당 값을 전달하며 뒤로가기
              Navigator.pop(context, filteredStations[index]);
            },
            child: Container(
              height: 50,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Theme.of(context).dividerColor), // <도전과제> 테마에 맞는 구분선 색상
                ),
              ),
              child: Text(
                filteredStations[index],
                style: TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color, // <도전과제> 테마에 맞는 텍스트 색상
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
