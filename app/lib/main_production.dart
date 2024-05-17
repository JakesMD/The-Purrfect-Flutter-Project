import 'package:flutter/widgets.dart';
import 'package:purrfect/app/app.dart';
import 'package:purrfect/bootstrap/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await bootstrap(() => PurrfectApp(flavor: PAppFlavor.production));
}
