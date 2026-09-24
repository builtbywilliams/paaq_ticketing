import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/multiple_event_page.dart';

/// Central route table for the clickable prototype.
/// As each screen is built it gets a route here, and buttons across the app
/// navigate with `context.go('/route')`. This is what makes the whole
/// prototype clickable and connected.
class AppRoutes {
  static const ticketsList = '/';
  static const multipleEvent = '/event/multiple';
  // Placeholders for the rest of the flow — added as screens are built:
  // static const singlePaid   = '/type/single-paid';
  // static const groupPaid    = '/type/group-paid';
  // static const soldOutPaid  = '/type/soldout-paid';
  // static const scanStation  = '/check-in';
  // ...
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.multipleEvent, // reference screen for now
  routes: [
    GoRoute(
      path: AppRoutes.multipleEvent,
      builder: (context, state) => const MultipleEventPage(),
    ),
    // GoRoute(path: AppRoutes.ticketsList, builder: (_, __) => const TicketsListPage()),
    // GoRoute(path: AppRoutes.scanStation, builder: (_, __) => const ScanStationPage()),
  ],
);
