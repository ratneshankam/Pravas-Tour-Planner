import 'package:flutter/material.dart';
import 'package:travel_app/src/database.dart';
// import 'package:travel_app/main.dart';
import 'package:travel_app/src/home_page.dart';
import 'package:travel_app/src/register.dart';
import 'package:travel_app/src/reviews.dart';
import 'requiredClasses.dart';
// import 'database.dart';
// import 'package:travel_app/src/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool flag = true;
  dynamic database;
  List<SingleChildModalUsersData> data = [];

  @override
  void initState() {
    super.initState();
    database = createMyDatabase();
    print("Database Initialized Sucessfully");
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      data = await fetchUserData();
      reviewList = await getreviewData();
      bool flag = false;

      for (int i = 0; i < data.length; i++) {
        if (data[i].username == _usernameController.text.trim() &&
            data[i].password == _passwordController.text) {
          flag = true;
          break;
        }
      }

      if (flag) {
        _showSuccessSnackbar();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 20),
            content: Text('Invalid Login Credentials',
                style: TextStyle(color: Colors.white)),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 20),
        content: Text('Logged in Successfully',
            style: TextStyle(color: Colors.white)),
        duration: Duration(seconds: 2),
      ),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      "https://img.freepik.com/free-vector/privacy-policy-concept-illustration_114360-7853.jpg",
                      width: 380,
                      height: 300,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Welcome!",
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(25, 118, 210, 1)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: "Username",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: flag,
                        obscuringCharacter: "•",
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.key),
                          hintText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  flag = !flag;
                                });
                              },
                              icon: const Icon(Icons.remove_red_eye_outlined)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      style: const ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(
                            Size(350, 45),
                          ),
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(25, 118, 210, 1))),
                      onPressed: _submitForm,
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register()));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "New Here?",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            " Click To Register",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(25, 118, 210, 1)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
