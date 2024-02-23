import 'package:flutter/cupertino.dart';
import 'package:roadmate/app/home/data/repository/repository.dart';
import 'package:roadmate/app/home/domain/entities/category.dart';
import 'package:roadmate/app/products/domain/enities/product.dart';
import 'package:roadmate/app/home/domain/usecases/GetCategories.dart';
import 'package:roadmate/app/products/domain/usecases/get_products.dart';

class HomeViewModal extends ChangeNotifier {
  final HomeRepository _repository;
  HomeViewModal(this._repository);

  List<Category> categories = [];


  Future<void> getCategories() async {
    final GetCategoriesUseCase useCase = GetCategoriesUseCase(_repository);
    final res = await useCase();
    res.fold((l) {}, (r) {
      categories = r;
      notifyListeners();
    });
  }


}
