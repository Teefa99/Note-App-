import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:note_app/manager/components/custom_text_field.dart';
import 'package:note_app/manager/ui/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/manager/ui/toast.dart';

class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen({super.key, required this.categoryID, required this.categoryName});
  final String categoryID;
  final String categoryName;

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController categoryNameController = TextEditingController();
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
@override
  void initState() {
    categoryNameController.text = widget.categoryName;
    super.initState();
  }
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
                    "Update Category",
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
                    categories.doc(widget.categoryID).update({"name" : categoryNameController.text}).then(
                      (value) {
                        showToast(message: "Category Updated Successfully" , color: Colors.green);
                        Navigator.pop(context);
                      },
                    ).catchError((error) {
                      showToast(message: "Category Updating Failed" , color: UiColor.cancelledColor.withOpacity(0.8));
                      print("Failed to update category: $error");
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
                  "Update",
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
