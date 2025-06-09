import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/home/screens/start_screen.dart';
import 'package:tasky/features/profile/controller/profile_controller.dart';
import 'package:tasky/features/profile/screens/user_details_screen.dart';
import '../../../core/constants/storage_key.dart';
import '../../../core/utils/image_utils.dart';
import '../../../data/services/preference_manager.dart';
import '../../../widgets/custom_svg_picture.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileController(),
      child: Consumer<ProfileController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('My Profile',style: Theme.of(context).textTheme.displayMedium,),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundImage: controller.userImagePath == null
                                ? const AssetImage('assets/images/person.png')
                                : FileImage(File(controller.userImagePath!))
                                      as ImageProvider,
                            radius: 60,
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () =>
                                showImageSourceDialog(context, (XFile file) {
                                  controller.saveImage(file);
                                }),
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                              ),
                              child: const Icon(Icons.camera_alt, size: 26),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        controller.username,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      Text(
                        controller.motivationQuote,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                 Text('Profile Info',style: Theme.of(context).textTheme.displayMedium,),
                const SizedBox(height: 24),
                ListTile(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserDetailsScreen(
                          userName: controller.username,
                          motivationQuote: controller.motivationQuote,
                        ),
                      ),
                    );
                    if (result == true) {
                      controller.updateProfile(
                        PreferenceManager().getString(StorageKey.username) ??
                            '',
                        PreferenceManager().getString(
                              StorageKey.motivationQuote,
                            ) ??
                            '',
                      );
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  title: const Text('User Details'),
                  leading: const CustomSvgPicture(
                    path: 'assets/images/profile_icon.svg',
                  ),
                  trailing: const CustomSvgPicture(
                    path: 'assets/images/arrow_right.svg',
                  ),
                ),
                const Divider(thickness: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Dark Mode'),
                  leading: const CustomSvgPicture(
                    path: 'assets/images/dark_icon.svg',
                  ),
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.notifier,
                    builder: (context, value, _) => Switch(
                      value: value == ThemeMode.dark,
                      onChanged: (_) => ThemeController.toggleTheme(),
                    ),
                  ),
                ),
                const Divider(thickness: 1),
                ListTile(
                  onTap: () {
                    controller.logout(context, () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => StartScreen()),
                        (_) => false,
                      );
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Log Out'),
                  leading: const CustomSvgPicture(
                    path: 'assets/images/logout_icon.svg',
                  ),
                  trailing: const CustomSvgPicture(
                    path: 'assets/images/arrow_right.svg',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
