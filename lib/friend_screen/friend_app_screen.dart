import 'package:assigment_test/helper/db_helper.dart';
import 'package:flutter/material.dart';



class FriendScreen extends StatefulWidget {
  const FriendScreen({Key? key}) : super(key: key);

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  List<Map<String,dynamic>> item = [];
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  bool _isLoding = true;

  showForm(int? id) {
    if(id != null){
      final existingFinal = item.firstWhere((element) =>
      element['id'] == id);
      _nameController.text = existingFinal['name'];
      _ageController.text = existingFinal['age'];
      _genderController.text = existingFinal['gender'];
    }
    showBottomSheet(context: context, builder: (_)=>
        Container(
          padding: EdgeInsets.all(10),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(hintText: 'Name'),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: _ageController,
            decoration: InputDecoration(hintText: '23'),
          ),
          SizedBox(height: 10,),
          TextField(
            controller: _genderController,
            decoration: InputDecoration(hintText: 'M/F'),
          ),
          SizedBox(height: 10,),
          Center(child: ElevatedButton(onPressed: ()async{
            if(id == null){
              await _createData();

            }if(id != null){
              await _updateData(id);
            }
             _nameController.text = '';
             _ageController.text = '';
             _genderController.text = '';
             Navigator.pop(context);
          }, child: Text(id == null ? 'Create Data' : 'Update Data')))
        ],
      ),));
  }

  void _refreshJournal()async{
    final data = await SQLHelper.getItems();
    setState(() {
      item = data;
      _isLoding = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _refreshJournal();
    print('object length ${item.length}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> showForm(null),
      ),
      body: ListView.builder(
        itemCount: item.length,
        shrinkWrap: true,

        itemBuilder: (context,index){
          return Card(
            color: Colors.cyan,
            child: ListTile(
              trailing: SizedBox(
                width: 100,
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      showForm(item[index]['id']) ;
                    }, icon: Icon(Icons.edit)),
                    IconButton(onPressed: (){
                      _deleteItem(item[index]['id']);
                    }, icon: Icon(Icons.delete))
                  ],
                ),
              ),
              title: Text(item[index]['name']),
              subtitle: Column(
                children: [
                  Text(item[index]['age']),
                  Text(item[index]['gender']),
                ],
              ),

            ),
          );
        },
      ),
    );
  }

  _createData() async{
    await SQLHelper.createdItem(_nameController.text, _ageController.text, _genderController.text);
    _refreshJournal();
  }

  _updateData(int id)async {
    await SQLHelper.updateItems(id,_nameController.text, _ageController.text, _genderController.text);
    _refreshJournal();
  }

  void _deleteItem(int id)async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Deleted Successfully')));
  _refreshJournal();
  }



}
