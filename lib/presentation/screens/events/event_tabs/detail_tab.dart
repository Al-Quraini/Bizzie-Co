import 'package:bizzie_co/data/models/event.dart';
import 'package:bizzie_co/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailTab extends StatelessWidget {
  const DetailTab({
    Key? key,
    required this.event,
  }) : super(key: key);
  final Event event;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 5,
              ),
              Text('\$${event.price} per person',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              const SizedBox(
                height: 5,
              ),
              Text('This event is non-refundable',
                  style: GoogleFonts.poppins(
                      color: Colors.black54,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              const Divider(
                indent: 10,
                endIndent: 10,
                height: 30,
              ),
              Text('Max RSVP',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 5,
              ),
              Text(event.max.toString(),
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400)),
              const Divider(
                indent: 10,
                endIndent: 10,
                height: 30,
              ),
              Text('Targeted Industries',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 10,
              ),
              ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (contex, index) {
                    return Row(
                      children: [
                        const CircleAvatar(
                          radius: 5,
                          backgroundColor: primary,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(event.industries[index],
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w400)),
                      ],
                    );
                  },
                  separatorBuilder: (contex, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: event.industries.length),
              const Divider(
                indent: 10,
                endIndent: 10,
                height: 30,
              ),
              Text('Event Details',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 5,
              ),
              Text(event.details,
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w300)),
              const Divider(
                indent: 10,
                endIndent: 10,
                height: 30,
              ),
              Text('Location',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              // const SizedBox(
              //   height: 10,
              // ),
              // Image.asset('assets/images/maap.png'),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(event.venue,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400)),
        const SizedBox(
          height: 5,
        ),
        Text(event.address,
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 14,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w400)),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
              color: Colors.grey[400],
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(event.userImage!), fit: BoxFit.cover)),
        ),
        const SizedBox(
          height: 20,
        ),
        Text('${event.userFirstName} ${event.userLastName}',
            style: GoogleFonts.quicksand(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400)),
        const SizedBox(
          height: 10,
        ),
        Text('Host',
            style: GoogleFonts.quicksand(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400)),
        const SizedBox(
          height: 30,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(20),
        //   child: Text(
        //       'Lorem ipsum dolor sit amet consectetur adipiscing elit tempus, vivamus torquent non cursus cum lectus proin metus, risus nisi arcu lacinia neque iaculis lacus. Vulputate pharetra fusce mi eros cursus vitae accumsan, montes',
        //       textAlign: TextAlign.center,
        //       style: GoogleFonts.poppins(
        //           color: Colors.black,
        //           fontSize: 12,
        //           fontWeight: FontWeight.w300)),
        // ),
      ],
    );
  }
}
