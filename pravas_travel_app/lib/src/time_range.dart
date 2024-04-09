import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:travel_app/src/add_guests.dart';
import 'package:travel_app/src/home_page.dart';
import 'package:travel_app/src/database.dart';
import 'package:travel_app/main.dart';

class Time extends StatefulWidget {
  const Time({super.key });

  @override
  State<Time> createState() => TimeState();
}

class TimeState extends State<Time> {
  TextEditingController locationController = TextEditingController();

   DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: const Icon(
                    Icons.cancel,
                    size: 26,
                  )),
              const SizedBox(
                height: 30,
              ),
              // TextField(
              //   controller: locationController,
              //   decoration: InputDecoration(
              //     hintText: 'Location',
              //     suffixIcon: const Icon(Icons.location_on),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(10),
              //       borderSide: const BorderSide(color: Colors.black),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //         color: Colors.deepPurpleAccent,
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       padding: const EdgeInsets.all(10),
              //       child: const Text(
              //         "Choose Date",
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 14,
              //             fontWeight: FontWeight.w400),
              //       ),
              //     ),
              //   ],
              // ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Center(
                    child: TableCalendar(
                      focusedDay: _selectedDay,
                      firstDay: DateTime(2020),
                      lastDay: DateTime(2026),
                      selectedDayPredicate: (day) =>
                          isSameDay(_selectedDay, day),
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          retriveDate = _selectedDay;
                          print(_selectedDay);
                        });
                      },
                    ),
                  )),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.deepPurpleAccent),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddGuestPage()));
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.deepPurpleAccent),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddGuestPage()));
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
