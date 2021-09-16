import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:note_app/features/authentication/data/repository/authRepositoryImpl.dart';
import 'package:note_app/features/note/data/repository/noteRepositoryImpl.dart';
import 'package:note_app/features/note/presentation/bloc/note_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/userAuthState.dart';
import 'features/authentication/data/datasourse/auth_local_data_sourse.dart';
import 'features/authentication/data/datasourse/auth_remote_data_sourse.dart';
import 'features/authentication/domain/repository/authRepository.dart';
import 'features/authentication/domain/usecase/singin.dart';
import 'features/authentication/domain/usecase/singup.dart';
import 'features/authentication/presentation/bloc/auth_bloc.dart';
import 'features/note/data/datasourse/noteRemoteDataSourse.dart';
import 'features/note/domain/repository/noteRepository.dart';
import 'features/note/domain/usecase/createNote.dart';
import 'features/note/domain/usecase/deleteNote.dart';
import 'features/note/domain/usecase/getAllNote.dart';

GetIt sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton<Client>(() => Client());
  var shared = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(
    () => shared,
  );
  sl.registerLazySingleton<UserAuthState>(
    () => UserAuthState(
      pref: sl<SharedPreferences>(),
    ),
  );

  ///[Authintication]
  ///

  sl.registerFactory<AuthBloc>(() => AuthBloc(
      singInUsecase: sl<SingInUsecase>(), singUpUsecase: sl<SingUpUsecase>()));
  sl.registerLazySingleton<SingInUsecase>(
      () => SingInUsecase(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton<SingUpUsecase>(
      () => SingUpUsecase(authRepository: sl<AuthRepository>()));
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDataSourse: sl<AuthLocalDataSourse>(),
      remoteDataSourse: sl<AuthRemoteDataSourse>(),
    ),
  );

  sl.registerLazySingleton<AuthLocalDataSourse>(
    () => AuthLocalDataSourse(
      pref: sl<SharedPreferences>(),
    ),
  );

  sl.registerLazySingleton<AuthRemoteDataSourse>(
    () => AuthRemoteDataSourse(
      client: sl<Client>(),
    ),
  );

  ///[Note]
  ///
  sl.registerFactory<NoteBloc>(
    () => NoteBloc(
      createNoteUsecase: sl<CreateNoteUsecase>(),
      deleteNoteUsecase: sl<DeleteNoteUsecase>(),
      getAllNoteUsecase: sl<GetAllNoteUsecase>(),
    ),
  );
  sl.registerLazySingleton<CreateNoteUsecase>(
    () => CreateNoteUsecase(
      noteRepository: sl<NoteRepository>(),
    ),
  );
  sl.registerLazySingleton<DeleteNoteUsecase>(
    () => DeleteNoteUsecase(
      noteRepository: sl<NoteRepository>(),
    ),
  );
  sl.registerLazySingleton<GetAllNoteUsecase>(
    () => GetAllNoteUsecase(
      noteRepository: sl<NoteRepository>(),
    ),
  );
  sl.registerLazySingleton<NoteRepository>(
    () => NoteRepositoryImpl(
      remoteDataSource: sl<NoteRemoteDataSource>(),
    ),
  );

  sl.registerLazySingleton<NoteRemoteDataSource>(() => NoteRemoteDataSource(
        auth: sl<UserAuthState>(),
        client: sl<Client>(),
      ));
}
