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