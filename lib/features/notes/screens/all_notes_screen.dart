import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:note_app/features/categories/screens/update_category_screen.dart';
import 'package:note_app/features/notes/screens/add_note_screen.dart';
import 'package:note_app/features/notes/screens/edit_note_screen.dart';
import 'package:note_app/manager/images.dart';
import 'package:note_app/manager/route.dart';
import 'package:note_app/manager/ui/color.dart';
import 'package:note_app/manager/ui/loader.dart';
import 'package:note_app/manager/ui/toast.dart';

class AllNotesScreen extends StatefulWidget {
  const AllNotesScreen({super.key, required this.categoryID});
  final String categoryID;

  @override
  State<AllNotesScreen> createState() => _AllNotesScreenState();
}

class _AllNotesScreenState extends State<AllNotesScreen> {
  List<QueryDocumentSnapshot> notes = [];
  late Stream<QuerySnapshot> notesStream;

  @override
  void initState() {
    notesStream =
        FirebaseFirestore.instance.collection('categories').doc(widget.categoryID).collection("notes").snapshots();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNewNoteScreen(categoryID: widget.categoryID),));
        },
        backgroundColor: UiColor.color5,
        heroTag: 'addNote',
        child: const Icon(
          Icons.add,
          color: UiColor.primaryColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                InkWell(
                  child: const Icon(Icons.arrow_back_ios_new),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  "Your Notes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: notesStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return SizedBox();
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Loader();
                  }
                  notes = snapshot.data?.docs ?? [];
                  return notes.isEmpty
                      ? const Center(
                    child: Text(
                      "No Notes Found Please Add Note",
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
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditNoteScreen(categoryID: widget.categoryID, note: notes[index]["note"] , noteID: notes[index].id,),));
                        },
                        onLongPress: () {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.rightSlide,
                            title: "Delete Confirm",
                            desc: 'Do you wand to delete this note ?',
                            btnCancelOnPress: () {

                            },
                            btnOkOnPress: () {
                              FirebaseFirestore.instance.collection('categories').doc(widget.categoryID).collection("notes").doc(notes[index].id).delete().then(
                                    (value) {
                                  showToast(message: "Note Deleted Successfully" , color: Colors.green);
                                },
                              ).catchError((error) {
                                showToast(message: "Note Deleting Failed" , color: UiColor.cancelledColor.withOpacity(0.8));
                                print("Failed to delete Note: $error");
                                return;
                              });
                            },
                          ).show();
                        },
                        child: Card(
                          color: UiColor.color3,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Flexible(
                                  child: Text(
                                    notes[index]["note"],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: notes.length,
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
