const functions = require("firebase-functions");

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

// The Firebase Admin SDK to access Firestore.
const admin = require('firebase-admin');
admin.initializeApp();

exports.newsNoti = functions.firestore.document('/news/{docId}')
    .onCreate((snap, context) => {
        const newVal = snap.data()
        const user = newVal.author;
        const title = newVal.title;

        const message = {
            notification: {
                title: "News from ${user}!",
                body: title,
            },
            topic: "newsNoti",
        }
        getMessaging().send(message)
            .then((response) => {
                console.log("Successfully sent news noti:", response);
            })
            .catch((err) => {
                console.log('Error sending news noti:', err);
            })
    })

exports.friendRequest = functions.https.onCall((data, context) => {
    // data contain the message text, 
    // context parameters contain user auth information

})