class StudentModelFields {
  static const String id = "_id";
  static const String tableName = "tables";
  static const String image = "image";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String university = "university";
  static const String group = "groups";
  static const String course = "course";
  static const String description = "description";
}

class StudentModel {
  int? id;
  final String image;
  final String firstName;
  final String lastName;
  final String university;
  final String group;
  final String course;
  final String description;

  StudentModel({required this.group, required this.university, required this.lastName, required this.firstName,this.id,required this.image, required this.course, required this.description});


  StudentModel copyWith({
    String? image,
    String? firstName,
    String? lastName,
    String? university,
    String? group,
    String? course,
    String? description,
    int? id,
  }) {
    return StudentModel(
      image: image ?? this.image,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      university: university ?? this.university,
      group: group ?? this.group,
      course: course ?? this.course,
      description: description ?? this.description,
      id: id ?? this.id,
    );
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      image: json[StudentModelFields.image],
      firstName: json[StudentModelFields.firstName],
      lastName: json[StudentModelFields.lastName],
      university: json[StudentModelFields.university],
      group: json[StudentModelFields.group],
      course: json[StudentModelFields.course],
      description: json[StudentModelFields.description],
      id: json[StudentModelFields.id] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      StudentModelFields.image: image,
      StudentModelFields.firstName: firstName,
      StudentModelFields.lastName: lastName,
      StudentModelFields.university: university,
      StudentModelFields.group: group,
      StudentModelFields.course: course,
      StudentModelFields.description: description,
    };
  }
}