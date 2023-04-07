import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { DocumentData, Timestamp, } from "firebase-admin/firestore";

// // Start writing functions
// // https://firebase.google.com/docs/functions/typescript
//
admin.initializeApp();

export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});
exports.checkFirestore = functions.pubsub
    .schedule("every 3 minutes").onRun(async (context) => {
        const db = admin.firestore();
        
        

        // Retrieve the data from Firestore
        const snapshot = await db.collection("users").get();
        snapshot.forEach((doc)=>{
                const userAlarms = doc.data().alarms;
                userAlarms.forEach((time:any)=>{
                    const timeAlert:Timestamp=time.alarm;
                const sent:Boolean=time.sent;
                console.log("-----------------log--------------")
                console.log(timeAlert.valueOf());
                console.log(sent.valueOf());
                check(timeAlert,sent,doc)
                })
        })
                        
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
async function check(alert:Timestamp,sent:Boolean,docs:DocumentData)  {
    const now = new Date();
    const fiveMinutesFromNow = new Date(now.getTime() + 5 * 60 * 1000);
    if (alert.toDate() <= fiveMinutesFromNow && alert.toDate() >= now) {
            // Send a Cloud Messaging notification
            const message = {
                notification: {
                title: "Your notification title",
                body: "Your notification body"
                },
                /* eslint-disable max-len */ 
                token: "fdmhhm_iH1Gm8iboiX5ujd:APA91bGU2aNPxqKhn-fv9yocU5St1BteS0jGCw4MxyS3x6A_g5_ebuaS_pnxSyABROlQIWgfL-5UmlW5xwn-hrDkdX-6vJLi8blA_SkNakTPr59aLHm7Zpjd1-A-U9-5eKVmCeAXo6nz"
                /* eslint-enable max-len */

            };
            
            admin.messaging().send(message).then((response) => {
                console.log("Successfully sent message:", response);
            }).catch((error) => {
                console.log("Error sending message:", error);
            });
            const removeRes=await docs.update({
                
            })

            //  const res=await document.update({})
            }
}