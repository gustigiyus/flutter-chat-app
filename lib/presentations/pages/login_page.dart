import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_firebase/core/components/buttons.dart';
import 'package:flutter_chat_firebase/core/components/custom_text_field.dart';
import 'package:flutter_chat_firebase/core/components/spaces.dart';
import 'package:flutter_chat_firebase/core/constants/colors.dart';
import 'package:flutter_chat_firebase/core/extensions/build_context_ext.dart';
import 'package:flutter_chat_firebase/data/datasources/firebase_datasource.dart';
import 'package:flutter_chat_firebase/data/models/user_model.dart';
import 'package:flutter_chat_firebase/presentations/pages/home_page.dart';
import 'package:flutter_chat_firebase/presentations/pages/register.page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool isObscure = true;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  void initState() {
    super.initState();
  }

  void doLogin() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      context.pushReplacement(HomePage(
          // currentUser: null,
          ));
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SpaceHeight(100),
          const Center(
            child: Text(
              "Flutter Firebase ChatApp",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          const SpaceHeight(16),
          const Text(
            "Login dengan Google atau email",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,
            ),
          ),
          const SpaceHeight(32),
          InkWell(
            onTap: () async {
              final userCredential = await signInWithGoogle();
              if (!await FirebaseDatasource.instance
                  .isUserExist(userCredential.user!.uid)) {
                final userModel = UserModel(
                    id: userCredential.user!.uid,
                    username: userCredential.user!.displayName!,
                    email: userCredential.user!.email!,
                    photo: userCredential.user!.photoURL!);
                await FirebaseDatasource.instance.setUserToFirestore(userModel);
              }
              context.pushReplacement(HomePage(
                currentUser: userCredential,
              ));
            },
            child: Image.asset(
              "assets/images/google.png",
              width: 40,
              height: 40,
            ),
          ),
          const SpaceHeight(24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: context.deviceWidth * 0.33,
                height: 1,
                color: AppColors.grey.withOpacity(0.5),
              ),
              const SpaceWidth(12),
              const Text(
                "Atau",
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey),
              ),
              const SpaceWidth(12),
              Container(
                width: context.deviceWidth * 0.33,
                height: 1,
                color: AppColors.grey.withOpacity(0.5),
              ),
            ],
          ),
          const SpaceHeight(24),
          CustomTextField(
            controller: emailController,
            label: 'Email',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          const SpaceHeight(16),
          CustomTextField(
            controller: passwordController,
            label: 'Password',
            obscureText: isObscure,
            textInputAction: TextInputAction.done,
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  isObscure = !isObscure;
                });
              },
              child: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
            ),
          ),
          const SpaceHeight(40),
          Button.filled(
            onPressed: () {
              doLogin();
            },
            label: 'Login',
          ),
          const SpaceHeight(16),
          InkWell(
            onTap: () {
              context.push(const RegisterPage());
            },
            child: const Text(
              "Sign up with Email",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                //underline
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
