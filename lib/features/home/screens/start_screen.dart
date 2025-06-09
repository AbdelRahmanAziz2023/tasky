import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/features/home/screens/main_screen.dart';
import 'package:tasky/widgets/custom_text_form_field.dart';

import 'home_screen.dart';

class StartScreen extends StatefulWidget {
   StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final GlobalKey<FormState> _key = GlobalKey();

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 52),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/logo.svg'),
                    SizedBox(width: 16),
                    Text(
                      'Tasky',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
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
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                SvgPicture.asset(
                  'assets/images/pana.svg',
                  width: 215,
                  height: 205,
                ),

                SizedBox(height: 28),
                CustomTextFormField(
                  name: 'Full Name',
                  hintText: 'e.g. Sarah Khalid',
                  controller: controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter user name';
                    }
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async{
                    if (_key.currentState?.validate()??false){
                      SharedPreferences pref = await SharedPreferences.getInstance();
                      await pref.setString('username', controller.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    }
                  },
                  child: Text('Let’s Get Started'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
