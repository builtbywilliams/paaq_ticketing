import '../widgets/paaq_widgets.dart' show TicketStatus;

/// Data models for the ticketing prototype. Screens render from these, so
/// swapping in a real API means replacing the sample data, not the UI.

class Attendee {
  final String name;
  final String email;
  final String initials;
  final String ticketType; // 'Regular' | 'Gold' | 'VIP Table' ...
  final bool isGroupType;
  final String purchased; // display date
  final TicketStatus? status; // null for group rows (mixed)
  final String? groupSummary; // e.g. '2 of 6 checked in'
  final List<Seat>? seats; // present when group + expandable

  const Attendee({
    required this.name,
    required this.email,
    required this.initials,
    required this.ticketType,
    this.isGroupType = false,
    required this.purchased,
    this.status,
    this.groupSummary,
    this.seats,
  });
}

class Seat {
  final int number;
  final String? name; // null = awaiting assignment
  final String? email;
  final String? initials;
  final TicketStatus? status;
  const Seat({
    required this.number,
    this.name,
    this.email,
    this.initials,
    this.status,
  });
}

class TicketTypeRow {
  final String name;
  final bool isGroup;
  final String statusLabel; // 'On sale' | 'Sold out' | 'Closed'
  final String sold; // '18 of 30'
  final String price; // '₦90,000' or 'Free'
  const TicketTypeRow({
    required this.name,
    required this.isGroup,
    required this.statusLabel,
    required this.sold,
    required this.price,
  });
}

class EventDetail {
  final String title;
  final String date;
  final String location;
  final int ticketTypes;
  final int capacity;
  final String feeModel;
  const EventDetail({
    required this.title,
    required this.date,
    required this.location,
    required this.ticketTypes,
    required this.capacity,
    required this.feeModel,
  });
}

/// ---- Sample data for the Multiple-tickets event page (all-paid) ----
class SampleData {
  SampleData._();

  static const event = EventDetail(
    title: 'Breakfast with Thaton',
    date: 'Sat, 2 Sep, 12:59 (WAT)',
    location: 'Lagos, Nigeria (Virtual)',
    ticketTypes: 3,
    capacity: 55,
    feeModel: 'Buyer pays 5% (host set)',
  );

  static const List<TicketTypeRow> ticketTypes = [
    TicketTypeRow(
        name: 'Regular',
        isGroup: false,
        statusLabel: 'On sale',
        sold: '18 of 30',
        price: '₦90,000'),
    TicketTypeRow(
        name: 'VIP Table',
        isGroup: true,
        statusLabel: 'Sold out',
        sold: '20 of 20',
        price: '₦400,000'),
    TicketTypeRow(
        name: 'Gold',
        isGroup: false,
        statusLabel: 'On sale',
        sold: '3 of 5',
        price: '₦150,000'),
  ];

  static const revenueByType = [
    ('VIP Table', '₦400,000', 1.0),
    ('Gold', '₦150,000', 0.375),
    ('Regular', '₦90,000', 0.225),
  ];

  static const List<Attendee> attendees = [
    Attendee(
      name: 'Thabo Nkosi',
      email: 'thabo@mail.com',
      initials: 'TN',
      ticketType: 'VIP Table',
      isGroupType: true,
      purchased: '1 Sep, 14:22',
      groupSummary: '2 of 6 checked in',
      seats: [
        Seat(number: 1, name: 'Thabo Nkosi', email: 'thabo@mail.com', initials: 'TN', status: TicketStatus.checkedIn),
        Seat(number: 2, name: 'Lerato Mokoena', email: 'lerato@mail.com', initials: 'LM', status: TicketStatus.checkedIn),
        Seat(number: 3, name: 'Sizwe Ndlovu', email: 'sizwe@mail.com', initials: 'SN', status: TicketStatus.issued),
        Seat(number: 4, name: 'Ayanda Mbeki', email: 'ayanda@mail.com', initials: 'AM', status: TicketStatus.issued),
        Seat(number: 5),
        Seat(number: 6),
      ],
    ),
    Attendee(name: 'Amara Okoye', email: 'amara@mail.com', initials: 'AO', ticketType: 'Gold', purchased: '1 Sep, 12:08', status: TicketStatus.checkedIn),
    Attendee(name: 'Lindiwe Dube', email: 'lindiwe@mail.com', initials: 'LD', ticketType: 'Regular', purchased: '31 Aug, 19:45', status: TicketStatus.issued),
    Attendee(name: 'Kwame Mensah', email: 'kwame@mail.com', initials: 'KM', ticketType: 'Regular', purchased: '31 Aug, 18:30', status: TicketStatus.checkedIn),
    Attendee(
      name: 'Zanele Khumalo',
      email: 'zanele@mail.com',
      initials: 'ZK',
      ticketType: 'VIP Table',
      isGroupType: true,
      purchased: '30 Aug, 21:10',
      groupSummary: '4 of 6 checked in',
      seats: [],
    ),
    Attendee(name: 'Chidi Eze', email: 'chidi@mail.com', initials: 'CE', ticketType: 'Gold', purchased: '30 Aug, 16:55', status: TicketStatus.checkedIn),
    Attendee(name: 'Naledi Moyo', email: 'naledi@mail.com', initials: 'NM', ticketType: 'Regular', purchased: '29 Aug, 11:20', status: TicketStatus.issued),
    Attendee(name: 'Fatima Bello', email: 'fatima@mail.com', initials: 'FB', ticketType: 'Gold', purchased: '28 Aug, 17:40', status: TicketStatus.checkedIn),
    Attendee(name: 'Grace Muturi', email: 'grace@mail.com', initials: 'GM', ticketType: 'Regular', purchased: '28 Aug, 14:15', status: TicketStatus.cancelled),
  ];
}
