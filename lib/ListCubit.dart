import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawder_use_case/userModel.dart';
import 'package:pawder_use_case/userService.dart';

class ListCubit extends Cubit<List<UserModel>> {
  ListCubit() : super([]);

  Future addUser(int k) async {
    for(int i = 0; i < k; i++) {

      UserModel user = await UserService().getRandomUser();

      state.add(user);
    }

    emit(state);
  }

  void removeUser(UserModel user) {
    state.remove(user);
    emit(state);
  }

}