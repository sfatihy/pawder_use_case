import 'package:pawder_use_case/userModel.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeCompleted extends HomeState {
  const HomeCompleted();
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
}