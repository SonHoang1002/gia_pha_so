import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gia_pha_so/main.dart';
import 'package:gia_pha_so/src/presentation/provider/event/app_data_event.dart';
import 'package:gia_pha_so/src/presentation/provider/state/app_data_state.dart';

class AppDataBloc extends Bloc<AppDataEvent, AppDataState> {
  AppDataBloc() : super(InitAppDataState()) {
    on<UpdateAppDataEvent>((event, emit) {
      logger.d("UpdateAppDataEvent call: ${event.userEntity}");
      emit(UpdateAppDataState(userEntity: event.userEntity));
    });
  } 
}
