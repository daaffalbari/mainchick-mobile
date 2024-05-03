import 'package:core/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/styles/colors.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height / 6),
                  Image.asset('assets/images/login_logo.png', width: 283),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome!',
                    style: kHeading4.copyWith(
                      fontFamily: medium,
                      color: const Color(0xFF5C6370),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text(
                    'Please enter your username and password\nthat you have registered with the system.',
                    style: TextStyle(
                      fontFamily: light,
                      color: Color(0xFF5C6370),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 54,
                  ),
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email cannot be empty';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Email',
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFD1D1D6),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kSecondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: red,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: red,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: const Icon(Icons.person_outlined)),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }

                      return null;
                    },
                    obscureText: obscureText,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(
                          color: Color(0xFFAAAAAA),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFD1D1D6),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: kSecondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: red,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: red,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(obscureText
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                  ),
                  // const SizedBox(height: 8),
                  // const Align(
                  //   alignment: Alignment.topRight,
                  //   child: Text(
                  //     'Forgot Password?',
                  //     textAlign: TextAlign.right,
                  //     style: TextStyle(
                  //       fontSize: 16,
                  //       color: kSecondaryColor,
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (emailController.text ==
                                  'cimerangfarm@gmail.com' &&
                              passwordController.text == 'cimerang2016') {
                            Navigator.pushReplacementNamed(
                                context, HomePage.routeName);
                          }
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: medium,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, HomePage.routeName);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFE0E0E0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: Color(0xFFE0E0E0),
                        ),
                      ),
                      child: Text(
                        'Account Demo',
                        style: TextStyle(
                          color: kGreyScaleColor[500],
                          fontFamily: medium,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
