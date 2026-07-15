# AZHly — updated screens (Flutter)

This is a small standalone Flutter project containing just the pieces we
changed, so you can drop them into your existing app:

```
lib/
  main.dart                          entry point; app opens straight into
                                      StartupGate, a plain 1-second timer
                                      (no bubble splash screen, no logo
                                      animation) that then swaps to Login
  theme/app_theme.dart               light + dark ThemeData — same purple
                                      accent in both (light mode no longer
                                      uses pink)
  widgets/azhly_bottom_nav.dart      bottom nav bar with role-based presets
                                      (teacher / crGr / student); Profile
                                      tab renders as a circular avatar
                                      instead of a generic icon
  widgets/class_card.dart            shared class card widget (department,
                                      room no, block, floor, subject, time
                                      slot, optional teacher name)
  screens/login_screen.dart          plain background, purple button —
                                      shown 1 second after app launch
  screens/teacher_schedule_screen.dart
                                      Teacher > My Schedule (replaces
                                      "Manage Classes" in the nav) — no
                                      teacher name shown on cards
  screens/my_classes_screen.dart     Student / CR-GR > My Classes — today's
                                      classes as cards, teacher name shown
```

Note: the bubbly splash screen was removed on request. The app now just
waits 1 second (`StartupGate` in `main.dart`) and goes straight to Login —
no bubble artwork, no separate splash route.

## Running it standalone

```
flutter pub get
flutter run
```

## Integrating into your existing app

1. Copy `theme/app_theme.dart` in and point your `MaterialApp`'s
   `theme` / `darkTheme` at `AppTheme.light` / `AppTheme.dark`.
2. Copy the `StartupGate` widget from `main.dart` (or just its
   `Future.delayed` + `pushReplacement` logic) and set it as your app's
   `home` so launch goes: app opens → 1 second → Login. No splash bubble
   screen, no separate route needed.
3. Copy `widgets/azhly_bottom_nav.dart` and swap your current
   `BottomNavigationBar` for `AzhlyBottomNav.teacher(...)`,
   `AzhlyBottomNav.crGr(...)`, or `AzhlyBottomNav.student(...)` depending on
   role. Pass a real `avatarUrl` once you have the logged-in user's photo.
4. Copy `widgets/class_card.dart` and use it in your Teacher "My Schedule"
   screen (leave `teacherName` null) and in the Student/CR-GR "My Classes"
   screen (pass `teacherName`).
5. Replace the placeholder data lists in `teacher_schedule_screen.dart` and
   `my_classes_screen.dart` with your real API/provider data — the shape
   is a simple `Map<String, String>` per class, matched to `ClassCard`'s
   constructor fields.

## Notes

- Nothing here touches your Smart Engine (loading/conflict-detection)
  screens, Suggestion Room, or notifications — those were left as-is per
  your last message.
- This project doesn't include your existing auth logic or backend
  calls — it's the visual/structural pieces only, written to drop into a
  real app rather than run as a finished product.
