import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/main.dart';
import 'package:travel_app/src/book_now.dart';
import 'package:travel_app/src/home_page.dart';

class AddGuestPage extends StatefulWidget {
  
  const AddGuestPage({super.key});

  @override
  State<AddGuestPage> createState() => _AddGuestPageState();
}

class _AddGuestPageState extends State<AddGuestPage> {
  // TextEditingController locController = TextEditingController();
  // TextEditingController dateController = TextEditingController();

  int adultCount = 0;
  int childrenCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      },
                      child: Icon(
                        Icons.cancel,
                        size: 26,
                      )),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              // TextField(
              //   controller: locController,
              //   decoration: InputDecoration(
              //     hintText: 'Location',
              //     suffixIcon: const Icon(Icons.location_on),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: const BorderSide(color: Colors.black),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // TextField(
              //   controller: dateController,
              //   decoration: InputDecoration(
              //     hintText: 'Dates',
              //     suffixIcon: const Icon(Icons.date_range),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: const BorderSide(color: Colors.black),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.all(13),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "How Many Guests",
                          style: GoogleFonts.lexend(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          "Adults",
                          style: GoogleFonts.manrope(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (adultCount > 0) {
                                adultCount--;
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            minimumSize: const Size(20, 30),
                          ),
                          child: const Icon(Icons.remove),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: Text(
                            "$adultCount",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              adultCount++;
                            });
                          },
                          child: const Icon(Icons.add),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            minimumSize: Size(20, 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Row(
                      children: [
                        Text(
                          "Children",
                          style: GoogleFonts.manrope(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (childrenCount > 0) {
                                childrenCount--;
                              }
                            });
                          },
                          child: const Icon(Icons.remove),
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            minimumSize: Size(20, 30),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: Text(
                            "$childrenCount",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              childrenCount++;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(20),
                            minimumSize: const Size(20, 20),
                          ),
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        adultCount = 0;
                        childrenCount = 0;
                        // locController.text = "";
                        // dateController.text = "";
                      });
                    },
                    child: Container(
                      child: Text(
                        "Clear all",
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff6D31ED),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(100, 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                80.0), // Change the border radius as needed
                          ),
                        ),
                        backgroundColor: const MaterialStatePropertyAll(
                          Color(0xff6D31ED),
                        ),
                      ),
                      onPressed: () {
                        retriveGuest = (adultCount + childrenCount);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookNowPage()));
                      },
                      child: Text(
                        "Next",
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
