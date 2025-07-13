// 예매 정보를 담는 모델 클래스
// 출발,도착,좌석번호 저장용
class Ticket {
  final String departure; //출발역
  final String arrival;   //도착역
  final String seat;      //좌석번호

  Ticket({
    required this.departure,
    required this.arrival,
    required this.seat,
  });
}
