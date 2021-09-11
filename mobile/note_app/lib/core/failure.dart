import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String msg;
  Failure(this.msg);
  @override
  List<Object> get props => [msg];
}

class NetWorkFailure extends Failure {
  NetWorkFailure(String msg) : super(msg);
}
