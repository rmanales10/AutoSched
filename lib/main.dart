import 'package:autosched/screens/auth_screens/forgot_password.dart';
import 'package:autosched/screens/auth_screens/login/login.dart';
import 'package:autosched/screens/auth_screens/register/register.dart';
import 'package:autosched/screens/curriculum_screen/addsub.dart';
import 'package:autosched/screens/curriculum_screen/create_curriculum/create_curriculum.dart';
import 'package:autosched/screens/curriculum_screen/curriculum_list/curriculum_list.dart';
import 'package:autosched/screens/curriculum_screen/curriculum_load.dart';
import 'package:autosched/screens/home_screen/home.dart';
import 'package:autosched/screens/profile_screen/edit_profile/edit_profile.dart';
import 'package:autosched/screens/profile_screen/profile/profile.dart';
import 'package:autosched/screens/schedule_screen/generated_schedule.dart';
import 'package:autosched/screens/setup_manager_screen/campus/add_campus/add_campus.dart';
import 'package:autosched/screens/setup_manager_screen/campus/campust_list/campus_list.dart';
import 'package:autosched/screens/setup_manager_screen/designation/add_designation/add_designation.dart';
import 'package:autosched/screens/setup_manager_screen/designation/designation_list/designation_list.dart';
import 'package:autosched/screens/setup_manager_screen/designation/viewdesignation.dart';
import 'package:autosched/screens/setup_manager_screen/faculty/add_faculty/addfaculty.dart';
import 'package:autosched/screens/setup_manager_screen/faculty/viewfaculty.dart';
import 'package:autosched/screens/setup_manager_screen/rooms/add_rooms/addroom.dart';
import 'package:autosched/screens/setup_manager_screen/faculty/faculty_screen/faculty.dart';
import 'package:autosched/screens/setup_manager_screen/rooms/edit_room/edit_room.dart';
import 'package:autosched/screens/setup_manager_screen/rooms/room/room_list.dart';
import 'package:autosched/screens/setup_manager_screen/rooms/viewroom.dart';
import 'package:autosched/screens/setup_manager_screen/subject/add_subject/add_subject.dart';
import 'package:autosched/screens/setup_manager_screen/subject/subject_list/subjects_list.dart';
import 'package:autosched/screens/setup_manager_screen/subject/viewsubject.dart';
import 'package:autosched/screens/teaching_load_screen/assign_faculty_load/assign_faculty_load.dart';
import 'package:autosched/screens/teaching_load_screen/create_teaching/create_teaching_load.dart';
import 'package:autosched/screens/teaching_load_screen/generate_load.dart';
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
        '/view-faculty': (context) => ViewFacultyScreen(),
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
        '/setup-manager/campus':
            (context) => CampusListScreen(
              selectedItem: 'Campus',
              onItemSelected: (String title, String route) {
                Navigator.pushNamed(context, route);
              },
            ),
        '/setup-manager/designation':
            (context) => DesignationListScreen(
              selectedItem: 'Designation',
              onItemSelected: (String title, String route) {
                Navigator.pushNamed(context, route);
              },
            ),
        '/setup-manager/subjects':
            (context) => SubjectsListScreen(
              selectedItem: 'Subjects',
              onItemSelected: (String title, String route) {
                Navigator.pushNamed(context, route);
              },
            ),
        '/generated_schedules': (context) => const GeneratedScheduleScreen(),
        '/generate-load': (context) => const GenerateLoadScreen(),
        '/addfaculty': (context) => const AddFacultyScreen(),
        '/addroom': (context) => const AddRoomsScreen(),
        '/view-teaching-load': (context) => const ViewTeachingLoadScreen(),
        '/create-curriculum': (context) => const CreateCurriculumScreen(),
        '/curriculum-load': (context) => const CurriculumLoadScreen(),
        '/addsubcur': (context) => const AddSubjectCurScreen(),
        '/addcampus': (context) => const AddCampusScreen(),
        // '/viewcampus': (context) => const ViewCampusScreen(),
        // '/editcampus': (context) => const EditCampusScreen(),
        '/adddesignation': (context) => const AddDesignationScreen(),
        '/viewdesignation': (context) => const ViewDesignationScreen(),
        // '/editdesignation': (context) => const EditDesignationScreen(),
        '/viewroom': (context) => const ViewRoomScreen(),
        // '/editroom': (context) => const EditRoomScreen(),
        '/addsubject': (context) => const AddSubjectScreen(),
        '/viewsubject': (context) => const ViewSubjectScreen(),
      },
    );
  }
}
