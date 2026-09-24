import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/tokens.dart';
import '../theme/paaq_icons.dart';
import '../widgets/paaq_widgets.dart';
import '../data/models.dart';

/// Which of the four tickets-list tabs is showing. Only [onSale] has its
/// Figma frame built out (66748:51746); the others are routed and share the
/// same header/KPI/toolbar shell but show a placeholder list for now.
enum TicketsListTab { onSale, upcoming, past, drafts }

extension on TicketsListTab {
  String get label => switch (this) {
        TicketsListTab.onSale => 'On sale',
        TicketsListTab.upcoming => 'Upcoming',
        TicketsListTab.past => 'Past',
        TicketsListTab.drafts => 'Drafts',
      };
  String get route => switch (this) {
        TicketsListTab.onSale => '/',
        TicketsListTab.upcoming => '/tickets/upcoming',
        TicketsListTab.past => '/tickets/past',
        TicketsListTab.drafts => '/tickets/drafts',
      };
}

/// Tickets list — the account-level ticketing dashboard. One page, four
/// tabs; see Handoff §3a. Figma node 66748:51746 (On sale tab).
class TicketsListPage extends StatelessWidget {
  final TicketsListTab tab;
  const TicketsListPage({super.key, this.tab = TicketsListTab.onSale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PaaqTopNav(active: 'Ticketing'),
            Padding(
              padding:
                  const EdgeInsets.fromLTRB(PaaqSpacing.gutter, 32, PaaqSpacing.gutter, 48),
              child: Center(
                child: ConstrainedBox(
                  constraints:
                      const BoxConstraints(maxWidth: PaaqSpacing.contentMax),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _header(context),
                      const SizedBox(height: 24),
                      const TicketsKpiHeader(),
                      const SizedBox(height: 24),
                      _toolbarRow(context),
                      const SizedBox(height: 24),
                      _list(),
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

  // ---- Header: title + Withdraw / Create ticket ----
  Widget _header(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ticketing', style: PaaqText.pageTitle),
              const SizedBox(height: 4),
              Text('Tickets, buyers and check-in for your events.',
                  style: PaaqText.body.copyWith(color: PaaqColors.textMuted)),
            ],
          ),
        ),
        _WithdrawButton(onPressed: () => _openWithdraw(context)),
        const SizedBox(width: 12),
        _CreateTicketButton(onPressed: () {}),
      ],
    );
  }

  void _openWithdraw(BuildContext context) {
    // Withdraw modal (66835:50386) is built separately — placeholder for now.
  }

  // ---- Toolbar: search + On sale/Upcoming/Past/Drafts tabs ----
  Widget _toolbarRow(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 280, child: PaaqSearchField(hint: 'Search tickets')),
        const Spacer(),
        for (final t in TicketsListTab.values) ...[
          PaaqTabPill(t.label,
              active: t == tab,
              onTap: t == tab ? null : () => context.go(t.route)),
          if (t != TicketsListTab.values.last) const SizedBox(width: 8),
        ],
      ],
    );
  }

  // ---- List body ----
  Widget _list() {
    if (tab != TicketsListTab.onSale) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 64),
        decoration: BoxDecoration(
          color: PaaqColors.surface,
          borderRadius: BorderRadius.circular(PaaqRadii.xl),
          border: Border.all(color: PaaqColors.line),
        ),
        alignment: Alignment.center,
        child: Text('No ${tab.label.toLowerCase()} tickets yet.',
            style: PaaqText.body.copyWith(color: PaaqColors.textMuted)),
      );
    }
    return Column(
      children: [
        for (final e in SampleData.onSaleEvents) ...[
          _EventCard(item: e),
          if (e != SampleData.onSaleEvents.last) const SizedBox(height: 16),
        ],
      ],
    );
  }
}

/// The Withdraw button in the tickets-list header (66834:50386): white bg,
/// 1.3px border, ink text/icon — distinct from PaaqButton's variants.
class _WithdrawButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _WithdrawButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PaaqColors.surface,
      borderRadius: BorderRadius.circular(PaaqRadii.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(PaaqRadii.md),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 11, 18, 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(PaaqRadii.md),
            border: Border.all(color: PaaqColors.line, width: 1.3),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PaaqIcon(PaaqIcons.withdrawArrow, size: 17),
              SizedBox(width: 8),
              Text('Withdraw',
                  style: TextStyle(
                      fontFamily: PaaqText.family,
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: PaaqColors.textPrimary)),
            ],
          ),
        ),
      ),
    );
  }
}

/// The teal "+ Create ticket" button (66748:51773).
class _CreateTicketButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _CreateTicketButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PaaqColors.teal,
      borderRadius: BorderRadius.circular(PaaqRadii.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(PaaqRadii.md),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 11, 18, 11),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PaaqIcon(PaaqIcons.plus, size: 16, color: Colors.white),
              SizedBox(width: 8),
              Text('Create ticket',
                  style: TextStyle(
                      fontFamily: PaaqText.family,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

/// One KPI tile — white card, 0.5px border, radius 14. Used for all 5 tiles
/// in the tickets-list header so they can't drift apart again; the 5th tile
/// passes [footer] for its extra "Next payout" line.
class KpiTile extends StatelessWidget {
  final String label;
  final String value;
  final Widget? footer;
  const KpiTile(
      {super.key, required this.label, required this.value, this.footer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
        color: PaaqColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: PaaqColors.line, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: const TextStyle(
                  fontFamily: PaaqText.family,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: PaaqColors.textMuted)),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                  fontFamily: PaaqText.family,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                  color: PaaqColors.textPrimary)),
          if (footer != null) ...[
            const SizedBox(height: 6),
            footer!,
          ],
        ],
      ),
    );
  }
}

/// The account-level KPI row shared by all four tickets-list tabs (66748:51776):
/// 4 plain stat tiles + the "Available to withdraw / Next payout" tile, all
/// equal height, all built from the one [KpiTile] widget.
class TicketsKpiHeader extends StatelessWidget {
  const TicketsKpiHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: KpiTile(label: 'Total revenue', value: '₦1,597,500')),
          SizedBox(width: 16),
          Expanded(
              child:
                  KpiTile(label: 'Total tickets sold', value: '64 of 225')),
          SizedBox(width: 16),
          Expanded(child: KpiTile(label: 'Checked in', value: '12')),
          SizedBox(width: 16),
          Expanded(child: KpiTile(label: 'Active events', value: '4')),
          SizedBox(width: 16),
          Expanded(
            child: KpiTile(
              label: 'Available to withdraw',
              value: '₦1,412,500',
              footer: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PaaqIcon(PaaqIcons.calendarSm, size: 13),
                  SizedBox(width: 5),
                  Text('Next payout · Fri, 3 Oct',
                      style: TextStyle(
                          fontFamily: PaaqText.family,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: PaaqColors.tealDark)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventListItem item;
  const _EventCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PaaqColors.surface,
        borderRadius: BorderRadius.circular(PaaqRadii.xl),
        border: Border.all(color: PaaqColors.line),
        boxShadow: PaaqShadows.card,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFFDBF5F5), Color(0xFFC3ECEC)],
                    ),
                  ),
                  child: const PaaqIcon(PaaqIcons.eventCalendar, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(item.title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: PaaqText.family,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.2,
                                    color: PaaqColors.textStrong)),
                          ),
                          const SizedBox(width: 9),
                          _typeBadge(item.typeLabel),
                          if (item.isFree) ...[
                            const SizedBox(width: 8),
                            _freeEventBadge(),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(item.dateLine,
                          style: const TextStyle(
                              fontFamily: PaaqText.family,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: PaaqColors.textBody)),
                    ],
                  ),
                ),
                if (item.price != null) ...[
                  _stat('Price', item.price!),
                  const SizedBox(width: 20),
                ],
                _stat(item.soldLabel, item.soldValue),
                const SizedBox(width: 20),
                _stat(item.revenueValue == 'Free' ? 'Revenue' : 'Revenue',
                    item.revenueValue,
                    big: true),
                const SizedBox(width: 14),
                _checkInButton(item.checkInEnabled),
                const SizedBox(width: 10),
                _viewButton(item.viewPlural),
              ],
            ),
          ),
          if (item.ticketTypeRows != null) _table(item),
        ],
      ),
    );
  }

  Widget _stat(String label, String value, {bool big = false}) {
    final isFreeValue = value == 'Free';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: const TextStyle(
                fontFamily: PaaqText.family,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
                color: PaaqColors.textFaint)),
        const SizedBox(height: 2),
        Text(value,
            style: TextStyle(
                fontFamily: PaaqText.family,
                fontSize: big ? 16 : 14,
                fontWeight: big ? FontWeight.w700 : FontWeight.w600,
                letterSpacing: big ? -0.2 : -0.1,
                color: isFreeValue ? PaaqColors.freeEventFg : PaaqColors.textStrong)),
      ],
    );
  }

  Widget _typeBadge(String label) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
        decoration: BoxDecoration(
            color: PaaqColors.chipSingleBg,
            borderRadius: BorderRadius.circular(PaaqRadii.pill)),
        child: Text(label,
            style: const TextStyle(
                fontFamily: PaaqText.family,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: PaaqColors.chipSingleFg)),
      );

  Widget _freeEventBadge() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
        decoration: BoxDecoration(
            color: PaaqColors.freeEventBg,
            borderRadius: BorderRadius.circular(PaaqRadii.pill)),
        child: const Text('Free event',
            style: TextStyle(
                fontFamily: PaaqText.family,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: PaaqColors.freeEventFg)),
      );

  Widget _checkInButton(bool enabled) {
    final bg = enabled ? PaaqColors.surface : PaaqColors.checkInDisabledBg;
    final border = enabled ? PaaqColors.line : PaaqColors.chipSingleBg;
    final fg = enabled ? PaaqColors.textBody : PaaqColors.textDisabled;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(PaaqRadii.md),
        border: Border.all(color: border),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        PaaqIcon(PaaqIcons.checkIn, size: 15, color: enabled ? null : fg),
        const SizedBox(width: 6),
        Text('Check in',
            style: TextStyle(
                fontFamily: PaaqText.family,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: fg)),
      ]),
    );
  }

  Widget _viewButton(bool plural) => Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: PaaqColors.surfaceSubtle,
          borderRadius: BorderRadius.circular(PaaqRadii.md),
          border: Border.all(color: PaaqColors.line),
        ),
        child: Text(plural ? 'View tickets' : 'View ticket',
            style: const TextStyle(
                fontFamily: PaaqText.family,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: PaaqColors.textStrong)),
      );

  Widget _table(EventListItem item) {
    final rows = item.ticketTypeRows!;
    final col2Header = item.isFree ? 'REGISTERED' : 'SOLD';
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: PaaqColors.pageBg,
        border: Border(top: BorderSide(color: PaaqColors.line)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 9),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: PaaqColors.line))),
            child: Row(
              children: [
                SizedBox(width: 340, child: _colHeader('TICKET TYPE')),
                SizedBox(width: 180, child: _colHeader(col2Header)),
                SizedBox(width: 150, child: _colHeader('PRICE')),
              ],
            ),
          ),
          for (var i = 0; i < rows.length; i++)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                border: i == 0
                    ? null
                    : const Border(top: BorderSide(color: PaaqColors.line)),
              ),
              child: Row(
                children: [
                  _statusDot(rows[i].statusLabel),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 324,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(rows[i].name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: PaaqText.family,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: PaaqColors.textStrong)),
                        ),
                        const SizedBox(width: 8),
                        _rowTypeChip(rows[i].isGroup),
                        const SizedBox(width: 8),
                        _availabilityChip(rows[i].statusLabel),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 180,
                    child: Text(rows[i].soldText,
                        style: const TextStyle(
                            fontFamily: PaaqText.family,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: PaaqColors.textBody)),
                  ),
                  SizedBox(
                    width: 150,
                    child: Text(rows[i].price,
                        style: TextStyle(
                            fontFamily: PaaqText.family,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: rows[i].price == 'Free'
                                ? PaaqColors.freeEventFg
                                : PaaqColors.textStrong)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _colHeader(String label) => Text(label,
      style: const TextStyle(
          fontFamily: PaaqText.family,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
          color: PaaqColors.textFaint));

  Widget _statusDot(String status) {
    final color = switch (status) {
      'On sale' || 'Open' => PaaqColors.availOnSaleFg,
      'Sold out' => PaaqColors.availSoldOutFg,
      _ => PaaqColors.availClosedFg,
    };
    return Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)));
  }

  Widget _rowTypeChip(bool isGroup) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
            color: isGroup ? PaaqColors.chipVipBg : PaaqColors.chipSingleBg,
            borderRadius: BorderRadius.circular(PaaqRadii.pill)),
        child: Text(isGroup ? 'Group' : 'Single',
            style: TextStyle(
                fontFamily: PaaqText.family,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: isGroup ? PaaqColors.chipVipFg : PaaqColors.chipSingleFg)),
      );

  Widget _availabilityChip(String status) {
    final Color fg, bg;
    switch (status) {
      case 'On sale':
      case 'Open':
        fg = PaaqColors.availOnSaleFg;
        bg = PaaqColors.availOnSaleBg;
        break;
      case 'Sold out':
        fg = PaaqColors.availSoldOutFg;
        bg = PaaqColors.availSoldOutBg;
        break;
      default:
        fg = PaaqColors.availClosedFg;
        bg = PaaqColors.availClosedBg;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(PaaqRadii.pill)),
      child: Text(status,
          style: TextStyle(
              fontFamily: PaaqText.family,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: fg)),
    );
  }
}
