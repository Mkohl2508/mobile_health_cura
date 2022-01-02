import 'package:flutter/material.dart';
import 'package:cura/model/widget/AppColors.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({Key? key}) : super(key: key);

  @override
  _AddPatientScreenState createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.cura_darkCyan,
          title: Text('New Patient'),
        ),
        body: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(30.0),
                child: Form(
                    child: Column(children: [
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Name',
                        labelText: 'Patient Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                        labelText: 'Birthday',
                        icon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Number',
                        labelText: 'Patient Room',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.cura_cyan),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(color: AppColors.cura_cyan)))),
                    onPressed: () {},
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: 50,
                        child: Center(
                          child: Text(
                            "Save",
                            style: TextStyle(fontSize: 22),
                          ),
                        )),
                  )
                ])))));

  }
}
