import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:nationremit/provider/dashboard_provider.dart';
import 'package:nationremit/provider/login_provider.dart';
import 'package:nationremit/router/main_router.dart';
import 'package:nationremit/router/router.dart';
import 'package:flutter/material.dart';
import 'package:requests_inspector/requests_inspector.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'network/globalkey.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLogged= prefs.getBool('isLoggedIn') ?? false;

  final MyApp myApp = MyApp(
    initialRoute: isLogged ? RouterConstants.loginWithPinRoute : RouterConstants.loginRoute,
  );
  runApp( RequestsInspector(
    enabled: false,
    child: myApp
  ));
 // runApp(myApp);   //current stable
//  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({Key? key, required String this.initialRoute}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarBrightness: Brightness.dark,// Dark text for status bar
      statusBarIconBrightness: Brightness.dark,
    ));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => DashBoardProvider()),
      ],
      child: MaterialApp(
        title: 'Monswift',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: MainRouter.generateRoute,
        initialRoute: initialRoute,
       // initialRoute: RouterConstants.loginRoute,
      ),
    );
  }/*final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = (prefs.getBool('isLoggedIn') == null) ? false : prefs.getBool('isLoggedIn');*/

}
