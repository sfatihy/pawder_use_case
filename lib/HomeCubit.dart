import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pawder_use_case/HomeState.dart';
import 'package:pawder_use_case/userModel.dart';
import 'package:pawder_use_case/userService.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<UserModel> users = [];

  Future addFirstData() async {
    emit(HomeLoading());
    await addUser(5);
    emit(HomeCompleted());

  }

  Future addUser(int k) async {
    for(int i = 0; i < k; i++) {

      UserModel user = await UserService().getRandomUser();

      users.add(user);
    }
    emit(HomeCompleted());
  }

  removeUser(UserModel user) {

    users.remove(user);
    //emit(HomeCompleted());
  }

}