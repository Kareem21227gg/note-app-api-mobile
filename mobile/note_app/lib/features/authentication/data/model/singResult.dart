import 'package:equatable/equatable.dart';

class SingResult extends Equatable {
  final String email;
  final String name;
  final String token;

  SingResult({required this.email, required this.name, required this.token});

  @override
  List<Object> get props => [email, name, token];

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'token': token,
    };
  }

  factory SingResult.fromJson(Map<String, dynamic> map) {
    return SingResult(
      email: map['email'],
      name: map['name'],
      token: map['token'],
    );
  }
}
