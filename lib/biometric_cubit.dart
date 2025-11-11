import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
part 'biometric_state.dart';

class BiometricCubit extends Cubit<BiometricState> {
  BiometricCubit() : super(BiometricInitial());

  final LocalAuthentication auth = LocalAuthentication();

  Future<void> checkBiometricSupport() async {
    emit(BiometricLoading());
    try {
      bool canAuthenticate = await auth.canCheckBiometrics ||
          await auth.isDeviceSupported();

      if (!canAuthenticate) {
        emit(BiometricError("جهازك لا يدعم البصمة أو التعرف على الوجه"));
        return;
      }

      bool isAuthenticated = await auth.authenticate(
        localizedReason: 'من فضلك تحقق من الهوية للدخول للتطبيق',
      );

      if (isAuthenticated) {
        emit(BiometricSuccess());
      } else {
        emit(BiometricError("فشل التحقق من الهوية"));
      }
    } catch (e) {
      emit(BiometricError(e.toString()));
    }
  }
}
