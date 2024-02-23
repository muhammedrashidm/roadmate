import 'package:roadmate/app/products/domain/enities/product.dart';
import 'package:roadmate/app/home/domain/repos/repository.dart';
import 'package:roadmate/app/products/domain/repos/repository.dart';
import 'package:roadmate/core/usecase/base_usecase.dart';
import 'package:roadmate/core/utils/results.dart';

class GetProductsParams {
  final int index;
  final int limit;

  GetProductsParams({required this.index, required this.limit});
}

class GetProductsUseCase
    extends UseCaseWithParams<List<Product>, GetProductsParams> {
  final IProductRepository _repository;
  GetProductsUseCase(this._repository);
  @override
  ResultFuture<List<Product>> call(GetProductsParams params) async {
    return await _repository.getProducts(params);
  }
}
