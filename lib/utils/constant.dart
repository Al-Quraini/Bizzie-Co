// ignore_for_file: constant_identifier_names

import 'package:bizzie_co/presentation/screens/authentication/components/filter_chip.dart';
import 'package:bizzie_co/presentation/screens/home/components/fab_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// images paths
const String placeholderPath = "assets/images/icon_logo.png";
const ImageProvider placeholer = AssetImage(
  placeholderPath,
);

// Collections
const String USERS = 'users';
const String INDUSTRIES = 'industries';
const String CARDS = 'cards';
const String ACTIVITIES = 'activities';
const String REQUESTS = 'requests';
const String INVITES = 'invites';
const String CONNECTIONS = 'connections';
const String LIKES = 'likes';
const String NOTIFICATIONS = 'notifications';
const String REPORTS = 'reports';
const String COMMENTS = 'comments';
const String EVENTS = 'events';
const String ATTENDEES = 'attendees';
const String TICKETS = 'tickets';

// colors
const Color primary = Color(0xFF6535CB);
const Color secondary = Color(0xFF6563FF);
const Color lightOrang = Color(0xFFFFB72A);
const Color orangs = Color(0xFFEE754A);
const Color iconColor = Color(0xEE653fCB);

const Color light = Color(0xFFEBEBEB);
const Color gold = Color(0xFFD4AF37);
const Color silver = Color(0xFFC0C0C0);
const Color bronze = Color(0xFFA97142);

const Color industryIndicator = Color(0xFFD5C4E6);

const Color dark = Color(0xFF484848);
const Color darkBlue = Color(0xFF252841);
const Color inactiveIndicator = Color(0xFFC4C4C4);
const Color activeIndicator = Color(0xFF2E1269);
const Color toggleBtnBackground = Color(0xFFEAEAEA);
const Color cardCornerBlue = Color(0xFF2185E1);
const Color googleButtonBackground = Color(0xFFeff7f7);
const Color linkedinButtonBackground = Color(0xFF0e76a8);
const Color twitterButtonBackground = Color(0xFF0e76a8);
const Color tvBackgroundColor = Color(0xfff0f0f0);
const Color appleButtonBackground = Color(0xFF00000d);

// gredients
const Gradient upperContainer = LinearGradient(colors: [
  Color(0xFF472294),
  Color(0xFF5D30BC),
]);

const Gradient authButtonGredient =
    LinearGradient(begin: Alignment(-1, 0), end: Alignment(0.5, 0), colors: [
  Color(0xFF2E1269),
  Color(0xFF6837D1),
]);

const Gradient primaryGredient =
    LinearGradient(begin: Alignment(-1, 0), end: Alignment(0.5, 0), colors: [
  Color(0xFF2E1269),
  Color(0xFF6837D1),
]);

// interests
const List<ItemType> categoriesList = [
  ItemType(
    category: 'Traveling ',
    icon: FontAwesomeIcons.suitcaseRolling,
  ),
  ItemType(
    category: 'Art ',
    icon: FontAwesomeIcons.palette,
  ),
  ItemType(
    category: 'UI/UX Design',
    icon: FontAwesomeIcons.mobile,
  ),
  ItemType(
    category: 'Communication',
    icon: FontAwesomeIcons.broadcastTower,
  ),
  ItemType(
    category: 'Gaming',
    icon: FontAwesomeIcons.gamepad,
  ),
  ItemType(
    category: 'Hiking ',
    icon: FontAwesomeIcons.hiking,
  ),
  ItemType(
    category: 'Graphic Design',
    icon: FontAwesomeIcons.draftingCompass,
  ),
  ItemType(category: 'Anthropology', icon: FontAwesomeIcons.binoculars),
  ItemType(
    category: 'Music ',
    icon: FontAwesomeIcons.music,
  ),
  ItemType(category: 'Business', icon: FontAwesomeIcons.businessTime),
  ItemType(
    category: 'History ',
    icon: FontAwesomeIcons.piedPiperHat,
  ),
  ItemType(
    category: 'Sports ',
    icon: FontAwesomeIcons.running,
  ),
  ItemType(
    category: 'Accounting ',
    icon: FontAwesomeIcons.calculator,
  ),
];

// bottom tabs
const List<FABBottomAppBarItem> bottomNavItems = [
  FABBottomAppBarItem(iconData: FontAwesomeIcons.rss, text: 'Feed'),
  FABBottomAppBarItem(
      iconData: Icons.notifications_none_outlined, text: 'Notifications'),
  FABBottomAppBarItem(iconData: FontAwesomeIcons.creditCard, text: 'Cards'),
  FABBottomAppBarItem(iconData: Icons.person_outline, text: 'Profile'),
];

// industry list
const List<String> industries = [
  'construction',
  'energy',
  'finance',
  'health',
  'hospitality',
  'information technology',
  'media',
  'AI real estate',
  'transportation'
];
