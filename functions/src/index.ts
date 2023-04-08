import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {
  DocumentData,
  DocumentSnapshot,
  FieldValue,
  Firestore,
  Timestamp,
} from "firebase-admin/firestore";
import {} from "firebase/database";
// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
const Alert = class {
  time;
  sent;
  constructor(time: Timestamp, sent: Boolean) {
    this.time = time;
    this.sent = sent;
  }
};
var serviceAccount = require("../capstoneapp-35716-c774083ce44a.json");
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://capstoneapp-35716-default-rtdb.firebaseio.com/",
});

exports.updateRealTimeAlarm = functions.pubsub
  .schedule("every 2 minutes")
  .onRun(async (context) => {
    const db = admin.firestore();

    const now = new Date();
    const realDB = admin.database();

    const fiveMinutesFromNow = new Date(now.getTime() + 5 * 60 * 1000);

    const snapshot = await db
      .collection("users")
      .doc("tanzirh10@gmail.com")
      .get();
    if (typeof snapshot.data() !== "undefined" && snapshot.data() != null) {
      const userAlarms: Array<any> = snapshot.data()!.alarms;
      userAlarms.forEach(async (doc: any) => {
        const alarm: Timestamp = doc.alarmTime;
        const sentToLock: boolean = doc.sentToLock;
        if (!doc.sentToLock) {
          //   if (alarm.toDate() <= fiveMinutesFromNow && alarm.toDate() >= now) {
          //     const ref = realDB.ref("User");
          //     ref.set({ Alarm: 10 });
          //   }
          console.log("-------setting alarm for GPS---------")
          const ref = realDB.ref("User");
          ref.set({ Alarm: 10 });
        }
      });
    }
  });
exports.checkFirestore = functions.pubsub
  .schedule("every 2 minutes")
  .onRun(async (context) => {
    const db = admin.firestore();
    var timestamp: Timestamp;
    var sentBool: Boolean;

    // Retrieve the data from Firestore
    const snapshot = await db.collection("users").get();
    snapshot.forEach((doc) => {
      //shifting through each document

      const userAlarms = doc.data().alarms;
      userAlarms.forEach(async (time: any) => {
        const timeAlert: Timestamp = time.alarm;
        const sent: Boolean = time.sent;
        console.log("-----------------log--------------");
        console.log(timeAlert.valueOf());
        console.log(sent.valueOf());
        const promise = await check(timeAlert, sent);

        if (promise) {
          console.log("---database shit----");
          const Alarm = new Alert(timestamp, sentBool);
          console.log("-----removing-------");
          const removeRes = await doc.ref
            .update({
              alarms: FieldValue.arrayRemove({ alarm: timeAlert, sent: false }),
            })
            .then((data) => {
              console.log(`Document removed at: ${data.writeTime.toDate()}`);
            })
            .catch((err) => {
              console.log("error: " + err);
            });
          console.log("-------writing-----");
          const unionRes = await doc.ref
            .update({
              alarms: FieldValue.arrayUnion({ alarm: timeAlert, sent: true }),
            })
            .then((data) => {
              console.log(`Document written at: ${data.writeTime.toDate()}`);
            })
            .catch((err) => {
              console.log("error: " + err);
            });
        }
      });
    });

    // Loop through the documents
    // snapshot.forEach((doc) => {//link thru users collection
    //     const userAlarms = doc.data().alarms;//get document
    //     userAlarms.forEach((time:any)=>{//go into fields

    //     })
    //     // Check if the timestamp is 5 minutes away from the current local time
    // });

    return null;
  });
/**
 * Checks time in each user alerts to make sure that its within 5 minutes of it running.
 * @param {Timestamp} alert The first number.
 * @param {Boolean} sent The first number.
 */
async function check(alert: Timestamp, sent: Boolean) {
  const now = new Date();
  const fiveMinutesFromNow = new Date(now.getTime() + 5 * 60 * 1000);
  if (alert.toDate() <= fiveMinutesFromNow && alert.toDate() >= now && !sent) {
    // Send a Cloud Messaging notification
    const message = {
      notification: {
        title: "Your notification title",
        body: "Your notification body",
      },
      /* eslint-disable max-len */
      token:
        "fdmhhm_iH1Gm8iboiX5ujd:APA91bGU2aNPxqKhn-fv9yocU5St1BteS0jGCw4MxyS3x6A_g5_ebuaS_pnxSyABROlQIWgfL-5UmlW5xwn-hrDkdX-6vJLi8blA_SkNakTPr59aLHm7Zpjd1-A-U9-5eKVmCeAXo6nz",
      /* eslint-enable max-len */
    };

    admin
      .messaging()
      .send(message)
      .then((response) => {
        console.log("Successfully sent message:", response);
      })
      .catch((error) => {
        console.log("Error sending message:", error);
      });
    return true;

    //  const res=await document.update({})
  } else {
    return false;
  }
}
