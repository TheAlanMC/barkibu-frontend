import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'veterinary_state.dart';

class VeterinaryCubit extends Cubit<VeterinaryState> {
  VeterinaryCubit() : super(VeterinaryInitial());
}
