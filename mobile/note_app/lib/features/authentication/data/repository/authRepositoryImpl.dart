import 'package:note_app/core/success.dart';
import 'package:note_app/core/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:note_app/features/authentication/data/datasourse/auth_local_data_sourse.dart';
import 'package:note_app/features/authentication/data/datasourse/auth_remote_data_sourse.dart';
import 'package:note_app/features/authentication/data/model/singResult.dart';
import 'package:note_app/features/authentication/domain/repository/authRepository.dart';
import 'package:note_app/features/authentication/domain/usecase/singup.dart';
import 'package:note_app/features/authentication/domain/usecase/singin.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSourse remoteDataSourse;
  final AuthLocalDataSourse localDataSourse;
  AuthRepositoryImpl(
      {required this.localDataSourse, required this.remoteDataSourse});
  @override
  Future<Either<Failure, Success>> SingIn(SingInParam param) async {
    try {
      SingResult user = await remoteDataSourse.SingIn(param);
      await localDataSourse.SetUser(user);
      return Right(Success());
    } catch (e) {
      return Left(NetWorkFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Success>> SingUp(SingUpParam param) async {
    try {
      SingResult user = await remoteDataSourse.SingUp(param);
      await localDataSourse.SetUser(user);
      return Right(Success());
    } catch (e) {
      return Left(NetWorkFailure(e.toString()));
    }
  }
}
