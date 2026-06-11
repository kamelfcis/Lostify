import 'package:cool_alert/cool_alert.dart';
import 'package:lostify/app/my_app.dart';

showCoolAlert({
  required String title,
  String? message,
  Function()? onTapDismiss,
  required CoolAlertType coolAlertType,
}) {
  CoolAlert.show(
    context: navigatorKey.currentState!.context,
    type: coolAlertType,
    text: message,
    title: title,
    onConfirmBtnTap: onTapDismiss,
  );
}
