import 'package:bizzie_co/app_router.dart';
import 'package:bizzie_co/business_logic/bloc/Event/events_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/activity/activity_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/connection/connections_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/leaderboard/leaderboard_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/notification/notification_bloc.dart';
import 'package:bizzie_co/business_logic/bloc/request/request_bloc.dart';
import 'package:bizzie_co/business_logic/cubit/attendees/attendees_cubit.dart';
import 'package:bizzie_co/business_logic/cubit/comments/comments_cubit.dart';
import 'package:bizzie_co/business_logic/cubit/user/user_cubit.dart';
import 'package:bizzie_co/data/repository/firestore_repository.dart';
import 'package:bizzie_co/presentation/screens/authentication/initial_screen.dart';
import 'package:bizzie_co/presentation/screens/splash/splash_page.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic/bloc/my_activity/my_activity_bloc.dart';

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
            create: (context) => LeaderboardBloc(),
          ),
          BlocProvider(
            create: (context) => ActivityBloc(),
          ),
          BlocProvider(
            create: (context) => MyActivityBloc(),
          ),
          BlocProvider(
            create: (context) => NotificationBloc(),
          ),
          BlocProvider(
            create: (context) => EventBloc(),
          ),
          BlocProvider(
            create: (context) => UserCubit(),
          ),
          BlocProvider(
            create: (context) =>
                CommentsCubit(firestoreRepository: FirestoreRepository()),
          ),
          BlocProvider(
            create: (context) =>
                AttendeesCubit(firestoreRepository: FirestoreRepository()),
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
          // home: const SplashPage()
          initialRoute: SplashPage.id,
        ));
  }
}
