class ProductVariationModel {
  final String id;
  String sku;
  String image;
  String description;
  double price;
  double salePrice;
  int stock;
  Map<String, String> attributeValues;

  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.price = 0.0,
    this.salePrice = 0.0,
    this.stock = 0,
    required this.attributeValues,
    this.description = '',
  });

  // Empty helper function
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  // Map model to json format
  toJson() {
    return {
      'id': id,
      'image': image,
      'description': description,
      'price': price,
      'salePrice': salePrice,
      'SKU': sku,
      'stock': stock,
      'attributeValues': attributeValues,
    };
  }

  // Map json to model
  factory ProductVariationModel.fromSnapshot(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
        id: data['id'] ?? '',
        price: double.parse((data['price'] ?? 0.0).toString()),
        sku: data['SKU'] ?? '',
        stock: data['stock'] ?? 0,
        salePrice: double.parse((data['salePrice'] ?? 0.0).toString()),
        image: data['image'] ?? '',
        attributeValues: Map<String, String>.from(data['attributeValues']));
  }
}
