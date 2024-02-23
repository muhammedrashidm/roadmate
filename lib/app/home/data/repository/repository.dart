import 'package:roadmate/app/home/data/data_sources/home_data_source.dart';
import 'package:roadmate/app/home/domain/entities/category.dart';
import 'package:roadmate/app/products/domain/enities/product.dart';
import 'package:roadmate/app/home/domain/repos/repository.dart';
import 'package:roadmate/app/products/domain/usecases/get_products.dart';
import 'package:roadmate/core/data/dio.dart';
import 'package:roadmate/core/utils/results.dart';

class HomeRepository extends IHomeRepository {
  final IHomeDataSource _dataSource;

  HomeRepository(this._dataSource);

  @override
  Future<ResultFuture<List<Category>>> getCategories() async {
    return _dataSource.getCategories();
  }

}
