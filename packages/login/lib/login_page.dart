import 'package:flutter/material.dart';

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
              const SizedBox(height: 159),
              Image.asset('assets/login_logo.png'),
              const SizedBox(height: 24),
              Text(
                'Selamat Datang!',
                style: TextStyle(
                  fontSize: 24,
                  // fontWeight: medium,
                  color: const Color(0xFF5C6370),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Silakan masukkan username dan password\nyang telah terdaftar pada sistem',
                // style: kBodyMedium.copyWith(
                //   fontWeight: light,
                //   height: 1.5,
                //   color: const Color(0xFF5C6370),
                // ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 53.89,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Username or Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFD1D1D6),
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        // color: kSecondaryColor,
                        ),
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
                          // color: kSecondaryColor,
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
              const SizedBox(
                height: 8,
              ),
              Text(
                'Lupa Password?',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                  // fontWeight: regular,
                  // color: kSecondaryColor,
                ),
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
