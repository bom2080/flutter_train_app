// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'station_list_page.dart'; // <#1> 역 선택 페이지 import
import 'seat_page.dart'; // <#2> 좌석 페이지 import

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedDeparture; // 출발역 (초기에는 선택 안됨)
  String? selectedArrival;   // 도착역 (초기에는 선택 안됨)

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // <수정#6> 화면 너비
    double screenHeight = MediaQuery.of(context).size.height; // <수정#6> 화면 높이


    return Scaffold(
      appBar: AppBar(
        title: Text('기차 예매'), // 별도 스타일 없음
        centerTitle: true,
      ),
      body: SafeArea(// <수정#4> 노치 및 하단 여백 고려
        child: SingleChildScrollView( // <수정#4> 오버플로우 방지
          padding: const EdgeInsets.all(20.0), // 전체 패딩
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // <수정#7> 세로 중앙 정렬
          crossAxisAlignment: CrossAxisAlignment.center, // <수정#3> 가운데 정렬 유지
          children: [
            SizedBox(height: 20), // <수정#1> 여유 공간 추가, <수정#4> 20변경
            // 출발/도착역을 감싸는 박스
            Container(
              // height: 200, <수정#5> 고정 높이 지워보기 값은 유지
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24), // <수정#5> 내부 여백 추가
              width: screenWidth * 0.85, // <수정#6> 박스 너비 비율로 조정
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // <수정#7> 중앙 정렬
                children: [
                  // 출발역
                  GestureDetector(
                    onTap: () async {
                      // <#1> 출발역 선택 시 station_List_page로 이동
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StationListPage(mode: '출발역'),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          selectedDeparture = result;
                        });
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // <수정#7> 중앙 정렬
                      children: [
                        Text('출발역',
                            style: TextStyle(
                                fontSize: 18, //<수정#6> 16->18 변경
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                          selectedDeparture ?? '선택',
                          style: TextStyle(fontSize: 40),//<수정#6> 40->42 변경
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // 출발-도착 사이 세로 선 대체 간격
                  Container(
                    width: 2,
                    height: 50,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 20),
                  // 도착역
                  GestureDetector(
                    onTap: () async {
                      // <#1> 도착역 선택 시 station_List_page로 이동
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StationListPage(mode: '도착역'),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          selectedArrival = result;
                        });
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // <수정#7> 중앙 정렬
                      children: [
                        Text('도착역',
                            style: TextStyle(
                                fontSize: 18, //<수정#6> 16->18 변경
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                          selectedArrival ?? '선택',
                          style: TextStyle(fontSize: 42),//<수정#6> 40->42변경
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40), // 박스와 버튼 사이 간격 <수정#7> 20->40 변경
            // 좌석 선택 버튼
            ElevatedButton(
              onPressed: () {
                if (selectedDeparture == null || selectedArrival == null) {
                  // <#2> 둘 중 하나라도 선택 안됐으면 안내
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('출발역과 도착역을 모두 선택하세요.')),
                  );
                  return;
                }

                // <#2> 좌석 페이지로 출발/도착역 넘기기
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SeatPage(
                      departure: selectedDeparture!,
                      arrival: selectedArrival!,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              ),
              child: Text(
                '좌석 선택',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 40), // 하단 여백
            ],
          ),
        ), // <== <수정#2> SingleChildScrollView 닫기
      ),
    );
  }
}
