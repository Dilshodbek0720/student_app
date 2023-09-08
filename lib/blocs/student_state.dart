import 'package:equatable/equatable.dart';
import 'package:local_db/models/form_status.dart';
import 'package:local_db/models/student_model.dart';

class StudentsState extends Equatable {
  const StudentsState({
    required this.status,
    required this.statusText,
    required this.students,
  });

  final FormStatus status;
  final List<StudentModel> students;
  final String statusText;

  StudentsState copyWith({
    FormStatus? status,
    List<StudentModel>? students,
    String? statusText,
  }) =>
      StudentsState(
        status: status ?? this.status,
        statusText: statusText ?? this.statusText,
        students: students ?? this.students,
      );

  @override
  List<Object?> get props => [
    status,
    students,
    statusText,
  ];
}