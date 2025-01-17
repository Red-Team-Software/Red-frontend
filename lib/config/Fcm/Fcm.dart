import 'package:GoDeli/features/common/infrastructure/http_service.dart';
import 'package:GoDeli/features/notification/infracestructure/datasources/notification_datasource.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void configureFCM(IHttpService httpService) async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $fcmToken");

  print('Configurando FCM');

  if (fcmToken != null) {
    // Llamar al servicio para guardar el token en el backend
    final notificationDatasource = NotificationDatasource(httpService);
    await notificationDatasource.saveToken(fcmToken);
  }

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
