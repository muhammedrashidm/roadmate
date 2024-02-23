import 'package:roadmate/app/home/domain/entities/category.dart';
import 'package:roadmate/app/home/domain/repos/repository.dart';
import 'package:roadmate/core/usecase/base_usecase.dart';
import 'package:roadmate/core/utils/results.dart';

class GetCategoriesUseCase extends UseCaseWithOutParams<List<Category>> {
  final IHomeRepository _repository;
  const GetCategoriesUseCase(this._repository);
  @override
  ResultFuture<List<Category>> call() async{
    return await _repository.getCategories();
  }
}
