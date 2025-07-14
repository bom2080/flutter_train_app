import '../models/ticket.dart';

class TicketStore {
  static final TicketStore _instance = TicketStore._internal();
  factory TicketStore() => _instance;
  TicketStore._internal();

  // <추가기능> 예매 티켓 목록 (최대 3개 제한)
  final List<Ticket> _tickets = [];

  // <추가기능> 예매 추가 (중복 체크 포함)
  bool addTicket(Ticket ticket) {
    // <버그수정> 동일 예매 내역 예외처리 - 출발역, 도착역, 좌석번호가 모두 같은 경우 중복으로 판단
    for (Ticket existingTicket in _tickets) {
      if (existingTicket.departure == ticket.departure &&
          existingTicket.arrival == ticket.arrival &&
          existingTicket.seat == ticket.seat) {
        return false; // 중복 예매로 인식
      }
    }
    
    // <추가기능> 최대 3개 제한 체크
    if (_tickets.length >= 3) {
      return false; // 최대 예매 개수 초과
    }
    
    _tickets.add(ticket);
    return true; // 성공적으로 추가됨
  }

  // <추가기능> 예매 내역 삭제 (인덱스 기반)
  void removeTicket(int index) {
    if (index >= 0 && index < _tickets.length) {
      _tickets.removeAt(index);
    }
  }

  // <추가기능> 저장된 예매 목록 가져오기 (최대 3개)
  List<Ticket> get tickets => _tickets;
  
  // <추가기능> 현재 예매 개수 확인
  int get ticketCount => _tickets.length;
}
