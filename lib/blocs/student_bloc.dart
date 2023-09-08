import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_db/local/local_database.dart';
import 'package:local_db/models/form_status.dart';
import 'package:local_db/models/student_model.dart';
import 'package:student_app/blocs/student_event.dart';
import 'package:student_app/blocs/student_state.dart';
import '../utils/constants/constants.dart';

class StudentsBloc extends Bloc<StudentEvent, StudentsState> {
  StudentsBloc()
      : super(
    const StudentsState(
      status: FormStatus.pure,
      statusText: "",
      students: [],
    ),
  ) {
    on<AddStudent>(_addStudent);
    on<GetStudents>(_getStudents);
    on<UpdateStudent>(_updateStudent);
    on<DeleteStudent>(_deleteStudent);
  }

  _addStudent(AddStudent event, Emitter<StudentsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: StatusTextConstants.addStudent,
      ),
    );
    await Future.delayed(const Duration(seconds: 1));
    await LocalDatabase.insertStudent(event.newStudent);
    emit(
      state.copyWith(
          status: FormStatus.success,
          statusText: StatusTextConstants.addStudent,
          students: [...state.students, event.newStudent]),
    );
  }

  _getStudents(GetStudents event, Emitter<StudentsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: StatusTextConstants.gotAllStudents,
      ),
    );
    await Future.delayed(const Duration(seconds: 1));
    List<StudentModel> newStudents = await LocalDatabase.getAllStudents();
    emit(
      state.copyWith(
        status: FormStatus.success,
        statusText: StatusTextConstants.gotAllStudents,
        students: newStudents,
      ),
    );
  }

  _updateStudent(UpdateStudent event, Emitter<StudentsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: StatusTextConstants.studentUpdate,
      ),
    );
    await Future.delayed(const Duration(seconds: 1));
    await LocalDatabase.updateStudent(studentModel: event.updatedStudent);

    emit(
      state.copyWith(
        status: FormStatus.success,
        statusText: StatusTextConstants.studentUpdate,
      ),
    );
  }

  _deleteStudent(DeleteStudent event, Emitter<StudentsState> emit) async {
    emit(
      state.copyWith(
        status: FormStatus.loading,
        statusText: StatusTextConstants.studentDelete,
      ),
    );
    await Future.delayed(const Duration(seconds: 1));
    await LocalDatabase.deleteStudent(event.id);
    emit(
      state.copyWith(
        status: FormStatus.success,
        statusText: StatusTextConstants.studentDelete,
      ),
    );
  }
}