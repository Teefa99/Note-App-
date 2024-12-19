import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:note_app/manager/components/custom_text_field.dart';
import 'package:note_app/manager/images.dart';
import 'package:note_app/manager/route.dart';
import 'package:note_app/manager/ui/color.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
@override
  void dispose() {
  emailController.dispose();
  passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              InkWell(child: const Icon(Icons.arrow_back_ios_new) , onTap: () {
                Navigator.pop(context);
              },),
              const SizedBox(height: 30,),
              Center(
                  child: Image.asset(
                    ImageManager.logo,
                    width: 150.w,
                    height: 150.h,
                  )),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Sign Up",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomTextField(
                hint: "User Name",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field is required";
                  }
                  return null;
                },
                hint: "E-mail",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: passwordController,
                  obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field is required";
                  }
                  return null;
                },
                hint: "Password",
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      Navigator.pushNamedAndRemoveUntil(context, RouteManager.homeScreen , (route) => false,);
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                minWidth: double.infinity,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                color: UiColor.color5,
                padding: const EdgeInsets.all(10),

                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: UiColor.primaryColor),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Have an account?",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600 , color: UiColor.color5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
