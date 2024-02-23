import 'package:equatable/equatable.dart';

class Category extends Equatable{
 final int id;
 final  String categoryName;
 final int catId;
 final String image;
 final DateTime createdAt;
 final DateTime updatedAt;
 final int status;

  const Category({
    required this.id,
    required this.categoryName,
    required  this.catId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  @override
  List<Object?> get props => [id];
}