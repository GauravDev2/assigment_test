import 'package:assigment_test/Model/student_response_model.dart';
import 'package:assigment_test/converter_screen/converter_screen.dart';
import 'package:assigment_test/student_screen/student_bloc.dart';
import 'package:assigment_test/student_screen/student_details.dart';
import 'package:assigment_test/utility/common_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}




class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  StudentBloc studentBloc = StudentBloc();

  @override
  void initState() {
    // TODO: implement initState
    studentBloc.getStudentData();
    _tabController = TabController(length: 2,vsync: this);
    _tabController?.addListener(() {
    });
    super.initState();
  }


  TabController? _tabController;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assignment'),),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            TabBar(
                isScrollable: true,
                controller: _tabController,
                labelColor: Colors.blue,
                labelPadding:
                const EdgeInsets.symmetric(horizontal: 15.0),
                labelStyle: const TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w700),
                tabs: [
                  Tab(
                    text: 'Student Data',
                  ),
                  Tab(
                    text: 'Currency Coverter',
                  )
                ]),

            Expanded(
              child: Container(
                child: TabBarView(
                    controller: _tabController,
                    children: [
                      showHomeData(),
                      ConverterScreen()
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget showHomeData(){
    return StreamBuilder<List<StudentResponseModel>>(
        stream: studentBloc.valueStream,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context,index){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentDetails(snapshot.data![index])));
                  },
                  child: Card(

                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 70,
                              width: 70,
                              padding: EdgeInsets.all(8),
                              child:
                              snapshot.data![index].image != null && snapshot.data![index].image !='' ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child:
                                  Image.network(snapshot.data![index].image!))
                                  :
                              Image.asset("images/studyimage.gif"),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${snapshot.data![index].name}'),
                            SizedBox(height: 10,),
                            Text('${snapshot.data![index].gender}'),
                          ],
                        ),

                      ],
                    ),
                    margin: EdgeInsets.only(left: 20.0, right: 20.0,top : 5.0),
                  ),
                );
              },

            );

          }else{
            if(snapshot.hasError){
              ToastMessage.showToastMessage('${snapshot.hasError}');
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }
          return Center(
            child: Container(
              child: Text('No Data'),
            ),
          );
        }
    );
  }

}



