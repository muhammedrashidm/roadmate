import 'package:dartz/dartz.dart';
import 'package:roadmate/app/home/domain/entities/category.dart';
import 'package:roadmate/app/products/domain/enities/product.dart';
import 'package:roadmate/app/products/domain/usecases/get_products.dart';
import 'package:roadmate/core/errors/failiure.dart';
import 'package:roadmate/core/utils/results.dart';

abstract class IHomeRepository{
  Future<ResultFuture<List<Category>>> getCategories();
}