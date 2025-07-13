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
  Set<String> selectedSeats = {};

  // 선택된 좌석 하나 (단일 선택용)
  String? selectedSeat;

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
            // 출발역 -> 도착역 표시
            Text(
              '출발역: ${widget.departure}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '도착역: ${widget.arrival}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),

            // <#3> 좌석 선택 영역
            Text(
              '좌석을 선택하세요',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // <#3> 좌석 3x3
            Expanded(
              child: GridView.builder(
                itemCount: 9, // 좌석 9개
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3열
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  String seatNumber = 'A${index + 1}';
                  bool isSelected = selectedSeat == seatNumber;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSeat = seatNumber; //좌석 선택 저장
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.purple : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          seatNumber,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // <추가4> 선택된 좌석과 예매 완료 버튼
            if (selectedSeat != null) ...[
              Text('선택된 좌석: $selectedSeat'),
              SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // <#4> 예매 정보 저장
                    TicketStore().addTicket(
                      Ticket(
                        departure: widget.departure,
                        arrival: widget.arrival,
                        seat: selectedSeat!,
                      ),
                    );

                    // 예매 완료 처리
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('예매 완료'),
                        content: Text(
                          '${widget.departure} → ${widget.arrival}\n좌석: $selectedSeat',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            ),
                            child: Text('확인'),
                          )
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    '예매 완료',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
