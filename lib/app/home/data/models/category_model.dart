import 'dart:convert';

import 'package:roadmate/app/home/domain/entities/category.dart';

CategoryModelResponse CategoryModelResponseFromMap(String str) => CategoryModelResponse.fromMap(json.decode(str));


class CategoryModelResponse {
  bool? error;
  List<CategoryModel>? categorylist;
  String? message;

  CategoryModelResponse({
    this.error,
    this.categorylist,
    this.message,
  });

  factory CategoryModelResponse.fromMap(Map<String, dynamic> json) => CategoryModelResponse(
    error: json["error"],
    categorylist: json["categorylist"] == null ? [] : List<CategoryModel>.from(json["categorylist"]!.map((x) => CategoryModel.fromMap(x))),
    message: json["message"],
  );


}




class CategoryModel extends Category {
  const CategoryModel({
    required super.id,
    required super.categoryName,
    required super.catId,
    required super.image,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
  });

  factory CategoryModel.fromMap(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        categoryName: json["category_name"],
        catId: json["cat_id"],
        image: json["image"],
        createdAt: json["created_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? DateTime.now()
            : DateTime.parse(json["updated_at"]),
        status: json["status"],
      );
}
