import 'package:bizzie_co/data/models/user.dart';
import 'package:bizzie_co/data/models/user_card.dart';
import 'package:bizzie_co/presentation/screens/authentication/initial_screen.dart';
import 'package:bizzie_co/presentation/screens/authentication/interests_page.dart';
import 'package:bizzie_co/presentation/screens/authentication/login_page.dart';
import 'package:bizzie_co/presentation/screens/authentication/set_location.dart';
import 'package:bizzie_co/presentation/screens/authentication/signup_page.dart';
import 'package:bizzie_co/presentation/screens/authentication/user_info.dart';
import 'package:bizzie_co/presentation/screens/authentication/verify_email.dart';
import 'package:bizzie_co/presentation/screens/home/profile_page.dart';
import 'package:bizzie_co/presentation/screens/home/qr_code_scanner.dart';
import 'package:bizzie_co/presentation/screens/home/home_page.dart';
import 'package:bizzie_co/presentation/screens/profile/card/add_new_card_page.dart';
import 'package:bizzie_co/presentation/screens/profile/card/card_detail_page.dart';
import 'package:bizzie_co/presentation/screens/profile/profile_tab.dart';
import 'package:bizzie_co/presentation/screens/profile/setting_page.dart';

import 'package:provider/provider.dart';

import 'package:bizzie_co/presentation/screens/splash/splash_page.dart';
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

      case SplashPage.id:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case VerifyEmail.id:
        return MaterialPageRoute(builder: (_) => const VerifyEmail());

      case SetLocation.id:
        return MaterialPageRoute(builder: (_) => const SetLocation());

      case UserInfoPage.id:
        return MaterialPageRoute(builder: (_) => const UserInfoPage());

      case InterestsPage.id:
        return MaterialPageRoute(builder: (_) => const InterestsPage());

      case HomePage.id:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case SettingPage.id:
        return MaterialPageRoute(builder: (_) => const SettingPage());

      case AddNewCardPage.id:
        return MaterialPageRoute(builder: (_) => const AddNewCardPage());

      case CardDetailPage.id:
        final template = settings.arguments as CardTemplate;

        return MaterialPageRoute(
            builder: (_) => CardDetailPage(cardTemplate: template));

      case QRCodeScanner.id:
        return MaterialPageRoute(builder: (_) => const QRCodeScanner());

      case ProfilePage.id:
        final argument = settings.arguments as Map;
        final user = argument['user'] as User;
        final card = argument['card'] as UserCard;

        return MaterialPageRoute(
            builder: (_) => ProfilePage(user: user, card: card));

      default:
    }
  }
}
