import '../models/ticket.dart';

class TicketStore {
  static final TicketStore _instance = TicketStore._internal();
  factory TicketStore() => _instance;
  TicketStore._internal();

//예매 티켓 목록
  final List<Ticket> _tickets = [];

//예매 추가
  void addTicket(Ticket ticket) {
    _tickets.add(ticket);
  }

//저장된 예매 목록 가져오기
  List<Ticket> get tickets => _tickets;
}
