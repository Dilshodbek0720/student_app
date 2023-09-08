import 'package:student_app/utils/export/export.dart';

class UpdateStudentScreen extends StatefulWidget {
  const UpdateStudentScreen({super.key, required this.studentModel});
  final StudentModel studentModel;

  @override
  State<UpdateStudentScreen> createState() => _UpdateStudentScreenState();
}

class _UpdateStudentScreenState extends State<UpdateStudentScreen> {
  ImagePicker picker = ImagePicker();
  String imgUrl = "";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  TextEditingController universityController = TextEditingController();

  @override
  void initState() {
    firstNameController = TextEditingController(text: widget.studentModel.firstName);
    lastNameController = TextEditingController(text: widget.studentModel.lastName);
    descriptionController = TextEditingController(text: widget.studentModel.description);
    courseController = TextEditingController(text: widget.studentModel.course);
    groupController = TextEditingController(text: widget.studentModel.group);
    universityController = TextEditingController(text: widget.studentModel.university);
    imgUrl = widget.studentModel.image;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Update Student"),
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
                  children: [
                    Text("Select Image"),
                    SizedBox(width: 10,),
                    Icon(Icons.image)],
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34.0),
                child: GlobalButton(title: "Add Student", onTap: (){
                  if(firstNameController.text.isNotEmpty&&lastNameController.text.isNotEmpty&&descriptionController.text.isNotEmpty&&courseController.text.isNotEmpty&&groupController.text.isNotEmpty&&universityController.text.isNotEmpty&&imgUrl.isNotEmpty){
                    BlocProvider.of<StudentsBloc>(context).add(UpdateStudent(updatedStudent: StudentModel(
                        lastName: lastNameController.text,
                        firstName: firstNameController.text,
                        description: descriptionController.text,
                        image: imgUrl,
                        course: courseController.text,
                        group: groupController.text,
                        university: universityController.text,
                      id: widget.studentModel.id
                    )
                    ),
                    );
                  }else{
                    showErrorMessage(message: "Malumotlar to'liq emas", context: context);
                  }
                }),
              ),
              const SizedBox(height: 30,)
            ],
          );
        },
        listener: (context, state){
          if(state.status == FormStatus.success){
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