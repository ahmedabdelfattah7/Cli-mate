import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weathery/presentation/Manger/app_manger/cubit_state.dart';
import 'package:weathery/services/local/cache_helper/cache_helper.dart';


class ModeCubit extends Cubit<AppState> {
  ModeCubit() : super(AppInitialState());
  static ModeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppModeState());
    } else{
      isDark = !isDark;
      CacheHelper.writeData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppModeState());
      });
    }

  }
}