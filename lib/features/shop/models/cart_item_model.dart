class CartItemModel {
  String productId;
  String title;
  double price;
  String? image;
  int quantity;
  String variationId;
  String? brandName;
  Map<String, String>? selectedVariation;

  CartItemModel({
    required this.productId,
    this.title = '',
    this.price = 0.0,
    required this.quantity,
    this.variationId = '',
    this.image,
    this.brandName,
    this.selectedVariation,
  });

  static CartItemModel empty() {
    return CartItemModel(
      productId: '',
      title: '',
      price: 0.0,
      quantity: 0,
      variationId: '',
      image: '',
      brandName: '',
      selectedVariation: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    try {
      return CartItemModel(
        productId: json['productId'] ?? '',
        title: json['title'] ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        quantity: json['quantity'] ?? 0,
        variationId: json['variationId'] ?? '',
        image: json['image'] ?? '',
        brandName: json['brandName'] ?? '',
        selectedVariation: json['selectedVariation'] != null
            ? Map<String, String>.from(json['selectedVariation'])
            : null,
      );
    } catch (e) {
      print('Error parsing CartItemModel: $e');
      rethrow;
    }
  }
}
