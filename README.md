## Sandwich Shop App

A small Flutter demo app for building and previewing sandwich orders. The app demonstrates a basic ordering UI with quantity controls, special-request notes, bread selection, sandwich size selection, and simple pricing logic. It's intended as a learning/demo project or a tiny starting point for a point-of-sale UI.

Key features
- Add / Remove sandwich quantity with max/min enforcement (business rules enforced by `OrderRepository`).
- Enter special requests for the current sandwich order (notes) via a `TextField`.
- Choose bread type (white / wheat / wholemeal) using a `DropdownMenu`.
- Choose sandwich size (six-inch / footlong) using a Switch control.
- Toasted toggle (shows a small status line in the item display).
- Reusable UI: `StyledButton` for consistent Add/Remove visuals.
- `OrderRepository` as the single source of truth for quantity.
- `PricingRepository` provides pricing (six-inch = £7, footlong = £11) and helpers to compute totals.

## Installation & setup

Prerequisites
- Flutter SDK (stable channel) installed and configured: https://flutter.dev/docs/get-started/install
- Git for cloning the repository
- An emulator or device to run the app (optional for tests)

Clone and install
```powershell
git clone https://github.com/Jaketh444/sandwich_shop.git
cd sandwich_shop
flutter pub get
```

Run the app
```powershell
flutter run
# To target a specific device: flutter run -d <device-id>
```

Static analysis (recommended)
```powershell
flutter analyze
```

## What the app contains
- Entry point: `lib/main.dart` (contains `App`, `OrderScreen`, `OrderItemDisplay`, and UI wiring).
- UI helpers: `lib/views/app_styles.dart` (typography/styles used in tests and UI).
- Repositories: `lib/repositories/order_repository.dart` (quantity rules) and `lib/repositories/pricing_repository.dart` (pricing and totals).
- Tests: widget and unit tests under `test/`.

Notes on tests and test keys
- Several widgets expose `Key`s to make tests stable and unambiguous:
	- `Key('notes_textfield')` for the notes `TextField`.
	- `Key('size_switch')` for the sandwich size `Switch`.
	- `Key('toast_switch')` for the toasted `Switch`.
	- `Key('toast_status')` for the toast status `Text` shown in the `OrderItemDisplay`.

## Running tests
Run the whole test suite:
```powershell
flutter test --reporter=expanded
```

Run a single test file (example):
```powershell
flutter test test/views/widget_test.dart --reporter=expanded
```

## Pricing
- `PricingRepository` (in `lib/repositories/pricing_repository.dart`) contains the pricing logic used by tests and can be used by the UI:
	- six-inch price: £7
	- footlong price: £11

It exposes helpers to compute the total in whole pounds and to format a total like `£21`.

## Project layout (high-level)
- `lib/` — app source
	- `main.dart` — app entry and primary widgets
	- `views/` — styles and small view helpers
	- `repositories/` — `order_repository.dart`, `pricing_repository.dart`
- `test/` — unit and widget tests (e.g., `test/views/widget_test.dart`, `test/repositories/*_test.dart`)
- platform folders: `android/`, `ios/`, `linux/`, `macos/`, `web/`, `windows/`

## Known limitations
- Single-order model: there's only one active order/quantity tracked by `OrderRepository`.
- No persistence: orders are not saved to disk or synced to a backend.
- Currency: prices are represented in whole pounds (int). If you need pence-level precision, represent values in pence.

## Next improvements you might consider
- Display live total price in the UI using `PricingRepository` and the selected size + quantity.
- Switch to an enum for sandwich sizes and centralize it in a small model file to avoid using raw booleans across the codebase.
- Add a cart model to hold multiple different sandwich items.

## Contributing
- Fork the repo → create a branch → implement changes → open a PR. Add tests for any new behavior.

## Contact
- Repository owner: Jaketh444
- GitHub: https://github.com/Jaketh444/sandwich_shop