import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailored/local/AppLocalizations.dart';
import 'package:tailored/modules/splash/screen/splash.dart';
import 'package:tailored/providers/auth_provider.dart';
import 'package:tailored/providers/chat_provider.dart';
import 'package:tailored/providers/home_provider.dart';
import 'package:tailored/providers/profile_provider.dart';
import 'package:tailored/shared/theme/theme_manager.dart';

class MyApp extends StatelessWidget {
   SharedPreferences prefs;

   MyApp({Key? key, required this.prefs}) : super(key: key);

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(


            create: (_) => AuthProvider(
                firebaseFirestore: firebaseFirestore,
                prefs: prefs,
                googleSignIn: GoogleSignIn(),
                firebaseAuth: FirebaseAuth.instance)),


        Provider<ProfileProvider>(
            create: (_) => ProfileProvider(
                prefs: prefs,
                firebaseFirestore: firebaseFirestore,
                firebaseStorage: firebaseStorage)),
        Provider<HomeProvider>(
            create: (_) => HomeProvider(firebaseFirestore: firebaseFirestore)),
        Provider<ChatProvider>(
            create: (_) => ChatProvider(
                prefs: prefs,
                firebaseStorage: firebaseStorage,
                firebaseFirestore: firebaseFirestore))
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        // onGenerateRoute: RouteGenerator.getRoute,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: const Locale("ar", ""),
        localeResolutionCallback: (devicelocale, supportedLocales) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // themeColor.setLocal(devicelocale.languageCode);
          });
          for (var locale in supportedLocales) {
            if (locale.languageCode == devicelocale?.languageCode) {
              return const Locale('ar', '');
            }
          }
          return supportedLocales.first;
        },
        supportedLocales: const [
          Locale("ar", ""),
          Locale("en", ""),
        ],
        //  initialRoute: Routes.splashRoute,
        theme: getApplicationTheme(),
        home: const SplashScreen(),
      ),
    );
  }
}
