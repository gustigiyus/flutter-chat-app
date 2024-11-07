// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_firebase/core/components/spaces.dart';
import 'package:flutter_chat_firebase/core/constants/colors.dart';

import 'package:flutter_chat_firebase/core/extensions/build_context_ext.dart';
import 'package:flutter_chat_firebase/presentations/pages/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  UserCredential? currentUser;

  HomePage({
    Key? key,
    this.currentUser,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.secondary,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SpaceHeight(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 44.0,
                        height: 44.0,
                        decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(22.0),
                        ),
                        child: const Icon(Icons.search, color: AppColors.white),
                      ),
                      const Text(
                        "Random Chat",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white),
                      ),
                      const CircleAvatar(
                        backgroundColor: AppColors.white,
                        radius: 22,
                        child: CircleAvatar(
                          radius: 21,
                          backgroundImage: NetworkImage(
                            'https://media.istockphoto.com/id/2158693457/id/foto/pasfoto-tampak-samping-potret-pebisnis-yang-percaya-diri.jpg?s=2048x2048&w=is&k=20&c=nci_shC5prENxjvAo0EgsLN5lQlgCiL5zOBZiGGYys4=',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SpaceHeight(32),
                  Expanded(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 8,
                      separatorBuilder: (BuildContext context, int index) {
                        return const SpaceWidth(16);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 0) {
                          return Column(
                            children: [
                              Container(
                                width: 58.0,
                                height: 58.0,
                                decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(29.0),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          );
                        }
                        return _itemProfile(10);
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _itemProfile(int profile) {
  return Column(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(29.0),
        child: Image.network(
          'https://media.istockphoto.com/id/2158693457/id/foto/pasfoto-tampak-samping-potret-pebisnis-yang-percaya-diri.jpg?s=2048x2048&w=is&k=20&c=nci_shC5prENxjvAo0EgsLN5lQlgCiL5zOBZiGGYys4=',
          width: 58.0,
          height: 58.0,
          fit: BoxFit.cover,
        ),
      ),
      const SpaceHeight(8),
      const Text(
        'userName',
        style: TextStyle(
          fontSize: 14.0,
          color: AppColors.white,
        ),
      ),
    ],
  );
}
