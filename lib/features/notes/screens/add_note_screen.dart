import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/manager/components/custom_text_field.dart';
import 'package:note_app/manager/ui/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/manager/ui/toast.dart';

class AddNewNoteScreen extends StatefulWidget {
  const AddNewNoteScreen({super.key, required this.categoryID});
  final String categoryID;

  @override
  State<AddNewNoteScreen> createState() => _AddNewNoteScreenState();
}

class _AddNewNoteScreenState extends State<AddNewNoteScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController noteController = TextEditingController();
  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
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
                    "Add New Note",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              CustomTextField(
                controller: noteController,
                minLines: 4,
                maxLines: 10,
                hint: "Category Name",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Field is required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    FirebaseFirestore.instance.collection('categories').doc(widget.categoryID).collection("notes").add({"note": noteController.text , "categoryID" : widget.categoryID}).then(
                          (value) {
                        showToast(message: "Note Added Successfully" , color: Colors.green);
                        Navigator.pop(context);
                        print("Note $value Added");
                      },
                    ).catchError((error) {
                      showToast(message: "Note Adding Failed" , color: UiColor.cancelledColor.withOpacity(0.8));
                      print("Failed to add note: $error");
                      return;
                    });
                  }
                },
                minWidth: double.infinity,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                color: UiColor.color5,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Add",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: UiColor.primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
