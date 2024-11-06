// file : finplan_exception.dart

class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() {
    return 'FinPlanException: $message';
  }
}