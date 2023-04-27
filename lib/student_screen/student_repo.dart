

import 'package:assigment_test/Model/student_response_model.dart';
import 'package:assigment_test/student_screen/student_dao.dart';

class StudentRepo{
  StudentDao studentDao = StudentDao();

  Future<List<StudentResponseModel>> getStudentData()=> studentDao.getStudentData();
  }