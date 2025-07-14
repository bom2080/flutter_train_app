// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'station_list_page.dart'; // <#1> 역 선택 페이지 import
import 'seat_page.dart'; // <#2> 좌석 페이지 import
import '../data/ticket_store.dart'; //<#3> 예매 내역 저장소 import

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedDeparture; // 출발역 (초기에는 선택 안됨)
  String? selectedArrival;   // 도착역 (초기에는 선택 안됨)

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // <수정#6> 화면 너비


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
            
            // <도전과제> 출발/도착역을 감싸는 박스 (테마에 맞는 색상 적용)
            Container(
              // height: 200, <수정#5> 고정 높이 지워보기 값은 유지
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24), // <수정#5> 내부 여백 추가
              width: screenWidth * 0.85, // <수정#6> 박스 너비 비율로 조정
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor, // <도전과제> 테마에 맞는 카드 색상
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              //<#4 UI수정>
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 출발역
                  GestureDetector(
                    onTap: () async {
                      // <#1> 출발역 선택 시 station_List_page로 이동
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StationListPage(
                            mode: '출발역',
                            excludeStation: selectedArrival, // <도전> 도착역을 출발역 선택 시 제외
                          ),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          selectedDeparture = result;
                        });
                      }
                    },
                    child: Column(
                      // 삭제 crossAxisAlignment: CrossAxisAlignment.center, // <수정#7> 중앙 정렬
                      children: [
                        Text('출발역',
                            style: TextStyle(
                                fontSize: 18, //<수정#6> 16->18 변경
                                color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7), // <도전과제> 테마에 맞는 텍스트 색상
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                          selectedDeparture ?? '선택',
                          style: TextStyle(
                            fontSize: 40,//<수정#6> 40->42 변경
                            color: Theme.of(context).textTheme.headlineMedium?.color, // <도전과제> 테마에 맞는 헤드라인 색상
                          ),
                        ),
                      ],
                    ),
                  ),
                  // <도전과제> 출발-도착 사이 구분선 (테마에 맞는 색상)
                  Container(
                    width: 1,
                    height: 50,
                    color: Theme.of(context).dividerColor, // <도전과제> 테마에 맞는 구분선 색상
                  ),
                  SizedBox(height: 20),
                  // 도착역
                  GestureDetector(
                    onTap: () async {
                      // <#1> 도착역 선택 시 station_List_page로 이동
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => StationListPage(
                            mode: '도착역',
                            excludeStation: selectedDeparture, // <도전> 출발역을 도착역 선택 시 제외
                          ),
                        ),
                      );
                      if (result != null) {
                        setState(() {
                          selectedArrival = result;
                        });
                      }
                    },
                    child: Column(
                      //삭제 crossAxisAlignment: CrossAxisAlignment.center, // <수정#7> 중앙 정렬
                      children: [
                        Text('도착역',
                            style: TextStyle(
                                fontSize: 18, //<수정#6> 16->18 변경
                                color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7), // <도전과제> 테마에 맞는 텍스트 색상
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text(
                          selectedArrival ?? '선택',
                          style: TextStyle(
                            fontSize: 42,//<수정#6> 40->42변경
                            color: Theme.of(context).textTheme.headlineMedium?.color, // <도전과제> 테마에 맞는 헤드라인 색상
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40), // 박스와 버튼 사이 간격 <수정#7> 20->40 변경
            // <추가기능> 좌석 선택 버튼 (최대 3개 제한 포함)
            ElevatedButton(
              onPressed: () {
                if (selectedDeparture == null || selectedArrival == null) {
                  // <#2> 둘 중 하나라도 선택 안됐으면 안내
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('출발역과 도착역을 모두 선택하세요.')),
                  );
                  return;
                }

                // <버그수정> 예매내역 3개 초과시 좌석 선택 화면으로 넘어가는 문제 수정 - 최대 3개 제한 체크
                if (TicketStore().ticketCount >= 3) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('예매 제한'),
                      content: Text('3회 이상 예매할 수 없습니다'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('확인'),
                        ),
                      ],
                    ),
                  );
                  return; // <버그수정> 예매내역 3개 초과시 좌석 선택 화면으로 넘어가는 문제 수정 - 다이얼로그 닫기만 하고 좌석 선택 화면으로 이동하지 않음
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
                ).then((_) {
                    setState(() {}); // <#3> 예매 내역 갱신을 위해 돌아왔을 때 setstate 호출
                  });
              },
              style: ElevatedButton.styleFrom(
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

              // <#3> 예매 내역 리스트 보여주기
              Builder(
                builder: (context) {
                  final tickets = TicketStore().tickets;
                  if (tickets.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '예매 내역',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true, // <#3> Column 안에서 ListView 사용 시 필요
                          physics: NeverScrollableScrollPhysics(), // <#3> ScrollView 중첩 방지
                          itemCount: tickets.length,
                          itemBuilder: (context, index) {
                            final ticket = tickets[index];
                            return Dismissible(
                              // <추가기능> 스와이프 삭제 기능 - 고유 키 설정
                              key: Key('ticket_${ticket.departure}_${ticket.arrival}_${ticket.seat}_$index'),
                              // <추가기능> 스와이프 방향 설정 (오른쪽에서 왼쪽으로만 삭제 가능)
                              direction: DismissDirection.endToStart,
                              // <추가기능> 스와이프 시 배경 색상 및 아이콘
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: EdgeInsets.only(right: 20.0),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              // <추가기능> 스와이프 시 확인 다이얼로그 표시
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('예매 내역 삭제'),
                                      content: Text('정말 예매내역을 삭제하시겠습니까?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(false),
                                          child: Text('취소'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(true),
                                          child: Text('확인'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              // <추가기능> 삭제 후 동일 예매할 수 있게 추가 - 삭제 실행
                              onDismissed: (direction) {
                                setState(() {
                                  TicketStore().removeTicket(index);
                                });
                                // <추가기능> 삭제 후 동일 예매할 수 있게 추가 - 삭제 완료 메시지
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('예매 내역이 삭제되었습니다'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: ListTile(
                                leading: Icon(Icons.train),
                                title: Text('${ticket.departure} → ${ticket.arrival}'),
                                subtitle: Text('좌석: ${ticket.seat}'),
                              ),
                            );
                          },
                        ),
                  ],
                );
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),//<수정#2> SingleChildScrollView
      ),
    );
  }
}