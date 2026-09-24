# PAAQ Ticketing — Prototype Wiring Map
(Mirror of the project doc `claude/ticketing-prototype-wiring.md`. Drop into the repo so Claude Code can read it.)

Figma file `Crcdvg7h55ihIcy6clT3Nq` · page "PAAQ App Main" · section "Ticket" (`66928:39066`).

## Tickets list — one page, four tabs
On sale `66748:51746` · Upcoming `66840:50386` · Past `66867:50386` · Drafts `66869:50386`.
KPI header wallet card + Withdraw button -> withdraw modal `66835:50386` (empty `66928:38499`).

## Ticket-detail tab sets (Paid=3 tabs, Free=2 tabs)
| Variant | Overview | Attendees | Finance |
|---|---|---|---|
| Multiple·Paid | 66879:50386 | 66891:50386 | 66893:50386 (host-pays 66897:50386) |
| Multiple·Free | 66908:50386 | 66909:50386 | - |
| Multiple·Mixed | 66917:51602 | 66921:50395 | 66923:50386 |
| Single·Paid | 66904:50386 | 66904:50775 | 66906:50386 |
| Single·Free | 66914:50386 | 66914:50772 | - |
| Group·Paid | 66914:51158 | 66914:51506 | 66915:50386 |
| Group·Free | 66915:50660 | 66915:51005 | - |
| Sold-out·Paid | 66915:51350 | 66916:50386 | 66917:50386 |
| Sold-out·Free | 66917:50665 | 66917:51133 | - |

Overlays: refund menu 66737:50386 -> modal 66725:50386; filters 66741/66744/66745:50386;
scan station 66753:50386 -> results 66771:50386.

Rules: refund full-only; fee host-set (buyer-pays vs host-pays); every type has a description
(shown in expandable Overview rows); free events -> registrations + no Finance tab; no Export.
