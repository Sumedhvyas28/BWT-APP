import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/navigation/app_navigation.dart';
import 'package:flutter_application_1/view_model/auth_view_model.dart';
import 'package:flutter_application_1/view_model/feature_view.dart';
import 'package:flutter_application_1/view_model/location_post.dart';
import 'package:flutter_application_1/view_model/user_session.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load user data and initialize global data
  await UserSession().loadUserDataIntoGlobal();

  // Check if the user is logged in and start location updates if logged in
  if (GlobalData().token.isNotEmpty) {
    final featureView = FeatureView();
    LocationViewModel().startLocationUpdates(featureView);
  }

  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const App(),
  ));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserSession()),
        ChangeNotifierProvider(create: (_) => FeatureView()),
        ChangeNotifierProvider(create: (_) => LocationViewModel()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppNavigation.router,
      ),
    );
  }
}
