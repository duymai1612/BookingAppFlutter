# Booking App Flutter

A desktop-first interactive booking page prototype built in Flutter, following a real-world interview assignment. This project demonstrates best practices in Flutter architecture, state management, and UI implementation, closely matching a provided Figma/mockup design.

## Features
- **Three-column layout**: Duration, Date Picker, and Time Slots, optimized for desktop (macOS, iPad, large screens)
- **Participants bar**: Add/remove mock participants with avatars (top header)
- **Step headers**: Clear 1/2/3 step titles for user flow
- **Duration selection**: 15, 30, 60 min options, only one selectable
- **Date picker**: Calendar with month navigation, prevents >3 months in future
- **Time slots**: 15-minute increments, two-column grid, random slots disabled per day
- **Confirmation panel**: Floating card at bottom-right, animated, shows summary and confirm/cancel
- **Timezone selector**: Editable, full world list, styled pill
- **Booking logic**: On confirm, calls backend API and disables all slots within the selected duration
- **State management**: Provider + ChangeNotifier, stateless-first widgets
- **Accessibility**: Keyboard navigation, text scale, color contrast
- **Testing**: (See `/test`) Widget tests for selection, date limits, confirmation bar

## Project Structure
```
lib/
  core/theme/         # AppTheme, AppColors
  data/               # EventRepository (API integration)
  domain/             # DummyData (slots, durations)
  features/booking/
    application/      # BookingController (state, logic)
    presentation/
      pages/          # BookingPage (main screen)
      sections/       # DurationSection, DatePickerSection, TimeSlotsSection
      widgets/        # DurationOptionChip, CalendarDayButton, TimeSlotTile, ConfirmationBar, ParticipantsBar, StepsHeader
```

## How to Run
1. **Install dependencies**:
   ```bash
   flutter pub get
   ```
2. **Run on macOS desktop** (recommended):
   ```bash
   flutter run -d macos
   ```
   Or use iPad simulator for large-screen preview.
3. **Run tests**:
   ```bash
   flutter test
   ```

## API Integration
- On booking confirmation, sends a POST to `http://localhost:8080/api/Event/create` with:
  - `duration`: e.g. `30 MIN`, `1 HOUR`
  - `date`: `YYYY-MM-DD`
  - `time`: `HH:MM AM/PM`
  - `participants`: `[1]` (TODO: real participant management)
- After booking, disables all slots within the selected duration window
- Randomly disables 6 slots per day to simulate unavailability

## Notes for Reviewers
- **No backend required**: All data except booking API is local/dummy
- **No mobile layout**: Per assignment, only desktop/iPad is supported
- **Design fidelity**: UI matches provided mockup as closely as possible (colors, spacing, shadows, etc.)
- **Extensible**: Easy to add real participant/user management, backend slot fetching, or mobile support
- **Code quality**: Linted, formatted, idiomatic Dart/Flutter, clear separation of concerns

---

**Made with care by a senior Flutter engineer for interview demonstration.**
