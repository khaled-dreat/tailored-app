import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailored/app.dart';
import 'package:tailored/firebase_options.dart';
import 'package:tailored/local/cache_helper.dart';
import 'package:tailored/providers/provider_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await CacheHelper.init();

  await Firebase.initializeApp(
      name: DefaultFirebaseOptions.name,
      options: DefaultFirebaseOptions.options);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<Provider_control>(
        create: (_) => Provider_control('ar'),
      ),
    ],
    child: Phoenix(
      child: MyApp(
        prefs: prefs,
      ),
    ),
  ));
}
