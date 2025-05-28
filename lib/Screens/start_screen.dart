import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/Screens/home_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 52),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/logo.svg'),
                SizedBox(width: 16),
                Text('Tasky', style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            SizedBox(height: 108),

            Text(
              'Welcome To Tasky 👋🏻',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: 8),
            Text(
              'Your productivity journey starts here.',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(height: 24),
            SvgPicture.asset('assets/images/pana.svg', width: 215, height: 205),

            SizedBox(height: 28),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Full Name',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 56,
                    child: TextField(
                      style: Theme.of(context).textTheme.displaySmall,
                      cursorColor: Colors.white,

                      decoration: InputDecoration(
                        fillColor: Color(0xFF282828),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        hintText: 'e.g. Sarah Khalid',
                        hintStyle: Theme.of(context).textTheme.displaySmall
                            ?.copyWith(color: Color(0xFF6D6D6D)),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Text('Let’s Get Started'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
