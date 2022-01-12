import 'package:bizzie_co/presentation/screens/authentication/components/industries_page.dart';
import 'package:bizzie_co/presentation/screens/authentication/initial_screen.dart';

import 'package:bizzie_co/presentation/screens/authentication/login_page.dart';
import 'package:bizzie_co/presentation/screens/authentication/set_location.dart';
import 'package:bizzie_co/presentation/screens/authentication/signup_page.dart';
import 'package:bizzie_co/presentation/screens/authentication/user_info.dart';
import 'package:bizzie_co/presentation/screens/authentication/verify_email.dart';
import 'package:bizzie_co/presentation/screens/home/home_page.dart';
import 'package:bizzie_co/presentation/screens/home/qr_code_scanner.dart';
import 'package:bizzie_co/presentation/screens/profile/card/card_detail_page.dart';
import 'package:bizzie_co/presentation/screens/splash/splash_page.dart';
import 'package:bizzie_co/utils/enums.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'data/service/google_sign_in_provider.dart';

class AppRouter {
  Route? genereateRoute(RouteSettings settings) {
    switch (settings.name) {
      case InitialPage.id:
        return MaterialPageRoute(builder: (_) => const InitialPage());

      case LoginPage.id:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => GoogleSignInProvider(),
                child: const LoginPage()));

      case SignUpPage.id:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => GoogleSignInProvider(),
                child: const SignUpPage()));

      case VerifyEmail.id:
        return MaterialPageRoute(builder: (_) => const VerifyEmail());

      case SetLocation.id:
        return MaterialPageRoute(builder: (_) => const SetLocation());

      case UserInfoPage.id:
        return MaterialPageRoute(builder: (_) => const UserInfoPage());
      case IndustriesPage.id:
        return MaterialPageRoute(builder: (_) => const IndustriesPage());

      case HomePage.id:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case SplashPage.id:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      // case AddNewCardPage.id:
      //   return MaterialPageRoute(builder: (_) => const AddNewCardPage());

      case CardDetailPage.id:
        return MaterialPageRoute(
            builder: (_) => const CardDetailPage(
                  isInitialCard: true,
                ));

      case QRCodeScanner.id:
        return MaterialPageRoute(builder: (_) => const QRCodeScanner());

      // case ProfilePage.id:
      //   final argument = settings.arguments as Map;
      //   final user = argument['user'] as User;
      //   final card = argument['card'] as UserCard;
      //   return MaterialPageRoute(
      //       builder: (_) => ProfilePage(user: user, card: card));
/* 
      case ActivityDetailPage.id:
        final argument = settings.arguments as Map;
        final user = argument['user'] as User;
        final card = argument['activity'] as Activity;
        return MaterialPageRoute(
            builder: (_) => ActivityDetailPage(user: user, activity: card)); */

      default:
    }
  }
}
