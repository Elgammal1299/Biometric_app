part of 'biometric_cubit.dart';

abstract class BiometricState {}

class BiometricInitial extends BiometricState {}

class BiometricLoading extends BiometricState {}

class BiometricSuccess extends BiometricState {}

class BiometricError extends BiometricState {
  final String message;
  BiometricError(this.message);
}
