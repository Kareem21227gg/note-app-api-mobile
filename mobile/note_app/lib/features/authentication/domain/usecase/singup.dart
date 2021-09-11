import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:note_app/core/failure.dart';
import 'package:note_app/core/success.dart';
import 'package:note_app/core/usecaseAbstarct.dart';
import 'package:note_app/features/authentication/domain/repository/authRepository.dart';

class SingUpUsecase implements UseCase<Success, SingUpParam> {
  final AuthRepository authRepository;

  SingUpUsecase({required this.authRepository});
  @override
  Future<Either<Failure, Success>> call(SingUpParam user) {
    return authRepository.SingUp(user);
  }
}

class SingUpParam extends Equatable {
  final String email;
  final String password;
  final String name;

  SingUpParam(
      {required this.email, required this.password, required this.name});

  @override
  List<Object> get props => [email, password, name];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
    };
  }
}
