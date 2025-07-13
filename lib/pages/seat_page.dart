// lib/pages/seat_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/ticket.dart'; // <#4>예매 정보 모델
import '../data/ticket_store.dart'; // <#4> 예매 저장소

class SeatPage extends StatefulWidget {
  final String departure;
  final String arrival;

  SeatPage({required this.departure, required this.arrival});

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  // 선택된 좌석들을 저장할 Set
  //삭제 Set<String> selectedSeats = {};

  // 선택된 좌석 하나 (단일 선택용)
  String? selectedSeat;

    // <#4 UI수정> 좌석 열 라벨 (A~D)
  final List<String> leftColumns = ['A', 'B'];   // <#6 UI수정>
  final List<String> rightColumns = ['C', 'D'];  // <#6 UI수정>
  final int numRows = 10; // 10행

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좌석 선택'),
        centerTitle: true, // 별도 스타일 없음
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // 전체 패딩
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // <#4 UI수정> 상단 출발역 → 도착역 표시
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.departure,
                    style: TextStyle(fontSize: 20, color: Colors.purple, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Text(widget.arrival,
                    style: TextStyle(fontSize: 20, color: Colors.purple, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 16), //쉼표 누락 수정
            Row(// <#4 UI수정> 좌석 상태 안내
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _seatLegend(Colors.purple, '선택됨'),
                SizedBox(width: 10),
                _seatLegend(Colors.grey[300]!, '선택 안 됨'),
              ],
            ),
            SizedBox(height: 10),


            // <이슈1> 열 라벨 표시 (A B   C D)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...leftColumns.map((col) => SizedBox(
                      width: 60,
                      child: Center(
                        child: Text(col,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    )),
                SizedBox(width: 30),
                ...rightColumns.map((col) => SizedBox(
                      width: 60,
                      child: Center(
                        child: Text(col,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    )),
              ],
            ),
            SizedBox(height: 8), //라벨 아래 여백

            // <#6 UI수정> 좌석 표
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(numRows, (rowIdx) {
                    int rowNum = rowIdx + 1;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // 왼쪽 열 (A, B)
                          ...leftColumns.map((col) => _buildSeat(col,rowNum)),

                          // 행 번호(중앙)
                          SizedBox(
                            width: 30,
                            child: Center(
                              child: Text(
                                '$rowNum',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          // 오른쪽 열 (C, D)
                          ...rightColumns.map((col) => _buildSeat(col,rowNum)),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),

            // <#6 UI수정> 하단 예매 버튼
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedSeat != null
                      ? () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('예매 하시겠습니까?'),
                              content: Text('좌석: $selectedSeat'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('취소',                                      style: TextStyle(
                                          color: Colors.grey[800]
                                  ))
                                ),
                                TextButton(
                                  onPressed: () {
                                    TicketStore().addTicket(
                                      Ticket(
                                        departure: widget.departure,
                                        arrival: widget.arrival,
                                        seat: selectedSeat!,
                                      ),
                                    );
                                    Navigator.popUntil(context, (route) => route.isFirst);
                                  },
                                  child: Text('확인'),
                                ),
                              ],
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    '예매 하기',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // <#6 UI수정> 좌석 박스
  Widget _buildSeat(String col, int rowNum) {
    String seatId = '$rowNum$col'; // 예: 1A, 2B
    bool isSelected = selectedSeat == seatId; //<#7 UI수정 비교 대상 seatNum → seatId 로 수정>

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSeat = seatId;
        });
      },
      child: Container(
        width: 60,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            seatId,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.blueGrey, // <#8 UI수정>
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  // <#6 UI수정> 좌석 상태 안내
  Widget _seatLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        ),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}