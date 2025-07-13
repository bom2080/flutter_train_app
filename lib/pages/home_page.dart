// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'station_list_page.dart'; // <#1> 역 선택 페이지 import

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedDeparture; // 출발역 (초기에는 선택 안됨)
  String? selectedArrival;   // 도착역 (초기에는 선택 안됨)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('기차 예매'), // 별도 스타일 없음
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // 전체 패딩
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 세로 가운데 정렬
          children: [
            // 출발/도착역을 감싸는 박스
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),

  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('출발역',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                          selectedDeparture ?? '선택',
                          style: TextStyle(fontSize: 40),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('도착역',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                          selectedArrival ?? '선택',
                          style: TextStyle(fontSize: 40),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20), // 박스와 버튼 사이 간격
            // 좌석 선택 버튼
            ElevatedButton(
              onPressed: () {
                // 아직 기능 없음
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
            )
          ],
        ),
      ),
    );
  }
}
