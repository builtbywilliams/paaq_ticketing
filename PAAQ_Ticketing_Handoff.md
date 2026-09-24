# PAAQ Ticketing — Flutter Web Build Brief (for Claude Code)

Goal: a **pixel-perfect, functional Flutter web app** recreating the PAAQ
ticketing dashboard from Figma, shareable with devs. Open this in Claude Code
inside the Flutter repo and work through it.

---

## 0. Source of truth
- **Figma file:** `Crcdvg7h55ihIcy6clT3Nq` (PAAQ App) · page **"PAAQ App Main"**
  · section **"Ticket"** (`66928:39066`) — every current ticketing screen lives here.
- Use the Figma MCP (`get_screenshot`, `get_design_context`, `get_metadata`) on
  each node ID below to match spacing, sizes, and colours exactly. Screenshot the
  running Flutter page and diff against the Figma frame until it matches.
- Desktop canvas width **1440px**, content column max **1220px**, side gutter **110px**. Light mode only.
- Font: **Plus Jakarta Sans** (weights 400/500/600/700/800).

## 1. Design tokens (already scaffolded — canonical)
See `lib/theme/tokens.dart`. Teal `#00B5B4`, teal-deep `#0A8E8D`, ink `#181F1F`,
page bg `#F4F6F6`, surface `#FFFFFF`, field `#F6F8F8`, line `#E9EEED`. Card radius 16,
button/input 10, chip 8/pill 999. Card shadow `0 5px 18px -2px rgba(24,38,38,.05)`.
Status chips: Checked-in green, Issued blue, Cancelled `#E35369`, Expired amber.
Type chips: Single neutral `#EEF1F0`/`#4B5563`, Group purple `#EEEBFE`/`#5B4BB7`.

## 2. Architecture (already scaffolded — extend, don't restructure)
tokens.dart → app_theme.dart → `paaq_widgets.dart` (PaaqCard, PaaqChip, PaaqButton,
PaaqStat, PaaqTopNav, filter/search, TicketStatus) → `models.dart` (SampleData) →
`screens/*.dart` → `router/app_router.dart` (go_router). Reference screen already built:
`lib/screens/multiple_event_page.dart` — but note it predates the tab split (§3); rebuild
detail screens per the tab architecture below.

## 3. Screens to build (Figma node IDs → routes)

### 3a. Tickets list — one page, four tabs
| Tab | Figma node | Route |
|---|---|---|
| On sale | `66748:51746` | `/` |
| Upcoming | `66840:50386` | `/tickets/upcoming` |
| Past | `66867:50386` | `/tickets/past` |
| Drafts | `66869:50386` | `/tickets/drafts` |

KPI header row leads with a **wallet/balance card** (Available to withdraw + Next payout)
and the header has a **Withdraw** button beside **Create ticket**. See §5.

### 3b. Ticket-detail screens — each is now SEGMENTED into tabs
Underline-style section tab bar under the event/ticket-group header. **Paid → 3 tabs
(Overview · Attendees · Finance). Free → 2 tabs (Overview · Attendees), no Finance.**

| Detail screen | Overview | Attendees | Finance |
|---|---|---|---|
| Multiple · Paid | `66879:50386` | `66891:50386` | `66893:50386` (+ host-pays `66897:50386`) |
| Multiple · Free | `66908:50386` | `66909:50386` | — |
| Multiple · Mixed | `66917:51602` | `66921:50395` | `66923:50386` |
| Single · Paid | `66904:50386` | `66904:50775` | `66906:50386` |
| Single · Free | `66914:50386` | `66914:50772` | — |
| Group · Paid | `66914:51158` | `66914:51506` | `66915:50386` |
| Group · Free | `66915:50660` | `66915:51005` | — |
| Sold-out · Paid | `66915:51350` | `66916:50386` | `66917:50386` |
| Sold-out · Free | `66917:50665` | `66917:51133` | — |

Route suggestion: `/type/<variant>/<tab>` (e.g. `/type/single-paid/finance`).

### 3c. Overlays / components
- Withdraw modal `66835:50386`; withdraw modal **empty state** `66928:38499`.
- Refund menu `66737:50386` → Refund modal `66725:50386` (full-refund only).
- Filter dropdowns: Status/Type `66741:50386`, Date custom range `66744:50386`, Ticket-type `66745:50386`.
- Check-in scan station `66753:50386`; scan result states `66771:50386`.

## 4. What each detail tab contains
- **Overview** — event/ticket summary, About card, the sales/registrations-by-type
  table with **expandable rows revealing each ticket type's full description + Edit-ticket
  entry moved to the hero**, and the details/states rail. Single/Group show the type
  description in the Overview; sold-out shows Ticket/Seat states.
- **Attendees** — attendance KPIs + full-width attendees table (search, Status/Date
  [+ Ticket-type on multi] filters, group/seat expansion, per-row ⋯ refund, pagination).
  Sold-out variants include the **Waitlist** card here. No Export CSV.
- **Finance** — Gross / Refunds / Net / Next-payout KPIs; a Revenue breakdown that shows
  the service fee **explicitly**; a full **Transactions** table (search + filters +
  pagination, same toolbar as attendees); Revenue-by-type (multi-type only); a Payout card.

## 5. Withdraw / payouts (account-level, on the tickets list)
- KPI header wallet card `66834:*` inside KPI row `66748:51776`: wallet icon, "Available
  to withdraw ₦X", divider, "Next payout · <date>" (teal). All 5 KPI tiles equal height.
- Header **Withdraw** button (outlined) → withdraw modal `66835:50386`: available box +
  next payout, editable Amount + Max, "Deposit to" bank selector, summary (fee / you'll
  receive / arrives), teal Withdraw. **Empty state** `66928:38499` = placeholders + disabled action.
- Withdrawals are **schedule-only**; "Next payout" is the next date funds can be pulled.

## 6. Product rules baked into the design (don't drift)
- Ticket model: main type Single/Multiple; category Single/Group is a property. Group seats
  assigned by the **purchaser** (organiser view read-only). One ⋯ refund per purchaser row.
- Refund = **full only**. Fee model is **host-set**: **buyer-pays** (fee on top, not deducted
  from payout, shown as "collected from buyers") OR **host-pays** (fee deducted; Finance shows
  Gross − Fee − Refunds = Net, with per-transaction Net). Each event renders the matching mode.
- **Every ticket type has a description**; it renders in the Overview's expandable table rows
  (and in full on the per-type context), never crammed into the compact table.
- Free events: revenue → registrations everywhere, price "Free", "No fees (free tickets)",
  and NO Finance tab. Mixed events: Finance counts paid tiers only; free tiers show as registrations.
- Check-in serves virtual + physical; external camera via inline picker; only fallback is manual
  ticket-code entry. No name-search. Export is NOT in the PRD — no Export buttons.

## 7. Definition of done
- `flutter run -d chrome` renders every screen; `flutter analyze` clean.
- Each screen matches its Figma frame (screenshot-diff). Tabs switch; overlays open.
- Sample data in `models.dart`, ready to swap for real API repositories.
