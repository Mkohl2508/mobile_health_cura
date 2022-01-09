import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cura/model/enums/phase_enum.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/screens/full_screen_screen.dart';
//import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class AddWoundEntryScreen extends StatefulWidget {
  const AddWoundEntryScreen({Key? key}) : super(key: key);

  @override
  _AddWoundEntryScreenState createState() => _AddWoundEntryScreenState();
}

class _AddWoundEntryScreenState extends State<AddWoundEntryScreen> {
  final List<File> _images = [];
  int _currentPic = 0;
  final CarouselController _controller = CarouselController();

  String currentDate = DateFormat('dd.MM.yyyy').format(DateTime.now());

  final PhaseEnum? _phase = null;

  double _painLevel = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _imgFromCamera() async {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
      if (!mounted) return;
      setState(() {
        if (image != null) {
          _images.add(File(image.path));
        }
      });
    }

    _imgFromGallery() async {
      XFile? image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      if (!mounted) return;
      setState(() {
        if (image != null) {
          _images.add(File(image.path));
        }
      });
    }

    void _showPicker(context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text('Photo Library'),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                    ListTile(
                      leading: Icon(Icons.photo_camera),
                      title: Text('Camera'),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 17),
                Container(
                  height: 40,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(0, 3))
                  ]),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                          child: Center(
                              child: Text(
                        "Date: $currentDate",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ))),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                _images.isEmpty
                    ? Image.asset("assets/no-image.jpg")
                    : CarouselSlider(
                        items: _images
                            .map((item) => Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return FullScreenImage(imageFile: item);
                                      }));
                                    },
                                    child: Center(
                                        child: Hero(
                                      tag: "imageHero",
                                      child: Image.file(item,
                                          width: double.infinity),
                                    )),
                                  ),
                                ))
                            .toList(),
                        options: CarouselOptions(
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentPic = index;
                            });
                          },
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          autoPlay: false,
                          enableInfiniteScroll: false,
                        )),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _images.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.cura_darkBlue.withOpacity(
                                  _currentPic == entry.key ? 0.9 : 0.4)),
                        ),
                      );
                    }).toList()),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.cura_cyan),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(color: AppColors.cura_cyan)))),
                    onPressed: () {
                      _showPicker(context);
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 60,
                        child: Center(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_camera,
                              size: 26,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Add picture"),
                          ],
                        ))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Pain level",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SfSlider(
                  value: _painLevel,
                  onChanged: (value) {
                    setState(() {
                      _painLevel = value;
                    });
                  },
                  min: 0,
                  max: 10,
                  showLabels: true,
                  showDividers: true,
                  showTicks: true,
                  interval: 2,
                  stepSize: 1,
                  minorTicksPerInterval: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text(
                    "Wound information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        hintText: 'Yes/No',
                        labelText: 'Is the wound open?',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        hintText: 'Select a phase',
                        labelText: 'Phase of healing',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        hintText: 'in cm',
                        labelText: 'Wound length',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        hintText: 'in cm',
                        labelText: 'Wound width',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        hintText: 'in cm',
                        labelText: 'Wound depth',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        hintText: 'Select a edge',
                        labelText: 'Wound edges',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        hintText: 'Yes/No',
                        labelText: 'Is the wound smelly?',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 10.0),
                        hintText: 'Select a exudate',
                        labelText: 'Wound exudate',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0))),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.cura_cyan),
                        shape: MaterialStateProperty
                            .all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                side: BorderSide(color: AppColors.cura_cyan)))),
                    onPressed: () {},
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 60,
                        child: Center(
                            child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save,
                              size: 26,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Save"),
                          ],
                        ))),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
                /* DropDownFormField(
                    value: _phase,
                    required: true,
                    hintText: "Choose a wound phase",
                    titleText: "Wound phase",
                    onChanged: (value) {
                      setState(() {
                        _phase = value;
                      });
                    },
                    dataSource: PhaseEnum.values)*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
