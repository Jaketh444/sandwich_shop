# Requirements -- Pofile screen

1. **User Profile Screen**
   - Create a new screen called `ProfileScreen`.
   - The screen should display a form with fields for the user's name and email address.
   - Users should be able to enter or edit their details.
   - Display the entered details on the screen.
   - No authentication or saving data between sessions is required.

2. **Navigation**
   - Add a button or link labeled "Profile" at the bottom of the `OrderScreen`.
   - Tapping the button should navigate to the `ProfileScreen`.

3. **UI**
   - Use basic Flutter widgets for the form (e.g., `TextField`, `ElevatedButton`).
   - Make the layout simple and user-friendly.

4. **No Data Persistence**
   - Do not store user details beyond the current session or implement authentication.

5. **Code Organization**
   - Place the new screen in the appropriate `views` folder as `profile_screen.dart`.
   - Ensure navigation works from the `OrderScreen` to the `ProfileScreen`.


   # Enhanced Navigation Requirements

## 1. Global Drawer Navigation
- Implement a Drawer menu accessible from all main screens.
- The Drawer should open via a hamburger icon in the AppBar.

## 2. Drawer Menu Content
- Include navigation links for all major screens (e.g., Home, Profile, Orders, Settings).
- Add a header section (e.g., app logo or user info).
- Optionally, include a logout or settings option.

## 3. Consistent Integration
- Refactor screens to use a shared Scaffold widget that includes the Drawer and AppBar to reduce code duplication.

## 4. Responsive Design
- On wide screens (tablet/desktop), display navigation as a permanent sidebar or NavigationRail.
- On narrow screens (mobile), use the Drawer.

## 5. Navigation Functionality
- Tapping a Drawer item navigates to the corresponding screen.
- Highlight the current screen in the Drawer.

## 6. Accessibility
- Ensure Drawer is accessible via keyboard and screen readers.
- Provide clear labels for navigation items.

## 7. Testing
- Add widget tests to verify Drawer presence, navigation, and responsiveness on different screen sizes.
- Example: `test/views/profile_screen_test.dart` should check for Drawer integration and navigation links.