import 'package:roadmate/app/products/domain/usecases/get_products.dart';
import 'package:roadmate/app/products/domain/enities/product.dart';
import 'package:roadmate/core/utils/results.dart';

abstract class IProductRepository{
  Future<ResultFuture<List<Product>>> getProducts(GetProductsParams params);

}