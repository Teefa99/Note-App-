import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/manager/components/custom_text_field.dart';
import 'package:note_app/manager/ui/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/manager/ui/toast.dart';

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({super.key});

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController categoryNameController = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  @override
  void dispose() {
    categoryNameController.dispose();
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
                    "Add New Category",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              CustomTextField(
                controller: categoryNameController,
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
                    categories.add({"name": categoryNameController.text , "UserID" : FirebaseAuth.instance.currentUser?.uid ?? ""}).then(
                      (value) {
                        showToast(message: "Category Added Successfully" , color: Colors.green);
                        Navigator.pop(context);
                        print("Category $value Added");
                      },
                    ).catchError((error) {
                      showToast(message: "Category Adding Failed" , color: UiColor.cancelledColor.withOpacity(0.8));
                      print("Failed to add category: $error");
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
