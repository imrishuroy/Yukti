import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/blocs/profile/profile_bloc.dart';
import '/screens/profile/widgets/profile_screen.dart';
import '/widgets/app_drawer.dart';
import '/widgets/display_image.dart';
import 'widgets/dash_board_cards.dart';
import 'widgets/todays_lectures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.status) {
          case ProfileStatus.error:
            return const Scaffold();

          case ProfileStatus.succuss:
            return Scaffold(
              drawer: AppDrawer(photoUrl: state.user?.photUrl),
              backgroundColor: Colors.black45,
              appBar: AppBar(
                leading: Builder(builder: (context) {
                  return IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.alignLeft,
                      size: 27.0,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                }),
                elevation: 0.0,
                backgroundColor: Colors.black45,
                centerTitle: true,
                title: const Text(
                  'DashBoard',
                  style: TextStyle(
                    letterSpacing: 1.2,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(ProfileScreen.routeName);
                    },
                    child: CircleAvatar(
                      radius: 22.3,
                      backgroundColor: Colors.deepOrange,
                      child: CircleAvatar(
                        radius: 19.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: DisplayImage(imageUrl: state.user?.photUrl),
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 17.0),
                ],
              ),
              body: Column(
                children: [
                  const DashBoardCards(),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Text(
                      'Today\'s Lectures',
                      style: TextStyle(
                        fontSize: 19.9,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: Color(0xff51DACF),
                      ),
                    ),
                  ),
                  TodaysLectures(
                    user: state.user,
                  ),
                  const SizedBox(height: 17.0)
                ],
              ),
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}

// 479
