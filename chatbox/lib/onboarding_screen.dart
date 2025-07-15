import 'package:flutter/material.dart';
import 'sign_in_screen.dart';
import 'package:flutter/services.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark, // 👈 makes status bar icons white
    );

    return Scaffold(
      backgroundColor: Color(0xFF43116A),
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 👈 Make it visible
        centerTitle: true,
        elevation: 0, // Optional: removes shadow
        iconTheme: const IconThemeData(
          color: Colors.black,
        ), // Optional: makes back icon visible
        title: Image.asset(
          'assets/images/Logo.png',
          fit: BoxFit.contain,
          height: 19.2,
          width: 77,
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF43116A), Color(0xFF0A1832), Color(0xFF0A1832)],
            stops: [0.0, 0.3, 1.0],
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // 🖼 Background image
            Positioned.fill(child: Image.asset('assets/images/background.png')),

            // 🔲 Overlay with text and UI
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Connect friends\neasily &\nquickly',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 68,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Our chat app is the perfect way to stay connected with friends and family.',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: const [
                        CircleAvatar(
                          child: Icon(Icons.facebook, color: Colors.white),
                          backgroundColor: Colors.blue,
                        ),
                        SizedBox(width: 16),
                        CircleAvatar(
                          child: Icon(Icons.g_mobiledata, color: Colors.white),
                          backgroundColor: Colors.red,
                        ),
                        SizedBox(width: 16),
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage(
                            'assets/images/Apple_on.png',
                          ), // Ensure you have an Apple logo image in your assets
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('Sign up with mail'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SignInScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Existing account? Log in',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}