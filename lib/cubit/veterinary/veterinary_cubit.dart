import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'veterinary_state.dart';

class VeterinaryCubit extends Cubit<VeterinaryState> {
  VeterinaryCubit() : super(VeterinaryInitial());
}
