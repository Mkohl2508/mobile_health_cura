const functions = require("firebase-functions");
const admin = require("firebase-admin");


admin.initializeApp();

const fcm = admin.messaging();
const db = admin.firestore();


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//

// // exports.test = functions.https.
// // onRequest(async (request, response) => {  const notifications = [];
// });

/** check cronic
 * @param {string} wound
 * @param {string} patientName
 * @return {notification}
 */
function checkCronic(wound, patientName) {
  const timeStamp = wound.startDate;
  const startDate = new Date(1970, 0, 1); // Epoch
  startDate.setSeconds(timeStamp.seconds);
  // date difference
  const diffDays = Math.ceil((Date.now() - startDate) / (1000 * 60 * 60 * 24));
  if (diffDays > 84) {
    return {notification: {
      title: "Wound status changed",
      body: "The wound of patient " + patientName + " has become chronic",
      click_action: "FLUTTER_NOTIFICATION_CLICK"},
    };
  }
}


exports.notificationFunc =
functions.pubsub.schedule("every 24 hours").onRun( async () => {
  const notifications = [];
  const nursingHomes = await db
      .collection("NursingHome")
      .get();
  for (const nursingHome of nursingHomes.docs) {
    const rooms = await db
        .collection("NursingHome")
        .doc(nursingHome.id)
        .collection("Room")
        .get();

    for (const room of rooms.docs) {
      const patients = await db
          .collection("NursingHome")
          .doc(nursingHome.id)
          .collection("Room")
          .doc(room.id)
          .collection("Patient")
          .get();

      for (const patient of patients.docs) {
        const patientRecord = await patient.get("patientFile");
        if (patientRecord != undefined) {
          const wounds = patientRecord.wounds;
          if (wounds != undefined) {
            let counter = 0;
            for (const wound of wounds) {
              if (wound.isHealed == undefined || wound.isHealed) {
                continue;
              }
              if (wound.isChronic == undefined || wound.isChronic) {
                continue;
              }
              const notification =
          checkCronic(wound,
              await patient.get("firstName") +
              " " +
              await patient.get("surname"));
              let roomId = -1;
              try {
                roomId = parseInt(room.id);
              } catch (error) {
                console.log("error parsing room id");
              }

              if (notification != undefined) {
                // create notification in db
                const notificationRef = await db.
                    collection("/NursingHome/" +
                nursingHome.id +
                "/Notifications").
                    add(
                        {
                          patientId: patient.id,
                          woundId: wound.id,
                          status: "toDo",
                          nurseId: "",
                          timeStamp: admin.firestore
                              .FieldValue.serverTimestamp(),
                          description: notification.notification.body,
                          roomId: roomId,
                        }
                    );
                if (notificationRef == undefined) {
                  console.log("Error creating notification in the db");
                  continue;
                }
                // change status to chronic
                wound.isChronic = true;
                patientRecord.wounds[counter] = wound;
                await db
                    .collection("NursingHome")
                    .doc(nursingHome.id)
                    .collection("Room")
                    .doc(room.id)
                    .collection("Patient").doc(patient.id).
                    update({patientFile: patientRecord});
                notifications.push(notification);
              }
              counter++;
            }
          }
        }
      }
    }
  }
  if (notifications.length <= 0) {
    return;
  }
  for (const notification of notifications) {
    await fcm.sendToTopic("chronicWounds", notification);
  }
});
