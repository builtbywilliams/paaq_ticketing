# PAAQ Events — Ticketing Prototype (Flutter web)

A clickable, connected prototype of the PAAQ ticketing dashboard, built to hand
straight to engineering. Design-token → theme → reusable-widget architecture so
the UI stays consistent and the data layer swaps cleanly for a real API.

## Structure
```
lib/
  theme/
    tokens.dart        # SINGLE SOURCE OF TRUTH: colors, spacing, radii, shadows, type
    app_theme.dart     # ThemeData built from tokens
  widgets/
    paaq_widgets.dart  # Reusable library: PaaqCard, PaaqAvatar, PaaqChip,
                       #   PaaqButton, PaaqStat, PaaqTopNav, PaaqFilterChip,
                       #   PaaqSearchField, TicketStatus (+ .chip())
  data/
    models.dart        # Attendee, Seat, TicketTypeRow, EventDetail + SampleData
  screens/
    multiple_event_page.dart   # REFERENCE SCREEN — the pattern others follow
  router/
    app_router.dart    # go_router table — the clickable navigation graph
  main.dart
pubspec.yaml
preview.html           # visual reference of the screen (for review only)
```

## Running
```
flutter pub get
flutter run -d chrome
```
> The sandbox that produced this has no Flutter toolchain, so it wasn't compiled
> here. Run `flutter analyze` on your machine; any lint nits are cosmetic.

## Design system (tokens)
Change a value in `tokens.dart` and it flows through every widget and screen.
- `PaaqColors` — brand (teal/ink/…), neutrals, surfaces, status colours, chip palette, avatar palette
- `PaaqSpacing`, `PaaqRadii`, `PaaqShadows`, `PaaqText` (Plus Jakarta Sans ramp)

## Fonts
Add Plus Jakarta Sans TTFs under `assets/fonts/` and uncomment the `fonts:`
block in `pubspec.yaml`. Until then it falls back to the system sans-serif.

## Data → API
Screens render from `SampleData` in `models.dart`. Replace those with your
repository/service calls; the models already match the UI's needs.

## Navigation (clickable prototype)
`app_router.dart` holds the route table. As each screen is added it gets a route
and buttons navigate with `context.go(...)`. Full screen-to-screen map (which
button → which destination) is in the project doc
`claude/ticketing-prototype-wiring.md`.

## Status
- [x] Design-token + theme + widget foundation
- [x] Reference screen: Multiple-tickets event page (all-paid)
- [ ] Remaining screens (single/group/sold-out type pages, free/mixed variants,
      tickets list, scan station + result states, refund modal) — built to match
      the reference once approved.

## Key product decisions baked in
- Refund is **full-only** (no partial); read-only "Full refund · ₦X" row.
- Group attendee rows show a per-group summary + expandable seat breakdown; the
  ⋯ refund action sits on the purchaser row only.
- Check-in lives on the list (enabled for live/soon events, disabled otherwise)
  and on detail pages (primary header action).
