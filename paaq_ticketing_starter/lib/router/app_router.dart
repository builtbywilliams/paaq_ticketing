import 'package:go_router/go_router.dart';
import '../screens/multiple_event_page.dart';
import '../screens/tickets_list_page.dart';

/// Central route table for the clickable prototype.
/// As each screen is built it gets a route here, and buttons across the app
/// navigate with `context.go('/route')`. This is what makes the whole
/// prototype clickable and connected.
class AppRoutes {
  static const ticketsList = '/';
  static const ticketsUpcoming = '/tickets/upcoming';
  static const ticketsPast = '/tickets/past';
  static const ticketsDrafts = '/tickets/drafts';
  static const multipleEvent = '/event/multiple';
  // Placeholders for the rest of the flow — added as screens are built:
  // static const singlePaid   = '/type/single-paid';
  // static const groupPaid    = '/type/group-paid';
  // static const soldOutPaid  = '/type/soldout-paid';
  // static const scanStation  = '/check-in';
  // ...
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.ticketsList,
  routes: [
    GoRoute(
      path: AppRoutes.ticketsList,
      builder: (context, state) =>
          const TicketsListPage(tab: TicketsListTab.onSale),
    ),
    GoRoute(
      path: AppRoutes.ticketsUpcoming,
      builder: (context, state) =>
          const TicketsListPage(tab: TicketsListTab.upcoming),
    ),
    GoRoute(
      path: AppRoutes.ticketsPast,
      builder: (context, state) =>
          const TicketsListPage(tab: TicketsListTab.past),
    ),
    GoRoute(
      path: AppRoutes.ticketsDrafts,
      builder: (context, state) =>
          const TicketsListPage(tab: TicketsListTab.drafts),
    ),
    GoRoute(
      path: AppRoutes.multipleEvent,
      builder: (context, state) => const MultipleEventPage(),
    ),
    // GoRoute(path: AppRoutes.scanStation, builder: (_, __) => const ScanStationPage()),
  ],
);
