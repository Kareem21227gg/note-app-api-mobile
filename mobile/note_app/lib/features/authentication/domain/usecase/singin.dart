import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/core/failure.dart';
import 'package:note_app/core/success.dart';
import 'package:note_app/core/usecaseAbstarct.dart';
import 'package:note_app/features/authentication/domain/repository/authRepository.dart';

class SingInUsecase implements UseCase<Success, SingInParam> {
  final AuthRepository authRepository;

  SingInUsecase({required this.authRepository});
  @override
  Future<Either<Failure, Success>> call(SingInParam user) {
    return authRepository.SingIn(user);
  }
}

class SingInParam extends Equatable {
  final String email;
  final String password;

  SingInParam({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
