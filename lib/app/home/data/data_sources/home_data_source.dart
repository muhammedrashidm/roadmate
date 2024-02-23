import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:roadmate/app/home/data/models/category_model.dart';
import 'package:roadmate/app/products/data/models/product.dart';
import 'package:roadmate/app/home/domain/entities/category.dart';
import 'package:roadmate/app/products/domain/usecases/get_products.dart';
import 'package:roadmate/core/data/dio.dart';
import 'package:roadmate/core/errors/exceptions.dart';
import 'package:roadmate/core/errors/failiure.dart';
import 'package:roadmate/core/utils/results.dart';

abstract class IHomeDataSource {
  ResultFuture<List<CategoryModel>> getCategories();
  ResultFuture<List<ProductModal>> getProducts(GetProductsParams params);
}

class HomeDataSource extends IHomeDataSource {
  final Api _api;

  HomeDataSource(this._api);

  @override
  ResultFuture<List<CategoryModel>> getCategories() async {
    try {
      final response = await _api.get('/categorylist');
      if (response.statusCode == 200) {
        final data = CategoryModelResponseFromMap(response.data);

        return Right(data.categorylist ?? []);
      } else {
        return Left(ApiFailure(
            message: response.statusMessage ?? '',
            statusCode: response.statusCode ?? 0));
      }
    } on DioException catch (e) {
      return Left(ApiFailure(
          message: e.message ?? '', statusCode: e.response?.statusCode ?? 0));
    } catch (e) {
      return Left(ApiFailure(message: e.toString() ?? '', statusCode: 0));
    }
  }

  @override
  ResultFuture<List<ProductModal>> getProducts(GetProductsParams params) async {
    try {
      final response =
          await _api.post('/product', data: {"index": params.index});
      if (response.statusCode == 200) {
        final data = productsResponseFromMap(response.data);

        return Right(data.product ?? []);
      } else {
        return Left(ApiFailure(
            message: response.statusMessage ?? '',
            statusCode: response.statusCode ?? 0));
      }
    } on DioException catch (e) {
      return Left(ApiFailure(
          message: e.message ?? '', statusCode: e.response?.statusCode ?? 0));
    } catch (e) {
      return Left(ApiFailure(message: e.toString() ?? '', statusCode: 0));
    }
  }
}
