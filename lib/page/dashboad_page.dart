import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/models/staff_model.dart';
import 'package:firebase1/res/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  TextEditingController IDController = TextEditingController();
  TextEditingController NameController = TextEditingController();
  TextEditingController AgeController = TextEditingController();
  TextEditingController SalaryController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      FirebaseFirestore.instance;

      var list = FireStoreService.internal().getNotes();
      print("Data:" + list.first.toString());
    });
  }

  // CollectionReference _collectionRef =
  //     FirebaseFirestore.instance.collection('staff');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello'),
        actions: [
          IconButton(
              onPressed: () async {
                // CollectionReference getuser =
                //     FirebaseFirestore.instance.collection('staff');
                // DocumentSnapshot rest= await  Staff.fromMap(map, reference: reference)
              },
              icon: const Icon(Icons.get_app_outlined)),
          const SizedBox(
            width: 30,
          ),
          IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                FirebaseAuth.instance.currentUser;
              },
              icon: const Icon(
                Icons.login_outlined,
                size: 30,
              )),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: IDController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'ID',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: NameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Name',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: AgeController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Age',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: SalaryController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              hintText: 'Salary',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            width: 200,
            //  color: Colors.amber,
            child: CupertinoButton(
              child: const Text('Create'),
              onPressed: () async {
                createrStaff(Staff(
                    id: int.parse(IDController.text.trim()),
                    name: NameController.text.trim(),
                    age: int.parse(AgeController.text.trim()),
                    score: double.parse(SalaryController.text.trim())));
              },
              color: Colors.red[400],
            ),
          ),
        ],
      ),
    );
  }

  Future createrStaff(Staff staff) async {
    final docStaff = FirebaseFirestore.instance.collection('staff').doc();
    final json = {
      'id': IDController.text.trim(),
      'name': NameController.text.trim(),
      'age': AgeController.text.trim(),
      'salary': SalaryController.text.trim(),
    };
    await docStaff.set(json);
    // final docStaff = FirebaseFirestore.instance.collection('staff').doc();
    // staff.id = docStaff.id as int;

    // final json = staff.toMap();
    // await docStaff.set(json);
  }
}
