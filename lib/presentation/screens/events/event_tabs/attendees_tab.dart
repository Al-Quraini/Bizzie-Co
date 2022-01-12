import 'package:bizzie_co/business_logic/cubit/attendees/attendees_cubit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendeesTab extends StatelessWidget {
  const AttendeesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TODO : Work on connections attendees
        /*  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text('Connections',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              for (int i = 0; i < 5; i++)
                Expanded(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 30,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('Name',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                )
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ), */
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text('Attendees',
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ),
        BlocBuilder<AttendeesCubit, AttendeesState>(
          builder: (context, state) {
            if (state is AttendeesLoaded) {
              final attendees = state.attendees;
              return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: width / 5,
                      childAspectRatio: 1,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 20),
                  itemCount: attendees.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 30,
                            backgroundImage:
                                NetworkImage(attendees[index].userImage!),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: Text(attendees[index].firstName,
                              style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300)),
                        ),
                      ],
                    );
                  });
            } else if (state is AttendeesLoading) {
              return const CircularProgressIndicator.adaptive();
            }
            return const SizedBox();
          },
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
