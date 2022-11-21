import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_veterinarian_state.dart';

class UserVeterinarianCubit extends Cubit<UserVeterinarianState> {
  UserVeterinarianCubit() : super(UserVeterinarianInitial());
}
