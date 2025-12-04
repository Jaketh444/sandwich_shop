# Cart Item Modification Feature Requirements

## 1. Feature Description

Enable users to modify items in their cart on the Cart screen. Users should be able to change the quantity of each sandwich, remove items entirely, and optionally undo a removal. This feature improves the user experience by allowing easy corrections and adjustments before checkout, reducing friction and potential order errors.

---

## 2. User Stories

- **As a user, I want to increase or decrease the quantity of a sandwich in my cart, so that I can order the exact number I want.**
- **As a user, I want to remove a sandwich from my cart, so that I can correct mistakes or change my mind before placing the order.**
- **As a user, I want to undo the removal of a sandwich from my cart, so that I can quickly recover from accidental deletions.**
- **As a user, I want the cart total price to update automatically when I modify items, so that I always see the correct amount I will be charged.**
- **As a user, I want to see a message when my cart is empty, so that I know there are no items to purchase.**

---

## 3. Acceptance Criteria

- Users can increase or decrease the quantity of any sandwich in the cart using UI controls (e.g., plus/minus buttons).
- If the quantity of a sandwich is decreased to zero, the item is removed from the cart.
- Users can remove any sandwich from the cart using a remove/delete button.
- After removing an item, a Snackbar appears with an "Undo" option (if undo is implemented).
- If "Undo" is selected, the removed item is restored to the cart with its previous quantity.
- The cart's total price updates immediately after any modification.
- If the cart is empty, a clear message is displayed to the user.
- All changes are reflected in the UI without requiring a page refresh or navigation.
- The feature works consistently across supported devices and screen sizes.

---

## 4. Subtasks

1. **UI Design**
   - Add plus/minus buttons for quantity adjustment next to each cart item.
   - Add a remove/delete icon for each cart item.
   - Display a Snackbar with "Undo" after an item is removed.
   - Show an empty cart message when appropriate.

2. **Cart Model Updates**
   - Implement methods to update item quantity.
   - Ensure removing an item or setting quantity to zero updates the cart correctly.
   - Support restoring a removed item for undo functionality.

3. **State Management**
   - Ensure cart modifications update the UI in real time.
   - Manage temporary storage for recently removed items (for undo).

4. **Pricing Integration**
   - Recalculate and display the total price after any modification.

5. **Testing**
   - Write unit and widget tests for all cart modification actions.
   - Test edge cases (e.g., removing the last item, undoing multiple times).

6. **Documentation**
   - Update user documentation and in-app help (if applicable) to describe the new cart modification features.