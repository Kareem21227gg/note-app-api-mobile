import 'package:get_it/get_it.dart';

import 'features/authentication/presentation/bloc/auth_bloc.dart';

GetIt sl = GetIt.instance;
void init() {
  sl.registerSingleton<AuthBloc>(AuthBloc());
}
