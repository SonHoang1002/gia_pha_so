import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gia_pha_so/src/domain/entity/user_entity.dart';
import 'package:gia_pha_so/src/presentation/provider/bloc/app_data_bloc.dart';
import 'package:gia_pha_so/src/presentation/provider/event/app_data_event.dart';
import 'package:gia_pha_so/src/presentation/provider/state/app_data_state.dart';
import 'package:gia_pha_so/src/presentation/provider/bloc/theme_bloc.dart';

class BlocUtil {
  static bool getIsDarkMode(BuildContext context, {bool listen = false}) =>
      getThemeBloc(context, listen: listen).isDarkMode;
  static AppDataState getAppData(BuildContext context, {bool listen = false}) =>
      getAppDataBloc(context, listen: listen).state;

  static AppDataBloc getAppDataBloc(
    BuildContext context, {
    bool listen = false,
  }) {
    return BlocProvider.of<AppDataBloc>(context, listen: listen);
  }

  static ThemeBloc getThemeBloc(BuildContext context, {bool listen = false}) {
    return BlocProvider.of<ThemeBloc>(context, listen: listen);
  }

  static void setThemeByMode(BuildContext context, ThemeMode mode) {
    return BlocProvider.of<ThemeBloc>(context).setThemeByMode(mode);
  }

  static void handleUpdateAppData(
    BuildContext context,
    UserEntity userEntity, {
    String token = "",
    String refreshToken = "",
  }) {
    return BlocProvider.of<AppDataBloc>(context).add(
      UpdateAppDataEvent(
        userEntity: userEntity,
        token: token,
        refreshToken: refreshToken,
      ),
    );
  }
}
