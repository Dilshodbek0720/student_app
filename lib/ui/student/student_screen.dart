import 'package:student_app/utils/export/export.dart';

class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}


class _StudentsScreenState extends State<StudentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students Screen"),
        backgroundColor: Colors.black,
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return const AddStudentScreen();
            }));
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: Stack(
        children: [
          BlocConsumer<StudentsBloc, StudentsState>(
              builder: (context, state){
                return state.students.isNotEmpty ? ListView(
                  children: [
                    const SizedBox(height: 5,),
                    ...List.generate(state.students.length, (index) {
                      StudentModel studentModel = state.students[index];
                      return GestureDetector(
                        onLongPress: (){
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: const Text("Bu student ma'lumotlari o'chirilsinmi!"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: const Text("CANCEL"),),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                  BlocProvider.of<StudentsBloc>(context).add(DeleteStudent(id: studentModel.id!));
                                  BlocProvider.of<StudentsBloc>(context).add(GetStudents());
                                }, child: const Text("OK"))
                              ],
                            );
                          });
                        },
                        child: Container(
                          height: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(width: 1, color: Colors.cyan),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.cyan.withOpacity(0.1),
                                blurRadius: 3,
                                spreadRadius: 3
                              ),
                              BoxShadow(
                                  color: Colors.cyanAccent.withOpacity(0.05),
                                  blurRadius: 3,
                                  spreadRadius: 3
                              )
                            ]
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              ListTile(
                                leading: Container(height: 58, width: 58, decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.cyan), borderRadius: BorderRadius.circular(6)), child: ClipRRect(borderRadius: BorderRadius.circular(6), child: Image.file(File(studentModel.image), fit: BoxFit.cover,))),
                                title: Text(studentModel.firstName, style: const TextStyle(fontSize: 20),),
                                subtitle: Text(studentModel.lastName, style: const TextStyle(fontSize: 18),),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: IconButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return UpdateStudentScreen(studentModel: studentModel);
                                      }));
                                    },
                                    icon: const Icon(Icons.edit, color: Colors.green,size: 30,),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(studentModel.university,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16
                                ),),
                              ),
                              const SizedBox(height: 2,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text("Guruh: ${studentModel.group}. ${studentModel.course}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16
                                  ),),
                              ),
                              const SizedBox(height: 7,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                  child: Text(studentModel.description, maxLines: 3, overflow: TextOverflow.ellipsis,)),
                            ],
                          ),
                        ),
                      );
                    })
                  ],
                ) : const Center(child: Text("Empty"),);
              },
              listener: (context, state){
              }
          ),
          Visibility(
            visible:
            context.watch<StudentsBloc>().state.status == FormStatus.loading,
            child: const Align(child: CircularProgressIndicator()),
          )
        ],
      ),
    );
  }
}