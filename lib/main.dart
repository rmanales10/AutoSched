import 'package:autosched/screens/auth_screens/forgot_password.dart';
import 'package:autosched/screens/auth_screens/login/login.dart';
import 'package:autosched/screens/auth_screens/register/register.dart';
import 'package:autosched/screens/curriculum_screen/curriculum.dart';
import 'package:autosched/screens/home_screen/home.dart';
import 'package:autosched/screens/profile_screen/edit_profile/edit_profile.dart';
import 'package:autosched/screens/profile_screen/profile/profile.dart';
import 'package:autosched/screens/schedule_screen/generated_schedule.dart';
import 'package:autosched/screens/setup_manager_screen/add_faculty/addfaculty.dart';
import 'package:autosched/screens/setup_manager_screen/add_rooms/addroom.dart';
import 'package:autosched/screens/setup_manager_screen/faculty/faculty.dart';
import 'package:autosched/screens/setup_manager_screen/rooms/room.dart';
import 'package:autosched/screens/teaching_load_screen/assign_faculty_load/assign_faculty_load.dart';
import 'package:autosched/screens/teaching_load_screen/create_teaching/create_teaching_load.dart';
import 'package:autosched/screens/teaching_load_screen/teaching_load_list/teaching_load.dart';
import 'package:autosched/screens/teaching_load_screen/view_teaching_load.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AutoSched',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/forgot': (context) => ForgotPasswordScreen(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/edit': (context) => const EditProfileScreen(),
        '/curriculum': (context) => const CurriculumScreen(),
        '/teaching-load': (context) => const TeachingLoadScreen(),
        '/create_teaching-load': (context) => CreateTeachingLoadScreen(),
        '/assign-faculty-load': (context) => AssignFacultyLoadScreen(),
        '/setup-manager/faculty':
            (context) => FacultyScreen(
              selectedItem: 'Faculty',
              onItemSelected: (String title, String route) {
                Navigator.pushNamed(context, route);
              },
            ),
        '/setup-manager/rooms':
            (context) => RoomScreen(
              selectedItem: 'Room List',
              onItemSelected: (String title, String route) {
                Navigator.pushNamed(context, route);
              },
            ),
        '/addfaculty': (context) => const AddFacultyScreen(),
        '/addroom': (context) => const AddRoomsScreen(),
        '/generated_schedules': (context) => const GeneratedScheduleScreen(),
        '/view-teaching-load': (context) => const ViewTeachingLoadScreen(),
      },
    );
  }
}
