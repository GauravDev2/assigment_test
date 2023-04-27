

import 'package:assigment_test/Model/student_response_model.dart';
import 'package:assigment_test/student_screen/student_repo.dart';
import 'package:rxdart/rxdart.dart';

class StudentBloc{
  StudentRepo studentRepo = StudentRepo();
  final studentBS = BehaviorSubject<List<StudentResponseModel>>();
  get valueStream  => studentBS.stream;

  Future<List<StudentResponseModel>> getStudentData() async{

    List<StudentResponseModel> studentResponseModel  = await
    studentRepo.getStudentData();
    if(studentResponseModel != null){
      studentBS.sink.add(studentResponseModel);
    }
    return studentResponseModel;
  }

}