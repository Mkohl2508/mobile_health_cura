# Cura Wound Documentation

This App was developed for the course Medical Applications for Public Health. The intention for this project is to support people working in Nursing Homes with their work. As a first use case, this app will help with the documentation of wound that the patient have. The staff in a nursing home has to regularly check on a patients wound, document its status and also take pictures. Cura aims to make this process easier and faster for the nurses, since Nursing Homes are notoriously understaffed. 

Therefore Cure provides an overview of the entire Nursing Home and every room with every patient. The patients are represented with their own profile with personal data, picture and information to their current attending doctor. From the patient screen, a patient record can be accessed where wounds can be documented and a history with already healed wound can be inspected. A wound can be selected and new entry for a documented state can be added. Cura will analyze the wound entries and send notifications when a wound needs to be examined. This way we want to also assist the personnel in keeping an overview of the patients and their wounds.

Future iterations of Cura can deliver a much more rounded and generalized Application. The patient record can be expanded to also show a patients medical record, medication, diseases and illnesses and information for emergency contacts.

## Technical Details
Cura is developed with flutter using Firebase as a database. In Firebase it uses a Firestore NoSQL Database to save information and Firebase Storage to save files like pictures of patients or wounds. Furthermore is Firebase Functions used to analyze the wound entries and create notifications.

## Quick Start
- Install an Android or IOS emulator
- install the [Flutter SDK](https://flutter.dev/docs/get-started/install)
- run `flutter doctor` from the command line to verify your installation
- move to Implementation/App directory to pubspec.yaml
- make sure all dependencies are installed with `flutter pub get`
- start emulator and run application with `flutter run`
- **optional:** when using VS Code open main.dart and got to *Run > Start Debugging/Run without Debugging* and then select emulator 

## Copyright and licensing
This project was created by Marlon Kohlberger, Marcel Trattner, Aziz Khalledi and Manja Wischer. It is licensed under [MIT License](LICENSE.md). 