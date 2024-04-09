// import 'package:flutter/cupertino.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
// import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:travel_app/src/add_guests.dart';
import 'package:travel_app/src/book_now.dart';
import 'package:travel_app/src/payment.dart';
import 'package:travel_app/src/profile_page.dart';
import 'package:travel_app/src/reviews.dart';
import 'package:travel_app/src/time_range.dart';
import 'package:travel_app/src/database.dart';
import 'package:travel_app/main.dart';

class TODOModel {
  int? taskId;
  String? title;
  String? description;
  String? date;

  TODOModel({this.taskId, this.title, this.description, this.date});

  Map<String, dynamic> todoMap() {
    return {
      "taskId": taskId,
      "title": title,
      "description": description,
      "date": date
    };
  }

  @override
  String toString() {
    return """{taskId -> $taskId, title -> $title, description -> $description, date -> $date,}""";
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  ///Text Editing Controllers
  final TextEditingController searchController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // variables
  List<TODOModel> cardList = [
    // TODOModel(
    //     title: "Daily Tasks",
    //     description:
    //         "This list includes essential tasks that need to be completed each day, such as responding to emails, making phone calls, and tidying up the workspace.",
    //     date: "3/2/2022"),
    // TODOModel(
    //     title: "Grocery Shopping",
    //     description:
    //         "Keep track of the items you need to purchase from the grocery store, including fresh produce, pantry staples, and household essentials.",
    //     date: "3/2/2022"),
  ];

  double rangeStart = 1000;
  double rangeEnd = 10000;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;
  bool _isFacilityChecked1 = false;
  bool _isFacilityChecked2 = false;
  bool _isFacilityChecked3 = false;
  bool _isFacilityChecked4 = false;
  bool _isFacilityChecked5 = false;

  void clearControllers() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  void submit(bool doEdit, [TODOModel? obj]) {
    if (titleController.text.trim().isNotEmpty &&
        descriptionController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!doEdit) {
        setState(() {
          cardList.add(TODOModel(
              title: titleController.text.trim(),
              description: descriptionController.text.trim(),
              date: dateController.text.trim()));
        });
      } else {
        setState(() {
          obj!.title = titleController.text.trim();
          obj.description = descriptionController.text.trim();
          obj.date = dateController.text.trim();
        });
      }
    }
    clearControllers();
  }

  void editEntry(TODOModel obj) {
    titleController.text = obj.title!;
    descriptionController.text = obj.description!;
    dateController.text = obj.date!;
    showBottomSht(true, obj);
  }

  void deleteEntry(TODOModel obj) {
    setState(() {
      cardList.remove(obj);
    });
  }

  Future<void> showBottomSht(bool doEdit, [TODOModel? todoModelObj]) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    "Filters",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Price range",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SfRangeSliderTheme(
                          data: SfRangeSliderThemeData(
                            tooltipBackgroundColor: Colors.white,
                            tooltipTextStyle: const TextStyle(
                              color: Color(0xff6D31ED),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: SfRangeSlider(
                            dragMode: SliderDragMode.both,
                            tooltipTextFormatterCallback:
                                (actualValue, formattedText) {
                              return '${actualValue.toStringAsFixed(2)} ₹';
                            },
                            enableTooltip: true,
                            showLabels: true,
                            labelFormatterCallback:
                                (actualValue, formattedText) {
                              // return actualValue == 1000 ? 'Minimum\n\$ $actualValue +' : 'Maximum\n\$ $actualValue';
                              return actualValue == 1000
                                  ? 'Minimum\n$formattedText ₹'
                                  : 'Maximum\n$formattedText ₹';
                            },
                            min: 1000,
                            max: 10000,
                            activeColor: const Color(0xff6D31ED),
                            startThumbIcon: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: Color(0xff6D31ED),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            endThumbIcon: Container(
                              width: 28,
                              height: 28,
                              decoration: const BoxDecoration(
                                color: Color(0xff6D31ED),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            values: SfRangeValues(rangeStart, rangeEnd),
                            onChanged: (value) {
                              setState(() {
                                rangeStart = value.start;
                                rangeEnd = value.end;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Type of place",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Entire place",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Entire apartments, condos, houses",
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              const Spacer(),
                              Checkbox(
                                value: _isChecked1,
                                checkColor: Colors.white,
                                activeColor: const Color(0xff6D31ED),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked1 = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Private room",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Typically come with a private bathroom\n unless otherwise stated",
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const Spacer(),
                              Checkbox(
                                value: _isChecked2,
                                checkColor: Colors.white,
                                activeColor: const Color(0xff6D31ED),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked2 = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Dormitories",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Large rooms with multiple beds\n that are shared with others",
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.grey),
                              ),
                              const Spacer(),
                              Checkbox(
                                value: _isChecked3,
                                checkColor: Colors.white,
                                activeColor: const Color(0xff6D31ED),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isChecked3 = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Rooms and beds",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              fixedSize: const MaterialStatePropertyAll(
                                Size(350, 50),
                              ),
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(
                                  color: Colors
                                      .grey, // Change the border color here
                                  width: 1, // Change the border width here
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(5),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      0.0), // Change the border radius as needed
                                ),
                              ),
                            ),
                            child: Text(
                              "Bedrooms",
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              fixedSize: const MaterialStatePropertyAll(
                                Size(350, 50),
                              ),
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(
                                  color: Colors
                                      .grey, // Change the border color here
                                  width: 1, // Change the border width here
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(5),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      0.0), // Change the border radius as needed
                                ),
                              ),
                            ),
                            child: Text(
                              "Beds",
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              fixedSize: const MaterialStatePropertyAll(
                                Size(350, 50),
                              ),
                              side: MaterialStateProperty.all<BorderSide>(
                                const BorderSide(
                                  color: Colors
                                      .grey, // Change the border color here
                                  width: 1, // Change the border width here
                                ),
                              ),
                              elevation: MaterialStateProperty.all<double>(5),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      0.0), // Change the border radius as needed
                                ),
                              ),
                            ),
                            child: Text(
                              "Bathrooms",
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Facilities",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                "Kitchen",
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Checkbox(
                                value: _isFacilityChecked1,
                                checkColor: Colors.white,
                                activeColor: const Color(0xff6D31ED),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isFacilityChecked1 = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                "Pool",
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Checkbox(
                                value: _isFacilityChecked2,
                                checkColor: Colors.white,
                                activeColor: const Color(0xff6D31ED),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isFacilityChecked2 = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                "Gym",
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Checkbox(
                                value: _isFacilityChecked3,
                                checkColor: Colors.white,
                                activeColor: const Color(0xff6D31ED),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isFacilityChecked3 = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                "Outdoor space",
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Checkbox(
                                value: _isFacilityChecked4,
                                checkColor: Colors.white,
                                activeColor: const Color(0xff6D31ED),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isFacilityChecked4 = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Text(
                                "Internet access",
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Checkbox(
                                value: _isFacilityChecked5,
                                checkColor: Colors.white,
                                activeColor: const Color(0xff6D31ED),
                                onChanged: (bool? value) {
                                  setState(() {
                                    _isFacilityChecked5 = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: Text(
                      "Clear all",
                      style: GoogleFonts.manrope(
                        fontSize: 14,
                        color: const Color(0xff6D31ED),
                      ),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Change the border radius as needed
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        Color(0xff6D31ED),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        Navigator.of(context).pop();
                      });
                    },
                    child: Text(
                      "View Results",
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
            child: Column(
              children: [
                const SizedBox(
                  height: 56,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                  ),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () async {
                            await showBottomSht(false);
                          },
                          icon: const Icon(Icons.filter_alt_outlined)),
                      hintText: "Where do you want to stay?",
                      fillColor: Colors.white,
                      enabledBorder: InputBorder.none,
                      border: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 0, color: Colors.white),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 60,
                        width: 100,
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                                width: 4, color: Colors.deepPurpleAccent),
                          ),
                        ),
                        child: const Icon(
                          size: 30,
                          Icons.beach_access_rounded,
                          color: Colors.deepPurpleAccent,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                        width: 100,
                        child: Icon(
                          size: 30,
                          Icons.terrain,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                        width: 100,
                        child: Icon(
                          size: 30,
                          Icons.business,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: Colors.white),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      dataList = await getAppData();
                      retriveId = index;
                      print(retriveId);
                      print("Printing DATALIST --> $dataList   or   ${await getAppData()}");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Time()));
                    },
                    child: Column(
                      children: [
                        Container(
                          width: 350,
                          height: 323,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    dataList[index].img!),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          // child: Image.asset(
                          //     "assets/images/place${index + 1}.jpg")
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                dataList[index].title!,
                                style: GoogleFonts.manrope(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                "${dataList[index].stars!}",
                                style: GoogleFonts.manrope(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 25,
                              ),
                              Text(
                                dataList[index].description!,
                                style: GoogleFonts.manrope(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.currency_rupee,
                                color: Colors.black,
                                size: 18,
                              ),
                              Text(
                                "${dataList[index].prize!}/night",
                                style: GoogleFonts.manrope(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.blue.shade100,
        buttonBackgroundColor: Colors.blue.shade100,
        height: 50,
        animationDuration: const Duration(milliseconds: 300),
        index: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            if (index == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddGuestPage()));
            }
            if (index == 1) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const TODOAppUI()));
            }

            if (index == 3) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const BookNowPage()));
            }
            if (index == 4) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            }
          });
        },
        items: const <Widget>[
          Icon(Icons.search, color: Colors.black),
          Icon(Icons.favorite, color: Colors.black),
          Icon(Icons.widgets_outlined, color: Colors.black),
          Icon(Icons.shopping_bag, color: Colors.black),
          Icon(Icons.account_circle, color: Colors.black),
        ],
      ),
    );
  }
}
