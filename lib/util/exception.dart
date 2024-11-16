// file : finplan_exception.dart

class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() {
    return 'FinPlanException: $message';
  }
}