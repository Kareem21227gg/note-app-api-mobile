import 'package:dartz/dartz.dart';
import 'package:note_app/core/failure.dart';
import 'package:note_app/core/success.dart';
import 'package:note_app/features/authentication/domain/usecase/singin.dart';
import 'package:note_app/features/authentication/domain/usecase/singup.dart';

abstract class AuthRepository {
  Future<Either<Failure, Success>> SingUp(SingUpParam user);
  Future<Either<Failure, Success>> SingIn(SingInParam user);
}
