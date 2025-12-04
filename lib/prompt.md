## Prompt for LLM: Implement Cart Item Modification in Flutter Sandwich Shop App

I have a Flutter app for a sandwich shop with these models:
- **Sandwich**: Contains type, size, and bread type.
- **Cart**: Has methods to add, remove, and clear items, and calculates total price.
- **Pricing Repository**: Calculates prices based on quantity and size (price is independent of sandwich type or bread).

**Current Screens:**
- **OrderScreen**: Users select sandwiches and add them to the cart.
- **CartScreen**: Users view cart items and total price.

### New Feature: Modify Cart Items

I want users to be able to modify items in their cart. Please provide Flutter code and UI suggestions for these features:

#### 1. Change Quantity of a Cart Item
- Users can increase or decrease the quantity of a sandwich in the cart (e.g., with plus/minus buttons).
- When quantity changes, update the cart and recalculate the total price.
- If quantity reaches zero, remove the item from the cart.

#### 2. Remove Item from Cart
- Users can remove a sandwich from the cart (e.g., with a delete/trash icon).
- Update the cart and total price after removal.
- If the cart is empty, show a message indicating this.

#### 3. Undo Remove Action (Optional)
- After removing an item, show a Snackbar with an "Undo" button.
- If "Undo" is tapped, restore the item to the cart with its previous quantity.

**Notes:**
- The price of a sandwich depends only on its quantity and size.
- Please use the existing models and repository structure.

**Request:**
- Provide code for the CartScreen UI and any necessary changes to the Cart model to support these features.
- Suggest best practices for state management if needed.