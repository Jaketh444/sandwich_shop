/// PricingRepository calculates sandwich prices based on size and quantity.
///
/// Prices are expressed in whole pounds (int) to avoid floating point
/// rounding issues when dealing with simple currency amounts used in
/// this exercise. If you need pence-level precision later, we can switch
/// to representing values as integer pence instead.
class PricingRepository {
  static const int sixInchPricePounds = 7;
  static const int footlongPricePounds = 11;

  const PricingRepository();

  /// Returns the price per sandwich in whole pounds for the given size.
  ///
  /// Use [isFootlong] = true for a footlong, false for a six-inch.
  int pricePerSandwich({required bool isFootlong}) {
    return isFootlong ? footlongPricePounds : sixInchPricePounds;
  }

  /// Returns the total price in whole pounds for [quantity] sandwiches of
  /// the given size.
  int totalPricePounds({required bool isFootlong, required int quantity}) {
    if (quantity <= 0) return 0;
    return pricePerSandwich(isFootlong: isFootlong) * quantity;
  }

  /// Helper that returns a formatted string with a leading pound sign,
  /// e.g. "£21".
  String formattedTotal({required bool isFootlong, required int quantity}) {
    final int pounds = totalPricePounds(isFootlong: isFootlong, quantity: quantity);
    return '£$pounds';
  }
}
