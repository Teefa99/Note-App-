import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/manager/images.dart';
import 'package:note_app/manager/route.dart';
import 'package:note_app/manager/ui/color.dart';
import 'package:note_app/manager/ui/loader.dart';
import 'package:note_app/manager/ui/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QueryDocumentSnapshot> categories = [];
  Stream<QuerySnapshot> categoriesStream =
      FirebaseFirestore.instance.collection('categories').snapshots();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Stack(
        children: [
          PositionedDirectional(
            bottom: 16,
            end: 10,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteManager.addNewCategoryScreen);
              },
              backgroundColor: UiColor.color5,
              heroTag: 'addCategory',
              child: const Icon(
                Icons.add,
                color: UiColor.primaryColor,
              ),
            ),
          ),
          PositionedDirectional(
            top: 50,
            end: 10,
            child: FloatingActionButton(
              onPressed: () async {
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.disconnect();
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteManager.loginScreen,
                  (route) => false,
                );
              },
              backgroundColor: UiColor.cancelledColor.withOpacity(0.9),
              heroTag: 'logout',
              child: const Icon(
                Icons.logout,
                color: UiColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Your Notes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: categoriesStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return SizedBox();
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  categories = snapshot.data?.docs ?? [];
                  return categories.isEmpty
                      ? const Center(
                          child: Text(
                            "No Categoreis Found Please Add Category",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, mainAxisExtent: 160.h),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onLongPress: () {
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.question,
                                    animType: AnimType.rightSlide,
                                    title: "Confirm Delete",
                                    desc: 'Do you want to delete ${categories[index]["name"]}?',
                                    btnCancelOnPress: () {},
                                btnOkOnPress: () {
                                  FirebaseFirestore.instance.collection('categories').doc(categories[index].id).delete().then(
                                        (value) {
                                      showToast(message: "Category Deleted Successfully" , color: Colors.green);
                                    },
                                  ).catchError((error) {
                                    showToast(message: "Category Deleting Failed" , color: UiColor.cancelledColor.withOpacity(0.8));
                                    print("Failed to add category: $error");
                                    return;
                                  });
                                },
                                ).show();
                              },
                              child: Card(
                                color: UiColor.color3,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Image.asset(
                                          ImageManager.logo,
                                          height: 80,
                                          width: 80,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          categories[index]["name"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: categories.length,
                          padding: EdgeInsets.zero,
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
