import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_app/src/home_page.dart';
import 'package:travel_app/src/payment.dart';
import 'package:travel_app/src/database.dart';
import 'package:travel_app/main.dart';

class BookNowPage extends StatefulWidget {
  const BookNowPage({
    super.key,
  });

  @override
  State<BookNowPage> createState() => _BookNowPageState();
}

class _BookNowPageState extends State<BookNowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Confirm and pay",
          style: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Icon(
                Icons.home,
                size: 26,
              )),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 204, 203, 203)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "\$${dataList[retriveId].prize}",
                              style: GoogleFonts.manrope(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "/night",
                              style: GoogleFonts.manrope(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${dataList[retriveId].title}",
                          style: GoogleFonts.manrope(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.star,
                              size: 18,
                              color: Colors.amber,
                            ),
                            Text(
                              "${dataList[retriveId].stars}",
                              style: GoogleFonts.manrope(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image:  DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                "${dataList[retriveId].img}",
                              ))),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your trip",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Dates",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "$retriveDate",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Image.asset("assets/images/bookedit.png")
                    ],
                  ),
                  Text(
                    "Guests",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text(
                        "$retriveGuest guest",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Image.asset("assets/images/bookedit.png")
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Payment Options",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Pay in full",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Pay \$30 now to finalize your booking.",
                        style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                      const Spacer(),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        value: true,
                        onChanged: (val) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Pay a part now",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "You can make partial payment now and\nthe remaining amount at a later time.",
                        style: GoogleFonts.manrope(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                      const Spacer(),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                        value: true,
                        onChanged: (val) {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Price details",
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text(
                        "\$${dataList[retriveId].prize} x 1 night ",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "\$${dataList[retriveId].prize}",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Kayak fee",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "\$5",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Text(
                        "Street parking fee",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "\$5",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Text(
                        "Total (USD)",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "\$${(dataList[retriveId].prize!) + 10}",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(93, 73, 190, 1),
                        borderRadius: BorderRadius.circular(8)),
                    width: 370,
                    height: 52,
                    child: TextButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PaymentPage()));
                      },
                      child: Text(
                        "Book now",
                        style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
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
