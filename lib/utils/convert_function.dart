class ConvertFunction{
  static double applyDiscount(String discount, double totalAmount) {
    double discountPercentage = double.parse(discount.replaceAll('%', ''));

    double discountAmount = totalAmount * (discountPercentage / 100);

    double finalAmount = totalAmount - discountAmount;

    return finalAmount;
  }
  static double removeDiscount(String discount, double totalAmount) {
    double discountPercentage = double.parse(discount.replaceAll('%', ''));

    double discountAmount = totalAmount * (discountPercentage / 100);

    double finalAmount = totalAmount + discountAmount;

    return finalAmount;


  }
  static double discount(String discount, double totalAmount) {
    double discountPercentage = double.parse(discount.replaceAll('%', ''));

    double discountAmount = totalAmount * (discountPercentage / 100);


    return discountAmount;
  }
}