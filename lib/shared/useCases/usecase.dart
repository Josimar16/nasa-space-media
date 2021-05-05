import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:clean_architecture/shared/errors/failures.dart';

abstract class UseCase<OutPut, Input> {
  Future<Either<Failure, OutPut>> call(Input params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
