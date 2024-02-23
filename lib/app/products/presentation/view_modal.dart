import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:roadmate/app/products/domain/enities/product.dart';
import 'package:roadmate/app/products/domain/repos/repository.dart';
import 'package:roadmate/app/products/domain/usecases/get_products.dart';

class ProductsViewModal extends ChangeNotifier{
  final IProductRepository _repository;
  List<Product> _products = [];
  List<Product> products = [];

  ProductsViewModal(this._repository);
  Future<void> getHomeProducts() async {
    final GetProductsUseCase useCase = GetProductsUseCase(_repository);
    final res = await useCase(GetProductsParams(index: 1, limit: 6));
    res.fold((l) {

    }, (r) {
      _products = r;
      products = r;
      notifyListeners();
    });
  }


}