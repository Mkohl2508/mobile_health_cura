import 'dart:ui';

import 'package:cura/model/general/nurse.dart';
import 'package:cura/screens/full_screen_screen.dart';
import 'package:flutter/material.dart';
import 'package:cura/globals.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfileViewScreen extends StatefulWidget {
  const ProfileViewScreen({Key? key}) : super(key: key);

  @override
  _ProfileViewScreenState createState() => _ProfileViewScreenState();
}

class _ProfileViewScreenState extends State<ProfileViewScreen> {
  @override
  Nurse nurse = masterContext.loggedNurse as Nurse;
  Image profilePic = Image.asset("assets/no-image.jpg");
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: GestureDetector(
              onTap: nurse.profileImage == null
                  ? null
                  : () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return FullScreenImage(imageUrl: nurse.profileImage);
                      }));
                    },
              child: Hero(
                tag: "imageHero",
                child: nurse.profileImage == null
                    ? Image.asset("assets/no-image.jpg")
                    : FadeInImage.memoryNetwork(
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                        image: nurse.profileImage ?? 'assets/no-image.jpg'),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Personal information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFe2e2e2)))),
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "First name, surname",
                        style: TextStyle(color: Colors.black, height: 1.5),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        nurse.fullName(),
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
                  padding: const EdgeInsets.only(left: 20, right: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Date of birth (DD-MM-YYYY)",
                          style: TextStyle(height: 1.5, color: Colors.black)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(nurse.formattedBirthday(),
                          style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                  thickness: 1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 25, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Place of residence",
                          style: TextStyle(height: 1.5, color: Colors.black)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                          "${nurse.residence.street}, ${nurse.residence.zipCode}, ${nurse.residence.city}", //adress
                          style:
                              TextStyle(color: Colors.grey[700], height: 1.5)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
