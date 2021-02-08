import 'package:get_it/get_it.dart';
import 'package:todo_list/core/BLoCs/homeBloc.dart';

final sl = GetIt.instance;

void setupLocator() {
  sl.registerLazySingleton(() => HomeBloc());
}
