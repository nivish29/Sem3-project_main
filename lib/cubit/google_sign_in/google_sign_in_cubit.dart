import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  GoogleSignInCubit() : super(GoogleSignInInitial());
}
