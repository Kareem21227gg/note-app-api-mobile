import 'package:dartz/dartz.dart';

import 'failure.dart';

abstract class UseCase<R, P> {
  Future<Either<Failure, R>> call(P p);
}
