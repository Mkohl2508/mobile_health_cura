import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cura/model/enums/edge_enum.dart';
import 'package:cura/model/enums/enum_converter.dart';
import 'package:cura/model/enums/exudate_enum.dart';
import 'package:cura/model/enums/phase_enum.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound_entry.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:cura/screens/full_screen_screen.dart';
import 'package:cura/utils/query_wrapper.dart';
import 'package:cura/model/general/room.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:uuid/uuid.dart';

class AddWoundEntryScreen extends StatefulWidget {
  final Wound wound;
  final Patient patient;
  final Room room;
  const AddWoundEntryScreen(
      {Key? key,
      required this.wound,
      required this.patient,
      required this.room})
      : super(key: key);

  @override
  _AddWoundEntryScreenState createState() => _AddWoundEntryScreenState();
}

class _AddWoundEntryScreenState extends State<AddWoundEntryScreen> {
  final List<File> _images = [];
  int _currentPic = 0;
  final CarouselController _controller = CarouselController();

  String currentDate = DateFormat('dd.MM.yyyy').format(DateTime.now());

  PhaseEnum? _phase = null;
  EdgeEnum? _edge = null;
  ExudateEnum? _exudate = null;
  bool _isSmelly = false;
  bool _isOpen = false;

  TextEditingController _lengthController = TextEditingController();
  TextEditingController _widthController = TextEditingController();
  TextEditingController _depthController = TextEditingController();

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
          /* QueryWrapper.postWoundEntry(File(image.path), widget.patient,
              widget.room, widget.wound.id, widget.wound.);*/
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
                    "Wound entry information",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          hintText: "yes/no",
                          labelText: "Is the wound open?",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      onChanged: (value) {
                        setState(() {
                          if (value == "yes") {
                            _isOpen = true;
                          } else if (value == "no") {
                            _isOpen = false;
                          } else {
                            throw Exception("Invalid isOpen value");
                          }
                        });
                      },
                      items: ["yes", "no"].map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item.toString()),
                        );
                      }).toList(),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          hintText: "Choose a wound phase",
                          labelText: "Wound phase",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      onChanged: (value) {
                        setState(() {
                          _phase =
                              EnumConverter.stringToPhaseEnum(value.toString());
                        });
                      },
                      items: getPhaseList().map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item.toString()),
                        );
                      }).toList(),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    controller: _lengthController,
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
                    controller: _widthController,
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
                    controller: _depthController,
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
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          hintText: "Choose a wound edge",
                          labelText: "Wound edge",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      onChanged: (value) {
                        setState(() {
                          _edge =
                              EnumConverter.stringToEdgeEnum(value.toString());
                        });
                      },
                      items: getEdgeList().map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item.toString()),
                        );
                      }).toList(),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          hintText: "yes/no",
                          labelText: "Is the wound smelly?",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      onChanged: (value) {
                        setState(() {
                          if (value == "yes") {
                            _isSmelly = true;
                          } else if (value == "no") {
                            _isSmelly = false;
                          } else {
                            throw Exception("Invalid isSmelly value");
                          }
                        });
                      },
                      items: ["yes", "no"].map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item.toString()),
                        );
                      }).toList(),
                    )),
                Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 10.0),
                          hintText: "Choose a wound exudate",
                          labelText: "Wound exudate",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0))),
                      onChanged: (value) {
                        setState(() {
                          _exudate = EnumConverter.stringToExudateEnum(
                              value.toString());
                        });
                      },
                      items: getExudateList().map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item.toString()),
                        );
                      }).toList(),
                    )),
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
                      //check the values

                      if (_phase == null) {
                        _showSnackBar("Please choose a wound phase");
                        return;
                      } else if (_edge == null) {
                        _showSnackBar("Please choose a wound edge");
                        return;
                      } else if (_exudate == null) {
                        _showSnackBar("Please choose a wound exudate");
                        return;
                      } else if (_lengthController.text.isEmpty) {
                        _showSnackBar("Please enter a wound length");
                        return;
                      } else if (_widthController.text.isEmpty) {
                        _showSnackBar("Please enter a wound width");
                        return;
                      } else if (_depthController.text.isEmpty) {
                        _showSnackBar("Please enter a wound depth");
                        return;
                      }

                      WoundEntry entry = WoundEntry(
                          id: Uuid().v1(),
                          date: DateTime.now(),
                          images: [],
                          painLevel: _painLevel.toInt(),
                          phase: _phase,
                          length: double.parse(_lengthController.text),
                          width: double.parse(_widthController.text),
                          depth: double.parse(_depthController.text),
                          edge: _edge,
                          isSmelly: _isSmelly,
                          isOpen: _isOpen,
                          exudate: _exudate);

                      widget.wound.woundEntrys!.add(entry);

                      Navigator.pop(context);
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(String s) {
    final snackBar = SnackBar(
      content: Text(s),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
