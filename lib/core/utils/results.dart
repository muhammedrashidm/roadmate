import 'package:dartz/dartz.dart';
import 'package:roadmate/core/errors/failiure.dart';

typedef ResultFuture<T> = Future<Either<Failure,T>>;
typedef VoidFuture = Either<Failure,void>;