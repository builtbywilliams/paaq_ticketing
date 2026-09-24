import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'router/app_router.dart';

void main() => runApp(const PaaqTicketingApp());

class PaaqTicketingApp extends StatelessWidget {
  const PaaqTicketingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PAAQ Ticketing',
      debugShowCheckedModeBanner: false,
      theme: PaaqTheme.light(),
      routerConfig: appRouter,
    );
  }
}
