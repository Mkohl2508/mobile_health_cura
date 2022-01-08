import 'package:carousel_slider/carousel_slider.dart';
import 'package:cura/model/general/room.dart';
import 'package:cura/model/patient/patient.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound.dart';
import 'package:cura/model/patient/patient_treatment/wound/wound_entry.dart';
import 'package:cura/model/widget/AppColors.dart';
import 'package:flutter/material.dart';

import 'add_wound_entry_screen.dart';
import 'full_screen_screen.dart';

class WoundInformationScreen extends StatefulWidget {
  final Patient patient;
  final Room room;
  final Wound wound;
  final List<WoundEntry> woundEntrys;
  const WoundInformationScreen(
      {Key? key,
      required this.patient,
      required this.room,
      required this.wound,
      required this.woundEntrys})
      : super(key: key);

  @override
  _WoundInformationScreenState createState() => _WoundInformationScreenState();
}

class _WoundInformationScreenState extends State<WoundInformationScreen> {
  late int _currentIndex;

  void _sortByDate() {
    widget.woundEntrys.sort((a, b) => a.date.compareTo(b.date));
  }

  @override
  void initState() {
    _sortByDate();
    _currentIndex =
        widget.woundEntrys.isNotEmpty ? widget.woundEntrys.length - 1 : 0;
    super.initState();
  }

  final CarouselController _controller = CarouselController();
  int _currentPic = 0;

  @override
  Widget build(BuildContext context) {
    WoundEntry? _currentEntry = widget.woundEntrys.isNotEmpty
        ? widget.woundEntrys[_currentIndex]
        : null;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: AppColors.cura_darkCyan,
        title: Text(
          widget.patient.fullName(),
          style: TextStyle(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddWoundEntryScreen(
                          patient: widget.patient,
                          room: widget.room,
                          woundIndex: widget.wound.id,
                          woundEntryIndex: _currentIndex,
                        )));
          },
          child: Icon(Icons.add),
          backgroundColor: AppColors.cura_darkCyan),
      body: SafeArea(
          child: SingleChildScrollView(
              child: _currentEntry == null
                  ? Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Center(
                        child: Text(
                            "No entries.\nPlease add an entry for this wound."),
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(height: 17),
                        Container(
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: Offset(0, 3))
                          ]),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: IconButton(
                                    icon: Icon(Icons.arrow_back_ios_new),
                                    onPressed: () {
                                      setState(() {
                                        if (_currentIndex > 0) {
                                          _currentEntry = widget
                                              .woundEntrys[_currentIndex--];
                                        }
                                      });
                                    }),
                              ),
                              Expanded(
                                  child: Center(
                                      child: Text(
                                _currentEntry!.formattedDate(),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ))),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: () {
                                      setState(() {
                                        if (_currentIndex <
                                            widget.woundEntrys.length - 1) {
                                          _currentEntry = widget
                                              .woundEntrys[_currentIndex++];
                                        }
                                      });
                                    }),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CarouselSlider(
                            items: _currentEntry!.images
                                .map((item) => Container(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return FullScreenImage(
                                                imageUrl: item);
                                          }));
                                        },
                                        child: Center(
                                            child: Hero(
                                          tag: "imageHero",
                                          child: Image.network(item,
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
                            children: _currentEntry!.images
                                .asMap()
                                .entries
                                .map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 4.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.cura_darkBlue
                                          .withOpacity(_currentPic == entry.key
                                              ? 0.9
                                              : 0.4)),
                                ),
                              );
                            }).toList()),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom:
                                      BorderSide(color: Color(0xFFe2e2e2)))),
                          width: 500,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "First name, surname",
                                      style: TextStyle(
                                          color: Colors.black, height: 1.5),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "widget.patient.fullName()",
                                      style: TextStyle(color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Date of birth (DD-MM-YYYY)",
                                        style: TextStyle(
                                            height: 1.5, color: Colors.black)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text("widget.patient.formattedBirthday()",
                                        style:
                                            TextStyle(color: Colors.grey[700])),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 25, bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Place of residence",
                                        style: TextStyle(
                                            height: 1.5, color: Colors.black)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        "widget.patient.residence.getAddress(),",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            height: 1.5)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))),
    );
  }
}
