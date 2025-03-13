import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(InitialAppState()) {
    on<UpdateCountryEvent>((event, emit) {
      emit(CountryUpdatedState(event.selectedCountry));
    });
    on<PointUpdatedEvent>((event, emit) {
      emit(PointUpdatedState(event.point, event.zoom));
    });
  }
}

final appBloc = AppBloc();
