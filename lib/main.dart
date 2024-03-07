import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:winch/controllers/app_style/colors.dart';
import 'package:winch/controllers/localization/localization.dart';
import 'package:winch/controllers/providers/api/packages_provider.dart';
import 'package:winch/controllers/providers/api/privacy_policy_provider.dart';
import 'package:winch/controllers/providers/api/terms_and_conditions_provider.dart';
import 'package:winch/controllers/providers/api/winch_requests_provider.dart';
import 'package:winch/controllers/providers/widgets/land_page_provider.dart';
import 'package:winch/pages/forget_passward_step1.dart';
import 'package:winch/pages/forget_password_step2.dart';
import 'package:winch/pages/login.dart';
import 'package:winch/pages/register.dart';
import 'package:winch/pages/requests/future_winch_request_details.dart';
import 'package:winch/pages/splash_page.dart';
import 'package:winch/pages/subscription/make_subscription.dart';
import 'package:winch/pages/user/land_page.dart';
import 'package:winch/pages/user/profile.dart';
import 'package:winch/pages/vehicles/add_vehicle.dart';
import 'package:winch/pages/vehicles/future_user_vehicle_details.dart';
import 'package:winch/pages/verify_phone_number.dart';
import 'package:winch/widgets/brands/brand_picker.dart';
import 'package:winch/widgets/categories/category_picker.dart';
import 'controllers/providers/api/about_provider.dart';
import 'controllers/providers/api/brand_vehicles_provider.dart';
import 'controllers/providers/api/categories_provider.dart';
import 'controllers/providers/api/user_provider.dart';
import 'controllers/providers/api/user_vehicles_provider.dart';
import 'controllers/providers/settings/setting_provider.dart';
import 'models/subscription.dart';
import 'pages/user/wynch_intro_page.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (_) => SettingProvider(),
        child: MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _settingProvider = Provider.of<SettingProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => LandPageProvider()),
        ChangeNotifierProvider(create: (_) => CategoriesProvider()),
        ChangeNotifierProvider(create: (_) => BrandVehiclesProvider()),
        ChangeNotifierProvider(create: (_) => UserVehiclesProvider()),
        ChangeNotifierProvider(create: (_) => PackagesProvider()),
        ChangeNotifierProvider(create: (_) => AboutProvider()),
        ChangeNotifierProvider(create: (_) => WinchRequestsProvider()),
        ChangeNotifierProvider(create: (_) => PrivacyPolicyProvider()),
        ChangeNotifierProvider(create: (_) => TermsAndConditionsProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WYNCH',
          theme: ThemeData(
            scaffoldBackgroundColor: AColors.white,
            primarySwatch: Colors.amber,
            accentColor: AColors.yellow,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),

          localizationsDelegates: [
            // ... app-specific localization delegate[s] here
            WinchLocalization.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en'),
            const Locale('ar'),
          ],
          locale: Locale(_settingProvider.language ?? 'en'),

          initialRoute: SplashPage.id,
          routes: {
            SplashPage.id : (_)=> SplashPage(),
            Login.id : (_)=> Login(),
            Register.id : (_)=> Register(),
            Profile.id : (_)=> Profile(),
            VerifyPhoneNumber.id : (_)=> VerifyPhoneNumber(),
            ForgetPasswordStep1.id : (_)=> ForgetPasswordStep1(),
            ForgetPasswordStep2.id : (_)=> ForgetPasswordStep2(),
            LandPage.id : (_)=> LandPage(),
            AddVehicle.id: (_)=> AddVehicle(),
            CategoryPicker.id: (_)=> CategoryPicker(),
            BrandPicker.id: (_)=> BrandPicker(),
            MakeSubscription.id: (_)=> MakeSubscription(subscription: Subscription(),),
            FutureUserVehicleDetails.id:(_)=> FutureUserVehicleDetails(),
            FutureWinchRequestDetails.id:(_)=> FutureWinchRequestDetails(),
            WynchIntroPage.id:(_)=> WynchIntroPage(),
          },
        ),
      ),
    );
  }
}


