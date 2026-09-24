import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Paths to the icon SVGs exported from Figma, under assets/icons/.
/// Every icon already carries its own colour baked into the vector —
/// [PaaqIcon] renders them as exported unless a [PaaqIcon.color] override is
/// passed for a context the exported colour doesn't fit.
class PaaqIcons {
  PaaqIcons._();

  static const eventCalendar = 'assets/icons/event-calendar.svg';
  static const checkIn = 'assets/icons/check-in.svg';
  static const search = 'assets/icons/search.svg';
  static const plus = 'assets/icons/plus.svg';
  static const withdrawArrow = 'assets/icons/withdraw-arrow.svg';
  static const calendarSm = 'assets/icons/calendar-sm.svg';

  // Exported but not yet used — screens still to be built.
  static const bank = 'assets/icons/bank.svg';
  static const calendar = 'assets/icons/calendar.svg';
  static const calendarWhite = 'assets/icons/calendar-white.svg';
  static const check = 'assets/icons/check.svg';
  static const checkCircle = 'assets/icons/check-circle.svg';
  static const checkboxChecked = 'assets/icons/checkbox-checked.svg';
  static const checkboxMinus = 'assets/icons/checkbox-minus.svg';
  static const chevronDown = 'assets/icons/chevron-down.svg';
  static const chevronDownTeal = 'assets/icons/chevron-down-teal.svg';
  static const chevronLeft = 'assets/icons/chevron-left.svg';
  static const chevronRight = 'assets/icons/chevron-right.svg';
  static const chevronUp = 'assets/icons/chevron-up.svg';
  static const chevronUpTeal = 'assets/icons/chevron-up-teal.svg';
  static const clock = 'assets/icons/clock.svg';
  static const closeX = 'assets/icons/close-x.svg';
  static const editPencil = 'assets/icons/edit-pencil.svg';
  static const filter = 'assets/icons/filter.svg';
  static const flash = 'assets/icons/flash.svg';
  static const infoCircle = 'assets/icons/info-circle.svg';
  static const kebab = 'assets/icons/kebab.svg';
  static const manualEntry = 'assets/icons/manual-entry.svg';
  static const refund = 'assets/icons/refund.svg';
  static const scanFail = 'assets/icons/scan-fail.svg';
  static const scanFrame = 'assets/icons/scan-frame.svg';
  static const scanPending = 'assets/icons/scan-pending.svg';
  static const scanSuccess = 'assets/icons/scan-success.svg';
  static const share = 'assets/icons/share.svg';
  static const shareBox = 'assets/icons/share-box.svg';
  static const ticket = 'assets/icons/ticket.svg';
  static const ticketDashed = 'assets/icons/ticket-dashed.svg';
  static const trash = 'assets/icons/trash.svg';
  static const videoCamera = 'assets/icons/video-camera.svg';
  static const wallet = 'assets/icons/wallet.svg';
  static const warningCircle = 'assets/icons/warning-circle.svg';
}

/// Renders one of [PaaqIcons] at an exact size. Leave [color] null (the
/// default) to render the icon exactly as exported from Figma.
class PaaqIcon extends StatelessWidget {
  final String asset;
  final double size;
  final Color? color;
  const PaaqIcon(this.asset, {super.key, required this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: size,
      height: size,
      colorFilter:
          color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}
