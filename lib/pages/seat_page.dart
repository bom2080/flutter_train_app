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
  final List<String> columns = ['A', 'B', 'C', 'D'];
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

            // <#3> 좌석 3x3 => <#4UI수정> 좌석 배치 (4열 10행)
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(numRows + 1, (rowIdx) {
                    if (rowIdx == 0) {
                      // <#4UI수정> 열 라벨 표시 (A~D)
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: columns
                            .map((col) => SizedBox(
                                  width: 60,
                                  child: Center(
                                    child: Text(col,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                  ),
                                ))
                            .toList(),
                      );
                    }

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(columns.length, (colIdx) {
                        String seatNum = '${rowIdx}-${columns[colIdx]}';
                        bool isSelected = selectedSeat == seatNum;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSeat = seatNum;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 6),
                            width: 60,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.purple
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                seatNum,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
            ),

            // <#4UI수정> 하단 고정 버튼
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: selectedSeat != null
                      ? () {
                          // 예매 확인 다이얼로그
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('예매 하시겠습니까?'),
                              content: Text('좌석: $selectedSeat'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('취소'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // <#4> 예매 정보 저장
                                    TicketStore().addTicket(
                                      Ticket(
                                        departure: widget.departure,
                                        arrival: widget.arrival,
                                        seat: selectedSeat!,
                                      ),
                                    );
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                  },
                                  child: Text('확인'),
                                )
                              ],
                            ),
                          );
                        }
                      : null, // 좌석 선택 안 했으면 비활성화
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 16),
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

  // <#4UI수정> 좌석 상태 안내 위젯
  Widget _seatLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(4)),
        ),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}