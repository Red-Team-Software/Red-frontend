import 'dart:convert';

String extractErrorMessage(String errorString) {
  try {
    // Limpia todos los prefijos "Exception:" si existen
    while (errorString.startsWith('Exception:')) {
      errorString = errorString.replaceFirst('Exception: ', '');
    }

    // Convierte el string JSON en un mapa
    final Map<String, dynamic> errorData = jsonDecode(errorString);

    // Devuelve el valor del campo "message"
    return errorData['message'] ?? 'Unknown error message';
  } catch (e) {
    print("Error parsing message");
    print(e);
    return 'Error parsing message';
  }
}
