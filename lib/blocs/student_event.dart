import 'package:equatable/equatable.dart';
import 'package:local_db/models/student_model.dart';

abstract class StudentEvent extends Equatable {}

class AddStudent extends StudentEvent {
  final StudentModel newStudent;

  AddStudent({required this.newStudent});

  @override
  List<Object?> get props => [newStudent];
}

class GetStudents extends StudentEvent {
  @override
  List<Object?> get props => [];
}

class UpdateStudent extends StudentEvent {
  final StudentModel updatedStudent;

  UpdateStudent({required this.updatedStudent});

  @override
  List<Object?> get props => [updatedStudent];
}

class DeleteStudent extends StudentEvent {
  final int id;

  DeleteStudent({required this.id});

  @override
  List<Object?> get props => [id];
}