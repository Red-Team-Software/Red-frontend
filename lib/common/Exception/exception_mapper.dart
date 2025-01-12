import 'dart:convert';

String extractErrorMessage(String errorString) {
  try {
    // Limpia el prefijo "Exception:" si existe
    if (errorString.startsWith('Exception:')) {
      errorString = errorString.replaceFirst('Exception: ', '');
    }

    // Convierte el string JSON en un mapa
    final Map<String, dynamic> errorData = jsonDecode(errorString);

    // Devuelve el valor del campo "message"
    return errorData['message'] ?? 'Unknown error message';
  } catch (e) {
    // Devuelve un mensaje por defecto en caso de fallo
    return 'Error parsing message';
  }
}
