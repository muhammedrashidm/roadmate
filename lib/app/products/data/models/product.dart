import 'dart:convert';

import 'package:roadmate/app/products/domain/enities/product.dart';

ProductsResponse productsResponseFromMap(String str) =>
    ProductsResponse.fromMap(json.decode(str));

class ProductsResponse {
  bool error;
  List<ProductModal> product;
  String message;

  ProductsResponse({
    required this.error,
    required this.product,
    required this.message,
  });

  factory ProductsResponse.fromMap(Map<String, dynamic> json) =>
      ProductsResponse(
        error: json["error"],
        product: List<ProductModal>.from(
            json["product"].map((x) => ProductModal.fromMap(x))),
        message: json["message"],
      );
}

class ProductModal extends Product {
  const ProductModal({
    required super.id,
    required super.brandId,
    required super.productName,
    required super.offerPrice,
    required super.price,
    required super.description,
    required super.status,
    required super.hsncode,
    required super.priority,
    required super.prate,
    required super.createdAt,
    required super.updatedAt,
    required super.tax,
    required super.images,
  });

  factory ProductModal.fromMap(Map<String, dynamic> json) => ProductModal(
        id: json["id"],
        brandId: json["brand_id"],
        productName: json["product_name"],
        offerPrice: json["offer_price"],
        price: json["price"],
        description: json["description"],
        status: json["status"],
        hsncode: json["hsncode"],
        priority: json["priority"],
        prate: json["prate"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        tax: json["tax"],
        images: json["images"],
      );
}
