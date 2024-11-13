import 'package:firebase_messaging/firebase_messaging.dart';

void configureFCM() async {
  // Obtener el token (opcional para pruebas)
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $fcmToken");

  // Suscribir al tema
  await FirebaseMessaging.instance.subscribeToTopic('productos');

  // Configurar el comportamiento cuando se recibe una notificación en primer plano
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('Mensaje recibido: ${message.notification!.title}');
      // Aquí se puede personalizar la notificación para mostrar en la app
    }
  });
}
