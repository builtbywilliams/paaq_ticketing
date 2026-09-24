import 'package:flutter/material.dart';
import '../theme/tokens.dart';
import '../widgets/paaq_widgets.dart';
import '../data/models.dart';

/// Multiple-tickets EVENT page (all-paid variant) — the reference screen.
/// Layout: top nav → breadcrumb → hero header (title + actions) → KPI row →
/// two-column body (left: sales-by-type + attendees table, right: revenue-by-
/// type + event details).
class MultipleEventPage extends StatefulWidget {
  const MultipleEventPage({super.key});
  @override
  State<MultipleEventPage> createState() => _MultipleEventPageState();
}

class _MultipleEventPageState extends State<MultipleEventPage> {
  // which group rows are expanded (by attendee name)
  final Set<String> _expanded = {'Thabo Nkosi'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PaaqTopNav(),
            Padding(
              padding: const EdgeInsets.fromLTRB(PaaqSpacing.gutter, 26,
                  PaaqSpacing.gutter, 40),
              child: Center(
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: PaaqSpacing.contentMax),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _breadcrumb(),
                      const SizedBox(height: 18),
                      _hero(),
                      const SizedBox(height: 20),
                      _kpiRow(),
                      const SizedBox(height: 20),
                      _body(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _breadcrumb() => Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.chevron_left_rounded,
            size: 18, color: PaaqColors.textMuted),
        const SizedBox(width: 4),
        Text('Back to tickets',
            style: PaaqText.label.copyWith(color: PaaqColors.textMuted)),
      ]);

  // ---- Hero header ----
  Widget _hero() {
    return PaaqCard(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
                color: PaaqColors.teal,
                borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.confirmation_number_outlined,
                color: Colors.white, size: 22),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Text(SampleData.event.title, style: PaaqText.h2),
                  const SizedBox(width: 10),
                  const PaaqChip('Multiple tickets',
                      fg: PaaqColors.chipNeutralFg,
                      bg: PaaqColors.chipNeutralBg,
                      radius: 8),
                  const SizedBox(width: 8),
                  const PaaqChip('On sale',
                      fg: PaaqColors.statusCheckedInFg,
                      bg: PaaqColors.statusCheckedInBg,
                      radius: 8),
                ]),
                const SizedBox(height: 4),
                Text(
                    '${SampleData.event.date} · ${SampleData.event.location} · ${SampleData.event.ticketTypes} ticket types',
                    style: PaaqText.bodyMuted),
              ],
            ),
          ),
          PaaqButton(
              label: 'Share', icon: Icons.ios_share_rounded, onPressed: () {}),
          const SizedBox(width: 10),
          PaaqButton(
              label: 'New ticket type',
              icon: Icons.add_rounded,
              onPressed: () {}),
          const SizedBox(width: 10),
          PaaqButton(
              label: 'Check in',
              icon: Icons.qr_code_scanner_rounded,
              variant: PaaqButtonVariant.primary,
              onPressed: () {}),
        ],
      ),
    );
  }

  // ---- KPI row ----
  Widget _kpiRow() {
    Widget cell(Widget child) => Expanded(
          child: PaaqCard(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        );
    return Row(children: [
      cell(PaaqStat(
          label: 'Total revenue',
          value: '₦640,000',
          valueColor: PaaqColors.statusCheckedInFg)),
      const SizedBox(width: 20),
      cell(const PaaqStat(label: 'Tickets sold', value: '31', suffix: '/ 55')),
      const SizedBox(width: 20),
      cell(const PaaqStat(label: 'Checked in', value: '18', suffix: '/ 31')),
      const SizedBox(width: 20),
      cell(const PaaqStat(
          label: 'No-shows', value: '—', suffix: 'live at event')),
    ]);
  }

  // ---- Two-column body ----
  Widget _body() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(children: [
            _salesByType(),
            const SizedBox(height: 20),
            _attendeesCard(),
          ]),
        ),
        const SizedBox(width: 20),
        SizedBox(width: 360, child: _rightRail()),
      ],
    );
  }

  // ---- Sales by ticket type ----
  Widget _salesByType() {
    Widget headerCell(String t, {bool fill = false, double? w}) {
      final child = Text(t, style: PaaqText.overline);
      return fill ? Expanded(child: child) : SizedBox(width: w, child: child);
    }

    Widget row(TicketTypeRow r, {bool total = false}) {
      final statusChip = r.statusLabel == 'Sold out'
          ? const PaaqChip('Sold out',
              fg: PaaqColors.chipGoldFg, bg: PaaqColors.chipGoldBg, radius: 8)
          : PaaqChip(r.statusLabel,
              fg: PaaqColors.statusCheckedInFg,
              bg: PaaqColors.statusCheckedInBg,
              radius: 8);
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        decoration: BoxDecoration(
          color: total ? PaaqColors.surfaceSubtle : PaaqColors.surface,
          border: const Border(
              top: BorderSide(color: PaaqColors.line)),
        ),
        child: Row(children: [
          Expanded(
            child: total
                ? Text('Total', style: PaaqText.bodyStrong)
                : Row(children: [
                    Text(r.name, style: PaaqText.bodyStrong),
                    const SizedBox(width: 8),
                    PaaqChip(r.isGroup ? 'Group' : 'Single',
                        fg: r.isGroup
                            ? PaaqColors.chipVipFg
                            : PaaqColors.chipNeutralFg,
                        bg: r.isGroup
                            ? PaaqColors.chipVipBg
                            : PaaqColors.chipNeutralBg,
                        radius: 8),
                    const SizedBox(width: 8),
                    statusChip,
                  ]),
          ),
          SizedBox(
              width: 150,
              child: Text(total ? '41 of 55' : r.sold,
                  style: total
                      ? PaaqText.bodyStrong
                      : PaaqText.body.copyWith(color: PaaqColors.textMuted))),
          SizedBox(
              width: 160,
              child: Text(total ? '₦640,000' : r.price,
                  style: TextStyle(
                      fontFamily: PaaqText.family,
                      fontSize: total ? 14 : 13,
                      fontWeight: total ? FontWeight.w700 : FontWeight.w600,
                      color: PaaqColors.statusCheckedInFg))),
        ]),
      );
    }

    return PaaqCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 18, 22, 16),
            child: Text('Sales by ticket type', style: PaaqText.h3),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
            color: PaaqColors.surfaceSubtle,
            child: Row(children: [
              headerCell('TICKET TYPE', fill: true),
              headerCell('SOLD', w: 150),
              headerCell('REVENUE', w: 160),
            ]),
          ),
          for (final r in SampleData.ticketTypes) row(r),
          row(SampleData.ticketTypes.first, total: true),
        ],
      ),
    );
  }

  // ---- Attendees card (search + filters + table + pagination) ----
  Widget _attendeesCard() {
    return PaaqCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 18, 22, 16),
            child: Row(children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Attendees', style: PaaqText.h3),
                      const SizedBox(height: 2),
                      Text('31 sold across 3 ticket types · 18 checked in',
                          style: PaaqText.bodyMuted),
                    ]),
              ),
              PaaqButton(
                  label: 'Export CSV',
                  icon: Icons.file_download_outlined,
                  onPressed: () {}),
            ]),
          ),
          // toolbar
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 0, 22, 14),
            child: Row(children: [
              const Expanded(
                  child: PaaqSearchField(hint: 'Search attendees')),
              const SizedBox(width: 10),
              PaaqFilterChip('All ticket types', count: 2, onTap: () {}),
              const SizedBox(width: 10),
              PaaqFilterChip('Status', onTap: () {}),
              const SizedBox(width: 10),
              PaaqFilterChip('Date', onTap: () {}),
            ]),
          ),
          // column header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 11),
            decoration: const BoxDecoration(
              color: PaaqColors.surfaceSubtle,
              border: Border(
                  top: BorderSide(color: PaaqColors.line),
                  bottom: BorderSide(color: PaaqColors.line)),
            ),
            child: Row(children: [
              Expanded(child: Text('ATTENDEE', style: PaaqText.overline)),
              SizedBox(width: 180, child: Text('TICKET TYPE', style: PaaqText.overline)),
              SizedBox(width: 150, child: Text('PURCHASED', style: PaaqText.overline)),
              SizedBox(width: 120, child: Text('STATUS', style: PaaqText.overline)),
              const SizedBox(width: 28), // chevron col
              const SizedBox(width: 28), // ⋯ col
            ]),
          ),
          for (final a in SampleData.attendees) ..._attendeeRow(a),
          // pagination
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
            child: Row(children: [
              Text('Showing 1–10 of 31 attendees', style: PaaqText.small),
              const Spacer(),
              _pager(),
            ]),
          ),
        ],
      ),
    );
  }

  List<Widget> _attendeeRow(Attendee a) {
    final isExpanded = _expanded.contains(a.name);
    final row = Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: PaaqColors.line))),
      child: Row(children: [
        // attendee cell
        Expanded(
          child: Row(children: [
            PaaqAvatar(a.initials, size: 34,
                color: PaaqColors.avatarPalette[
                    a.initials.codeUnits.first % 5]),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a.name, style: PaaqText.bodyStrong),
                    Text(a.email, style: PaaqText.small),
                  ]),
            ),
          ]),
        ),
        // ticket type
        SizedBox(
          width: 180,
          child: Row(children: [
            PaaqChip(a.ticketType,
                fg: a.ticketType == 'Gold'
                    ? PaaqColors.chipGoldFg
                    : a.isGroupType
                        ? PaaqColors.chipVipFg
                        : PaaqColors.chipNeutralFg,
                bg: a.ticketType == 'Gold'
                    ? PaaqColors.chipGoldBg
                    : a.isGroupType
                        ? PaaqColors.chipVipBg
                        : PaaqColors.chipNeutralBg,
                radius: 8),
          ]),
        ),
        // purchased
        SizedBox(
            width: 150,
            child: Text(a.purchased,
                style: PaaqText.body.copyWith(color: PaaqColors.textBody))),
        // status
        SizedBox(
          width: 120,
          child: a.isGroupType
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a.groupSummary ?? '',
                        style: PaaqText.body
                            .copyWith(color: PaaqColors.textMuted)),
                    Text('per seat →', style: PaaqText.small),
                  ])
              : (a.status?.chip() ?? const SizedBox()),
        ),
        // chevron (group only)
        SizedBox(
          width: 28,
          child: a.isGroupType
              ? _iconBtn(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  () => setState(() => isExpanded
                      ? _expanded.remove(a.name)
                      : _expanded.add(a.name)),
                )
              : null,
        ),
        // ⋯ refund menu
        SizedBox(
          width: 28,
          child: _iconBtn(Icons.more_vert_rounded, () => _showRefundMenu(a)),
        ),
      ]),
    );

    final widgets = <Widget>[row];
    if (a.isGroupType && isExpanded && (a.seats?.isNotEmpty ?? false)) {
      widgets.add(_seatBreakdown(a.seats!));
    }
    return widgets;
  }

  Widget _seatBreakdown(List<Seat> seats) {
    return Container(
      color: const Color(0xFFF7F9F8),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          for (final s in seats)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(children: [
                SizedBox(
                    width: 48,
                    child: Text('Seat ${s.number}',
                        style: PaaqText.small
                            .copyWith(fontWeight: FontWeight.w500))),
                const SizedBox(width: 11),
                if (s.name != null) ...[
                  PaaqAvatar(s.initials!, size: 28),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.name!, style: PaaqText.bodyStrong.copyWith(fontSize: 13)),
                          Text(s.email!, style: PaaqText.small),
                        ]),
                  ),
                ] else ...[
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                        color: Color(0xFFEEF2F1), shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Text('Awaiting assignment',
                        style: PaaqText.body
                            .copyWith(color: PaaqColors.textFaint)),
                  ),
                ],
                // status column aligned under STATUS (120 + trailing cols)
                SizedBox(
                    width: 120,
                    child: s.status != null
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: s.status!.chip())
                        : const SizedBox()),
                const SizedBox(width: 77),
              ]),
            ),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) => InkWell(
        borderRadius: BorderRadius.circular(PaaqRadii.sm),
        onTap: onTap,
        child: Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          child: Icon(icon, size: 18, color: PaaqColors.textMuted),
        ),
      );

  Widget _pager() {
    Widget page(String n, {bool active = false}) => Container(
          margin: const EdgeInsets.only(left: 6),
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? PaaqColors.ink : PaaqColors.surface,
            borderRadius: BorderRadius.circular(PaaqRadii.sm),
            border: Border.all(
                color: active ? PaaqColors.ink : PaaqColors.line),
          ),
          child: Text(n,
              style: TextStyle(
                  fontFamily: PaaqText.family,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.white : PaaqColors.textBody)),
        );
    return Row(children: [
      _iconBtn(Icons.chevron_left_rounded, () {}),
      page('1', active: true),
      page('2'),
      page('3'),
      page('4'),
      page('5'),
      const SizedBox(width: 6),
      _iconBtn(Icons.chevron_right_rounded, () {}),
    ]);
  }

  // ---- Right rail ----
  Widget _rightRail() {
    return Column(children: [
      PaaqCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Revenue by type', style: PaaqText.h3),
            const SizedBox(height: 14),
            for (final r in SampleData.revenueByType) ...[
              Row(children: [
                Container(width: 8, height: 8,
                    decoration: const BoxDecoration(
                        color: PaaqColors.teal, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Expanded(child: Text(r.$1, style: PaaqText.label)),
                Text(r.$2, style: PaaqText.bodyStrong.copyWith(fontSize: 13)),
              ]),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(3),
                child: LinearProgressIndicator(
                  value: r.$3,
                  minHeight: 6,
                  backgroundColor: const Color(0xFFEEF2F1),
                  valueColor:
                      const AlwaysStoppedAnimation(PaaqColors.teal),
                ),
              ),
              const SizedBox(height: 12),
            ],
            const Divider(height: 1, color: PaaqColors.line),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: Text('Total revenue', style: PaaqText.bodyStrong)),
              Text('₦640,000',
                  style: PaaqText.h3.copyWith(
                      fontSize: 16,
                      color: PaaqColors.statusCheckedInFg)),
            ]),
          ],
        ),
      ),
      const SizedBox(height: 16),
      PaaqCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(child: Text('Event details', style: PaaqText.h3)),
              Text('View event →',
                  style: PaaqText.small.copyWith(
                      color: PaaqColors.tealDark,
                      fontWeight: FontWeight.w600)),
            ]),
            const SizedBox(height: 14),
            _detailRow('Date', SampleData.event.date),
            _detailRow('Location', SampleData.event.location),
            _detailRow('Ticket types', '${SampleData.event.ticketTypes}'),
            _detailRow('Total capacity', '${SampleData.event.capacity}'),
            _detailRow('Fee model', SampleData.event.feeModel, last: true),
          ],
        ),
      ),
    ]);
  }

  Widget _detailRow(String label, String value, {bool last = false}) => Padding(
        padding: EdgeInsets.only(bottom: last ? 0 : 14),
        child: Row(children: [
          Expanded(child: Text(label, style: PaaqText.bodyMuted)),
          Flexible(
            child: Text(value,
                textAlign: TextAlign.right,
                style: PaaqText.bodyStrong.copyWith(fontSize: 13)),
          ),
        ]),
      );

  // ---- Refund menu (single-item) → refund modal ----
  void _showRefundMenu(Attendee a) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (_) => const SizedBox(),
    );
    // For the prototype this hooks to the refund modal route; wired in router.
  }
}
