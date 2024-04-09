import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool flag = true;
  // Hardcoded username and password for validation
  final String _username = 'username';
  final String _password = 'password';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_usernameController.text == _username &&
          _passwordController.text == _password) {
        _showSuccessSnackbar();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red, // Change background color
            behavior: SnackBarBehavior.floating, // Set behavior to floating

            margin: EdgeInsets.only(
                top: 70, left: 20, right: 20, bottom: 20), // Adjust margin
            content: Text('Invalid SignUp Credentials',
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
        backgroundColor: Color.fromARGB(59, 76, 107, 175),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(top: 70, left: 20, right: 20, bottom: 20),
        content: Text('Signed Up Successfully',
            style: TextStyle(color: Colors.white)),
        duration: Duration(seconds: 2),
      ),
    );
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(25, 118, 210, 1)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Text(
                      "Create your account",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
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
                          hintText: "Enter Username",
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
                          hintText: 'Enter Password',
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
                        'SignUp',
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
                                builder: (context) => const SignUp()));
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [],
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
