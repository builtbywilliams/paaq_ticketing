import 'package:flutter/material.dart';
import '../theme/tokens.dart';
import '../theme/paaq_icons.dart';

/// ============================================================================
/// PAAQ reusable widget library (ticketing).
/// Every screen composes from these so styling stays consistent and DRY.
/// ============================================================================

/// A white rounded card with the PAAQ border + optional soft shadow.
class PaaqCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool shadow;
  final double radius;
  const PaaqCard({
    super.key,
    required this.child,
    this.padding,
    this.shadow = false,
    this.radius = PaaqRadii.xl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: PaaqColors.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: PaaqColors.line),
        boxShadow: shadow ? PaaqShadows.card : null,
      ),
      child: child,
    );
  }
}

/// Circular avatar with initials on a deterministic brand colour.
class PaaqAvatar extends StatelessWidget {
  final String initials;
  final double size;
  final Color? color;
  const PaaqAvatar(this.initials, {super.key, this.size = 36, this.color});

  Color get _bg {
    if (color != null) return color!;
    final i = initials.codeUnits.fold<int>(0, (a, b) => a + b) %
        PaaqColors.avatarPalette.length;
    return PaaqColors.avatarPalette[i];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: _bg, shape: BoxShape.circle),
      child: Text(
        initials,
        style: TextStyle(
          fontFamily: PaaqText.family,
          fontSize: size * 0.36,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// A small pill chip. Used for ticket-type and status.
class PaaqChip extends StatelessWidget {
  final String label;
  final Color fg;
  final Color bg;
  final double radius;
  const PaaqChip(this.label,
      {super.key, required this.fg, required this.bg, this.radius = 7});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: PaaqText.family,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: fg,
        ),
      ),
    );
  }
}

/// Ticket status → styled StatusChip. Central mapping so states stay consistent.
enum TicketStatus { checkedIn, issued, cancelled, expired }

extension TicketStatusChip on TicketStatus {
  String get label => switch (this) {
        TicketStatus.checkedIn => 'Checked in',
        TicketStatus.issued => 'Issued',
        TicketStatus.cancelled => 'Cancelled',
        TicketStatus.expired => 'Expired',
      };
  Color get fg => switch (this) {
        TicketStatus.checkedIn => PaaqColors.statusCheckedInFg,
        TicketStatus.issued => PaaqColors.statusIssuedFg,
        TicketStatus.cancelled => PaaqColors.statusCancelledFg,
        TicketStatus.expired => PaaqColors.statusExpiredFg,
      };
  Color get bg => switch (this) {
        TicketStatus.checkedIn => PaaqColors.statusCheckedInBg,
        TicketStatus.issued => PaaqColors.statusIssuedBg,
        TicketStatus.cancelled => PaaqColors.statusCancelledBg,
        TicketStatus.expired => PaaqColors.statusExpiredBg,
      };
  Widget chip() =>
      PaaqChip(label, fg: fg, bg: bg, radius: PaaqRadii.pill);
}

/// Button variants used across ticketing.
enum PaaqButtonVariant { primary, secondary, dark }

class PaaqButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final PaaqButtonVariant variant;
  final VoidCallback? onPressed; // null → disabled look
  final bool expand;
  const PaaqButton({
    super.key,
    required this.label,
    this.icon,
    this.variant = PaaqButtonVariant.secondary,
    this.onPressed,
    this.expand = false,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;
    late Color bg, fg, border;
    switch (variant) {
      case PaaqButtonVariant.primary:
        bg = PaaqColors.teal;
        fg = Colors.white;
        border = PaaqColors.teal;
        break;
      case PaaqButtonVariant.dark:
        bg = PaaqColors.ink;
        fg = Colors.white;
        border = PaaqColors.ink;
        break;
      case PaaqButtonVariant.secondary:
        bg = PaaqColors.surface;
        fg = PaaqColors.textBody;
        border = PaaqColors.line;
        break;
    }
    if (disabled) {
      bg = PaaqColors.surfaceSubtle;
      fg = PaaqColors.textDisabled;
      border = PaaqColors.lineSoft;
    }

    final content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 16, color: fg),
          const SizedBox(width: 6),
        ],
        Text(
          label,
          style: TextStyle(
            fontFamily: PaaqText.family,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: fg,
          ),
        ),
      ],
    );

    return Opacity(
      opacity: disabled ? 1 : 1,
      child: Material(
        color: bg,
        borderRadius: BorderRadius.circular(PaaqRadii.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(PaaqRadii.md),
          onTap: onPressed,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(PaaqRadii.md),
              border: Border.all(color: border),
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}

/// A labelled stat (label above, value below) used in KPI rows.
class PaaqStat extends StatelessWidget {
  final String label;
  final String value;
  final String? suffix;
  final Color? valueColor;
  const PaaqStat(
      {super.key,
      required this.label,
      required this.value,
      this.suffix,
      this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: PaaqText.label.copyWith(color: PaaqColors.textMuted)),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(value,
                style: PaaqText.h1.copyWith(
                    fontSize: 26, color: valueColor ?? PaaqColors.textPrimary)),
            if (suffix != null) ...[
              const SizedBox(width: 5),
              Text(suffix!,
                  style: const TextStyle(
                      fontFamily: PaaqText.family,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: PaaqColors.textFaint)),
            ],
          ],
        ),
      ],
    );
  }
}

/// The PAAQ top navigation bar.
class PaaqTopNav extends StatelessWidget {
  final String active;
  const PaaqTopNav({super.key, this.active = 'Ticketing'});

  @override
  Widget build(BuildContext context) {
    const items = ['Overview', 'Events', 'Ticketing', 'Attendees', 'Finance'];
    return Container(
      height: 64,
      color: PaaqColors.surface,
      padding: const EdgeInsets.symmetric(horizontal: PaaqSpacing.gutter),
      child: Row(
        children: [
          // logo
          Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
                color: PaaqColors.teal,
                borderRadius: BorderRadius.circular(7)),
            alignment: Alignment.center,
            child: const Text('P',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 14)),
          ),
          const SizedBox(width: 8),
          Text('PAAQ',
              style: PaaqText.h3.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(width: 40),
          for (final it in items)
            Padding(
              padding: const EdgeInsets.only(right: 28),
              child: Text(it,
                  style: TextStyle(
                    fontFamily: PaaqText.family,
                    fontSize: 14,
                    fontWeight:
                        it == active ? FontWeight.w700 : FontWeight.w500,
                    color: it == active
                        ? PaaqColors.textPrimary
                        : PaaqColors.textMuted,
                  )),
            ),
          const Spacer(),
          const PaaqAvatar('TE', size: 30, color: PaaqColors.tealTintBg),
        ],
      ),
    );
  }
}

/// Small filter/dropdown trigger chip (Status ▾, Date ▾, etc.).
class PaaqFilterChip extends StatelessWidget {
  final String label;
  final bool active;
  final int? count;
  final VoidCallback? onTap;
  const PaaqFilterChip(this.label,
      {super.key, this.active = false, this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    final fg = active ? PaaqColors.tealDark : PaaqColors.textBody;
    return InkWell(
      borderRadius: BorderRadius.circular(PaaqRadii.md),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.fromLTRB(13, 9, 11, 9),
        decoration: BoxDecoration(
          color: PaaqColors.surface,
          borderRadius: BorderRadius.circular(PaaqRadii.md),
          border: Border.all(
              color: active ? PaaqColors.teal : PaaqColors.line,
              width: active ? 1.4 : 1),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(label,
              style: TextStyle(
                  fontFamily: PaaqText.family,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: fg)),
          if (count != null) ...[
            const SizedBox(width: 8),
            Container(
              width: 18,
              height: 18,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: PaaqColors.tealTintBg, shape: BoxShape.circle),
              child: Text('$count',
                  style: const TextStyle(
                      fontFamily: PaaqText.family,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: PaaqColors.tealDark)),
            ),
          ],
          const SizedBox(width: 6),
          Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: fg),
        ]),
      ),
    );
  }
}

/// A segmented tab pill (On sale / Upcoming / Past / Drafts) — plain, no
/// dropdown caret. Distinct from [PaaqFilterChip], which is a dropdown
/// trigger.
class PaaqTabPill extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback? onTap;
  const PaaqTabPill(this.label, {super.key, this.active = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(9),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: active ? PaaqColors.teal : PaaqColors.surface,
          borderRadius: BorderRadius.circular(9),
          border: active ? null : Border.all(color: PaaqColors.line),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: PaaqText.family,
            fontSize: 13,
            fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            color: active ? Colors.white : PaaqColors.filterInactiveFg,
          ),
        ),
      ),
    );
  }
}

/// A search input field (display-only for the prototype).
class PaaqSearchField extends StatelessWidget {
  final String hint;
  const PaaqSearchField({super.key, this.hint = 'Search'});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      decoration: BoxDecoration(
        color: PaaqColors.surface,
        borderRadius: BorderRadius.circular(PaaqRadii.md),
        border: Border.all(color: PaaqColors.line),
      ),
      child: Row(children: [
        const PaaqIcon(PaaqIcons.search, size: 15),
        const SizedBox(width: 9),
        Text(hint, style: PaaqText.body.copyWith(color: PaaqColors.textFaint)),
      ]),
    );
  }
}
