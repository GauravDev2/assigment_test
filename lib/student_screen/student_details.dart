import 'package:assigment_test/Model/student_response_model.dart';
import 'package:flutter/material.dart';

class StudentDetails extends StatefulWidget {
  StudentResponseModel data;
   StudentDetails(this.data);

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child:
                widget.data.image != '' ?
                Image.network('${widget.data.image}'):
                Image.asset("images/studyimage.gif")),
          ),
          SizedBox(height: 10,),
          Text('${widget.data.name}'),
          SizedBox(height: 10,),
          Text('${widget.data.gender}'),
          SizedBox(height: 10,),
          Text('${widget.data.dateOfBirth}'),
          SizedBox(height: 10,),
          Text('${widget.data.eyeColour}'),
        ],
      ),
    );
  }
}