// lib/pages/seat_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departure;
  final String arrival;

  SeatPage({required this.departure, required this.arrival});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  // 선택된 좌석들을 저장할 Set
  Set<String> selectedSeats = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석 선택'), // 별도 스타일 없음
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // 전체 패딩
        child: Column(
          children: [
            // 출발역 -> 도착역 표시
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.departure,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.purple,
                  ),
                ),
                SizedBox(width: 10),
                Icon(Icons.arrow_circle_right_outlined, size: 30),
                SizedBox(width: 10),
                Text(
                  widget.arrival,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            // 좌석 상태 안내
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSeatStateBox(Colors.grey[300]!, '선택 안 됨'),
                SizedBox(width: 20),
                _buildSeatStateBox(Colors.purple, '선택됨'),
              ],
            ),

            SizedBox(height: 20),

            // 좌석 리스트 (리스트뷰로 스크롤 가능하게 만들 예정)
            Expanded(
              child: Center(
                child: Text(
                  '좌석 UI 구현 예정',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),

            // 예매하기 버튼 (기능은 다음 단계에서 구현)
            ElevatedButton(
              onPressed: () {
                // 다음 단계에서 기능 연결
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                '예매 하기',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 좌석 상태를 표시하는 작은 박스 + 텍스트
  Widget _buildSeatStateBox(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}
