import 'package:flutter_bloc/flutter_bloc.dart';
import '/enums/states_enum.dart';
part 'loading_state.dart';
class LoadingCubit extends Cubit<LoadingState>{
  LoadingCubit() :super(LoadingState(current_state: Current_State.NO_ITEM));

  void perform() {
    print('perform is called');
    emit(LoadingState(current_state: Current_State.SEARCHING));
  }
  void noInternet() {
    print(2);
    emit(LoadingState(current_state: Current_State.NO_INTERNET));
  }
  void free() {
    emit(LoadingState(current_state: Current_State.IDLE));
  }
  void noItem() {
    emit(LoadingState(current_state: Current_State.NO_ITEM));
  }
}