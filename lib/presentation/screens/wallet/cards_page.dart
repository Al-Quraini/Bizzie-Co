import 'package:bizzie_co/business_logic/bloc/connection/connections_bloc.dart';
import 'package:bizzie_co/data/models/connection.dart';

import 'package:bizzie_co/presentation/screens/wallet/components/card_item_list.dart';

import 'package:bizzie_co/presentation/screens/wallet/components/filter_bottom_sheet.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: SafeArea(
                child: Row(
              children: [
                Text(
                  'Connections',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const Spacer(),

                // TODO : Later work on filters
                // InkWell(
                //     onTap: showBottomSheet,
                //     child: const Icon(FontAwesomeIcons.slidersH)),
              ],
            )),
          ),

          // TODO : Search Connections
          /*  Container(
            height: 50,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[400]!, width: 1)),
            margin: const EdgeInsets.symmetric(horizontal: 25),
            child: const TextField(
              decoration: InputDecoration(
                  hintText: 'search connections',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search)),
            ),
          ), */
          BlocBuilder<ConnectionsBloc, ConnectionsState>(
            builder: (context, state) {
              if (state is ConnectionLoaded) {
                List<Connection> connections = state.connections;

                if (connections.isNotEmpty) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 0),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: connections.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 8,
                          );
                        },
                        itemBuilder: (context, index) {
                          return CardItemList(
                            connection: connections[index],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  );
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: const Text('You don\'t have connections yet'),
                  );
                }
              } else {
                return Container(
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void showBottomSheet() {
    final rootNavigatorContext =
        Navigator.of(context, rootNavigator: true).context;

    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        context: rootNavigatorContext,
        isScrollControlled: true,
        builder: (context) => Container(
            // clipBehavior: Clip.antiAlias,
            height: MediaQuery.of(context).size.height * 0.65,
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const FilterBottomSheet()));
  }
}
