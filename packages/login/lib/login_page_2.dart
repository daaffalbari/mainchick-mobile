import 'package:flutter/material.dart';
// import 'package:mainchick-mobile/styles/colors.dart';
// import 'package:mainchick-mobile/styles/text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 159,
              ),
              Image.asset('assets/logo login.png'),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Selamat Datang!',
                style: TextStyle(
                  fontSize: 24,
                  // fontWeight: medium,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 12,
              ),
              const Text(
                'Silakan masukkan username dan password\nyang telah terdaftar pada sistem',
                // style: kBodyMedium.copyWith(
                //   fontWeight: light,
                //   height: 1.5,
                // ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 53.89,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Username or Email',
                  focusColor: Colors.red,
                  prefixIcon: const Icon(Icons.people),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                obscureText: obscureText,
                decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
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
              const SizedBox(
                height: 8,
              ),
              const Text(
                'Lupa Password?',
                textAlign: TextAlign.right,
              ),
              const SizedBox(
                height: 24,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      // backgroundColor: kPrimaryColor,
                      ),
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
