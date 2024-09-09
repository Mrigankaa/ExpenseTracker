import 'package:expencetracker/core/exception/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoPrams{
  
}