import 'package:barkibu/cubit/cubit.dart';
import 'package:barkibu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Logout {
  static void resetCubits(BuildContext context) {
    BlocProvider.of<LoginCubit>(context).reset();
    BlocProvider.of<OwnerOwnQuestionCubit>(context).reset();
    BlocProvider.of<PasswordManagementCubit>(context).reset();
    BlocProvider.of<QuestionDetailCubit>(context).reset();
    BlocProvider.of<QuestionFilterCubit>(context).reset();
    BlocProvider.of<RegisterPetCubit>(context).reset();
    BlocProvider.of<RegisterUserCubit>(context).reset();
    BlocProvider.of<UserVeterinarianCubit>(context).reset();
    BlocProvider.of<VeterinarianInfoCubit>(context).reset();
    BlocProvider.of<VeterinarianOwnAnswerCubit>(context).reset();
    BlocProvider.of<VeterinaryCubit>(context).reset();
    BlocProvider.of<PetInfoCubit>(context).reset();
  }

  static void logout(BuildContext context) {
    resetCubits(context);
    TokenSecureStorage.deleteTokens();
    SkipAnimation.pushAndRemoveUntil(context, '/login_screen');
  }
}
