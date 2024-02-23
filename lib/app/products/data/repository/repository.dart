import 'package:roadmate/app/products/data/data_source/products_data_source.dart';
import 'package:roadmate/app/products/domain/enities/product.dart';
import 'package:roadmate/app/products/domain/repos/repository.dart';
import 'package:roadmate/app/products/domain/usecases/get_products.dart';
import 'package:roadmate/core/utils/results.dart';

class ProductsRepository extends IProductRepository {
  final IProductsDataSource _dataSource;

  ProductsRepository(this._dataSource);
  @override
  Future<ResultFuture<List<Product>>> getProducts(
      GetProductsParams params) async {
    return _dataSource.getProducts(params);
  }
}
