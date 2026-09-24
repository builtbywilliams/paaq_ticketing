import 'package:flutter/material.dart';

/// PAAQ design tokens — single source of truth for the ticketing UI.
///
/// These mirror the values used in the Figma "Tickets" section. Change a value
/// here and it propagates through the ThemeData and every widget.
class PaaqColors {
  PaaqColors._();

  // ---- Brand ----
  static const Color teal = Color(0xFF00B5B4); // primary action / identity
  static const Color tealDark = Color(0xFF0A8E8D); // pressed / text-on-tint
  static const Color tealTintBg = Color(0xFFE9FBFB); // teal chip / soft fill
  static const Color tealSoftBg = Color(0xFFF0FBFB);

  static const Color ink = Color(0xFF181F1F); // main black foundation
  static const Color yellow = Color(0xFFFFC823);
  static const Color pink = Color(0xFFE35369);
  static const Color purple = Color(0xFF6F2DBD);
  static const Color successGreen = Color(0xFF67AC5B);

  // ---- Neutrals / text ----
  static const Color textPrimary = Color(0xFF181F1F);
  static const Color textStrong = Color(0xFF1F2937);
  static const Color textBody = Color(0xFF374151);
  static const Color textMuted = Color(0xFF6B7676);
  static const Color textFaint = Color(0xFF9AA3A2);
  static const Color textDisabled = Color(0xFFB4BCBB);

  // ---- Surfaces ----
  static const Color pageBg = Color(0xFFF4F6F6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSubtle = Color(0xFFFAFBFB);
  static const Color field = Color(0xFFF6F8F8);
  static const Color line = Color(0xFFE9EEED);
  static const Color lineSoft = Color(0xFFECEFEF);
  static const Color borderInput = Color(0xFFDDE3E2);

  // ---- Status (ticket states + scan results) ----
  static const Color statusCheckedInFg = Color(0xFF3F8E4F);
  static const Color statusCheckedInBg = Color(0xFFEAF9F1);
  static const Color statusIssuedFg = Color(0xFF2F6FB0);
  static const Color statusIssuedBg = Color(0xFFE9F1FA);
  static const Color statusCancelledFg = Color(0xFFE35369);
  static const Color statusCancelledBg = Color(0xFFFCECEF);
  static const Color statusExpiredFg = Color(0xFFC79A16);
  static const Color statusExpiredBg = Color(0xFFFBF3DA);

  // ---- Ticket-type chip palette ----
  static const Color chipNeutralFg = Color(0xFF6B7676);
  static const Color chipNeutralBg = Color(0xFFF1F4F3);
  static const Color chipGoldFg = Color(0xFF8A6D1A);
  static const Color chipGoldBg = Color(0xFFFBF3DA);
  static const Color chipVipFg = Color(0xFF5B4BB7);
  static const Color chipVipBg = Color(0xFFEEEBFE);

  // ---- Avatar palette (deterministic per person) ----
  static const List<Color> avatarPalette = [
    Color(0xFF6F2DBD),
    Color(0xFFE35369),
    Color(0xFF00B5B4),
    Color(0xFF2F6FB0),
    Color(0xFFC79A16),
  ];
}

class PaaqSpacing {
  PaaqSpacing._();
  static const double x1 = 4;
  static const double x2 = 8;
  static const double x3 = 12;
  static const double x4 = 16;
  static const double x5 = 20;
  static const double x6 = 24;
  static const double x8 = 32;
  static const double gutter = 110; // desktop page side padding
  static const double contentMax = 1220; // desktop content column
}

class PaaqRadii {
  PaaqRadii._();
  static const double sm = 8;
  static const double md = 10;
  static const double lg = 12;
  static const double xl = 16;
  static const double xxl = 18;
  static const double pill = 999;
}

class PaaqShadows {
  PaaqShadows._();
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0D1A2626), // ~0.05 alpha ink
      offset: Offset(0, 5),
      blurRadius: 18,
      spreadRadius: -2,
    ),
  ];
  static const List<BoxShadow> popover = [
    BoxShadow(
      color: Color(0x24171717),
      offset: Offset(0, 12),
      blurRadius: 34,
      spreadRadius: -6,
    ),
  ];
}

/// Text styles — Plus Jakarta Sans, matching the Figma type ramp.
/// The font is registered in pubspec (see setup notes) with fallback to Inter.
class PaaqText {
  PaaqText._();
  static const String family = 'Plus Jakarta Sans';

  static TextStyle _base(double size, FontWeight w, Color c,
          {double? spacing, double? height}) =>
      TextStyle(
        fontFamily: family,
        fontSize: size,
        fontWeight: w,
        color: c,
        letterSpacing: spacing,
        height: height,
      );

  // Display / headings
  static TextStyle h1 = _base(26, FontWeight.w800, PaaqColors.textPrimary);
  static TextStyle h2 = _base(19, FontWeight.w700, PaaqColors.textPrimary);
  static TextStyle h3 = _base(16, FontWeight.w700, PaaqColors.textPrimary);

  // Body
  static TextStyle bodyStrong =
      _base(14, FontWeight.w600, PaaqColors.textPrimary);
  static TextStyle body = _base(13, FontWeight.w400, PaaqColors.textBody);
  static TextStyle bodyMuted = _base(12.5, FontWeight.w400, PaaqColors.textMuted);
  static TextStyle small = _base(12, FontWeight.w400, PaaqColors.textFaint);

  // Labels / metadata
  static TextStyle label = _base(12.5, FontWeight.w500, PaaqColors.textBody);
  static TextStyle overline = _base(10.5, FontWeight.w600, PaaqColors.textFaint,
      spacing: 0.5);
  static TextStyle statLabel = _base(11, FontWeight.w400, PaaqColors.textFaint);
  static TextStyle statValue = _base(16, FontWeight.w700, PaaqColors.textPrimary);
}
