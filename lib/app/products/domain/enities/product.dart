import 'package:equatable/equatable.dart';

class Product extends Equatable{
 final int id;
 final int brandId;
 final String productName;
 final int offerPrice;
 final int price;
 final String description;
 final int status;
 final int hsncode;
 final int priority;
 final String prate;
 final String createdAt;
 final String updatedAt;
 final int tax;
 final String images;

  const Product({
    required this.id,
    required this.brandId,
    required this.productName,
    required this.offerPrice,
    required this.price,
    required this.description,
    required this.status,
    required this.hsncode,
    required this.priority,
    required this.prate,
    required this.createdAt,
    required this.updatedAt,
    required this.tax,
    required this.images,
  });

  @override
  List<Object?> get props => [id];
}