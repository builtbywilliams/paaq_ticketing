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

/// A ticket-type row inside an event card's expandable table on the
/// tickets list (distinct from [TicketTypeRow], which belongs to the
/// ticket-detail Overview screen's table).
class ListTicketTypeRow {
  final String name;
  final bool isGroup;
  final String statusLabel; // 'On sale' | 'Sold out' | 'Closed' | 'Open'
  final String soldText; // full row text, e.g. '18 of 30 sold'
  final String price; // '₦5,000' or 'Free'
  const ListTicketTypeRow({
    required this.name,
    required this.isGroup,
    required this.statusLabel,
    required this.soldText,
    required this.price,
  });
}

/// One event row on the tickets list (any tab).
class EventListItem {
  final String title;
  final String typeLabel; // 'Multiple tickets' | 'Single ticket' | 'Group ticket'
  final bool isFree;
  final String dateLine;
  final String? price; // shown only on single/group (non-multiple) cards
  final String soldLabel; // 'Total sold' | 'Registered'
  final String soldValue; // '31 of 55 sold' | '120 of 200'
  final String revenueValue; // '₦640,000' or 'Free'
  final bool checkInEnabled;
  final bool viewPlural; // 'View tickets' vs 'View ticket'
  final List<ListTicketTypeRow>? ticketTypeRows; // non-null => expandable
  const EventListItem({
    required this.title,
    required this.typeLabel,
    this.isFree = false,
    required this.dateLine,
    this.price,
    required this.soldLabel,
    required this.soldValue,
    required this.revenueValue,
    required this.checkInEnabled,
    required this.viewPlural,
    this.ticketTypeRows,
  });
}

/// ---- Sample data for the Multiple-tickets event page (all-paid) ----
class SampleData {
  SampleData._();

  // ---- Tickets list — On sale tab (66748:51746) ----
  static const List<EventListItem> onSaleEvents = [
    EventListItem(
      title: 'Breakfast with Thaton',
      typeLabel: 'Multiple tickets',
      dateLine: 'Sat, 2 Sep · 12:59 · Virtual',
      soldLabel: 'Total sold',
      soldValue: '31 of 55 sold',
      revenueValue: '₦640,000',
      checkInEnabled: true,
      viewPlural: true,
      ticketTypeRows: [
        ListTicketTypeRow(
            name: 'Regular',
            isGroup: false,
            statusLabel: 'On sale',
            soldText: '18 of 30 sold',
            price: '₦5,000'),
        ListTicketTypeRow(
            name: 'VIP',
            isGroup: true,
            statusLabel: 'Sold out',
            soldText: '20 of 20 sold',
            price: '₦20,000'),
        ListTicketTypeRow(
            name: 'Gold',
            isGroup: false,
            statusLabel: 'On sale',
            soldText: '3 of 5 sold',
            price: '₦50,000'),
      ],
    ),
    EventListItem(
      title: 'Product Design AMA',
      typeLabel: 'Single ticket',
      dateLine: 'Thu, 12 Sep · 18:00 · Lagos',
      price: '₦2,500',
      soldLabel: 'Total sold',
      soldValue: '4 of 10 sold',
      revenueValue: '₦25,000',
      checkInEnabled: true,
      viewPlural: false,
    ),
    EventListItem(
      title: 'Founders Dinner',
      typeLabel: 'Multiple tickets',
      dateLine: 'Fri, 20 Sep · 19:30 · Cape Town',
      soldLabel: 'Total sold',
      soldValue: '24 of 30 sold',
      revenueValue: '₦935,000',
      checkInEnabled: false,
      viewPlural: true,
      ticketTypeRows: [
        ListTicketTypeRow(
            name: 'Seat',
            isGroup: false,
            statusLabel: 'On sale',
            soldText: '18 of 24 sold',
            price: '₦35,000'),
        ListTicketTypeRow(
            name: 'Table of 6',
            isGroup: true,
            statusLabel: 'On sale',
            soldText: '1 of 1 sold',
            price: '₦180,000'),
        ListTicketTypeRow(
            name: 'Early bird',
            isGroup: false,
            statusLabel: 'Closed',
            soldText: '5 of 5 sold',
            price: '₦25,000'),
      ],
    ),
    EventListItem(
      title: 'Growth Marketing Workshop',
      typeLabel: 'Group ticket',
      dateLine: 'Wed, 25 Sep · 10:00 · Virtual',
      price: '₦8,000',
      soldLabel: 'Total sold',
      soldValue: '6 of 100 sold',
      revenueValue: '₦48,000',
      checkInEnabled: true,
      viewPlural: false,
    ),
    EventListItem(
      title: 'UX Research Clinic',
      typeLabel: 'Multiple tickets',
      dateLine: 'Tue, 8 Oct · 15:00 · Virtual',
      soldLabel: 'Total sold',
      soldValue: '12 of 40 sold',
      revenueValue: '₦96,000',
      checkInEnabled: false,
      viewPlural: true,
      ticketTypeRows: [
        ListTicketTypeRow(
            name: 'Standard',
            isGroup: false,
            statusLabel: 'On sale',
            soldText: '9 of 30 sold',
            price: '₦4,000'),
        ListTicketTypeRow(
            name: 'Priority',
            isGroup: false,
            statusLabel: 'On sale',
            soldText: '3 of 10 sold',
            price: '₦8,000'),
      ],
    ),
    EventListItem(
      title: 'Startup Pitch Night',
      typeLabel: 'Single ticket',
      dateLine: 'Sat, 19 Oct · 18:30 · Nairobi',
      price: '₦1,500',
      soldLabel: 'Total sold',
      soldValue: '56 of 80 sold',
      revenueValue: '₦140,000',
      checkInEnabled: false,
      viewPlural: false,
    ),
    EventListItem(
      title: 'Community Design Meetup',
      typeLabel: 'Multiple tickets',
      isFree: true,
      dateLine: 'Thu, 3 Oct · 17:00 · Lagos',
      soldLabel: 'Registered',
      soldValue: '64 of 150',
      revenueValue: 'Free',
      checkInEnabled: false,
      viewPlural: true,
      ticketTypeRows: [
        ListTicketTypeRow(
            name: 'General',
            isGroup: false,
            statusLabel: 'Open',
            soldText: '48 of 100 registered',
            price: 'Free'),
        ListTicketTypeRow(
            name: 'Team table',
            isGroup: true,
            statusLabel: 'Open',
            soldText: '16 of 50 · 5 seats',
            price: 'Free'),
      ],
    ),
    EventListItem(
      title: 'Intro to Product Design',
      typeLabel: 'Single ticket',
      isFree: true,
      dateLine: 'Mon, 7 Oct · 16:00 · Virtual',
      price: 'Free',
      soldLabel: 'Registered',
      soldValue: '120 of 200',
      revenueValue: 'Free',
      checkInEnabled: false,
      viewPlural: false,
    ),
    EventListItem(
      title: 'Team Offsite Mixer',
      typeLabel: 'Group ticket',
      isFree: true,
      dateLine: 'Fri, 10 Oct · 18:00 · Lagos',
      price: 'Free',
      soldLabel: 'Registered',
      soldValue: '18 of 60',
      revenueValue: 'Free',
      checkInEnabled: false,
      viewPlural: false,
    ),
    EventListItem(
      title: 'Design Systems Webinar',
      typeLabel: 'Single ticket',
      isFree: true,
      dateLine: 'Sat, 18 Oct · 14:00 · Virtual',
      price: 'Free',
      soldLabel: 'Registered',
      soldValue: '200 of 200',
      revenueValue: 'Free',
      checkInEnabled: false,
      viewPlural: false,
    ),
  ];

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
