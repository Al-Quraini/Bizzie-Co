import 'package:bizzie_co/app_router.dart';
import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/connection/connections_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/notification/notification_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/request/request_bloc.dart';
import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bizzie_co/presentation/screens/authentication/set_location.dart';
import 'package:bizzie_co/presentation/screens/authentication/user_info.dart';
import 'package:bizzie_co/presentation/screens/splash/splash_page.dart';
import 'package:provider/provider.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final AppRouter _appRouter = AppRouter();

    // SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RequestBloc(),
        ),
        BlocProvider(
          create: (context) => ConnectionsBloc(),
        ),
        BlocProvider(
          create: (context) => ActivityBloc(),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(),
        ),
      ],
      child: MaterialApp(
          title: 'Bizzie Co',
          theme: ThemeData(
            colorScheme: ThemeData().colorScheme.copyWith(
                  primary: primary,
                ),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: _appRouter.genereateRoute,
          // home: const HomePage()
          initialRoute: SplashPage.id),
    );
  }
}
