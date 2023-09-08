import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_app/blocs/student_bloc.dart';
import 'package:student_app/blocs/student_event.dart';
import 'package:student_app/blocs/student_state.dart';
import 'package:student_app/data/models/student_model.dart';
import '../../../data/models/form_status.dart';
import '../../../utils/colors/colors.dart';
import '../../../utils/ui_utils/show_error_message.dart';
import '../../widgets/global_button.dart';
import '../../widgets/global_text_fields.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  ImagePicker picker = ImagePicker();
  String imgUrl = "";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Add Student"),
      ),
      body: BlocConsumer<StudentsBloc, StudentsState>(
        builder: (context, state){
          return ListView(
            children: [
              const SizedBox(height: 10,),
              GlobalTextField(hintText: "FirstName", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: firstNameController),
              GlobalTextField(hintText: "LastName", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: lastNameController),
              GlobalTextField(hintText: "Description", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: descriptionController),
              GlobalTextField(hintText: "Course", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: courseController),
              GlobalTextField(hintText: "Group", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: groupController),
              GlobalTextField(hintText: "University", keyboardType: TextInputType.text, textInputAction: TextInputAction.done, textAlign: TextAlign.start, controller: universityController),
              const SizedBox(height: 5,),
              TextButton(
                onPressed: () {
                  showBottomSheetDialog();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Select Image"), Icon(Icons.image)],
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GlobalButton(title: "Add Student", onTap: (){
                  if(firstNameController.text.isNotEmpty&&lastNameController.text.isNotEmpty&&descriptionController.text.isNotEmpty&&courseController.text.isNotEmpty&&groupController.text.isNotEmpty&&universityController.text.isNotEmpty&&imgUrl.isNotEmpty){
                    BlocProvider.of<StudentsBloc>(context).add(AddStudent(newStudent: StudentModel(
                      lastName: lastNameController.text,
                      firstName: firstNameController.text,
                      description: descriptionController.text,
                      image: imgUrl,
                      course: courseController.text,
                      group: groupController.text,
                      university: universityController.text
                    )));
                  }else{
                    showErrorMessage(message: "Malumotlar to'liq emas", context: context);
                  }
                }),
              )
            ],
          );
        },
        listener: (context, state){
          if(state.status == FormStatus.success ){
            BlocProvider.of<StudentsBloc>(context).add(GetStudents());
            Navigator.pop(context);
          }
          if(state.status == FormStatus.error){
            showErrorMessage(message: state.statusText, context: context);
          }
        },
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: const BoxDecoration(
            color: AppColors.C_162023,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt, color: Colors.white,),
                title: const Text("Select from Camera", style: TextStyle(color: Colors.white),),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo, color: Colors.white,),
                title: const Text("Select from Gallery", style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null && context.mounted) {
      imgUrl = xFile.path;
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      imgUrl = xFile.path;
    }
  }
}