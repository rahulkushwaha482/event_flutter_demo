class NoInternetException implements Exception {
  final String message;
  NoInternetException([this.message = "No internet connection"]);
  @override
  String toString() => message;
}

class LocationPermissionException implements Exception {
  final String message;
  LocationPermissionException(
      [this.message = "Location permission not granted or service disabled"]);
  @override
  String toString() => message;
}
