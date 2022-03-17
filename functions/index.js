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
const { firebaseConfig } = require("firebase-functions");
admin.initializeApp();

exports.newsNoti = functions.firestore.document('/news/{docId}')
    .onCreate((snap, context) => {
        const newVal = snap.data()
        const user = newVal.author;
        const title = newVal.title;

        const message = {
            notification: {
                title: `News from ${user}!`,
                body: title,
            },
            topic: "newsNoti",
        }
        
        admin.messaging().send(message)
            .then((response) => {
                console.log("Successfully sent news noti:", response);
                return 1;
            })
            .catch((err) => {
                console.log('Error sending news noti:', err);
                return -1;
            })
    })

exports.chatNoti = functions.https.onCall((data, context) => {

})

exports.friendRequest = functions.https.onCall(async (data, context) => {
    // need to change db to for subscription on msgNoti

    // data contain the message text, 
    // context parameters contain user auth information
    const senderName = data.senderName
    const receiverUid = data.receiverUid

    const result = await admin.firestore()
        .collection('devices')
        .where('uid', "==", receiverUid)
        .get()

    const receiverToken = result.token

    const message = {
        notification: {
            title: "New friend request!",
            body: `${senderName} sent a friend request to you!`
        },
        token: receiverToken
    }

    admin.messaging().send(message)
        .then((res) => {
            console.log('Successfully sent friend request noti: ', res);
        })
        .catch((err) => {
            console.log('Error sending friend request noti:', err);
        })
})

exports.scheduledLeaderboards = functions.pubsub
    .schedule('every 5 minutes')
    .onRun(async (context) => {

        query.orderBy('experience').get().then(querySnapshot => {
            console.log(querySnapshot)
        querySnapshot.forEach(documentSnapshot => {
            console.log(`Found document at ${documentSnapshot.experience}`);
            
        });
        });
        // for (let i = 0; i < results.length; i ++){
        //     let uid = results[i].uid

        //     const tokens = await admin.firestore()
        //         .collection('devices')
        //         .where('uid', "==", uid)
        //         .get()

        //     for (let j = 0; j < results.length; j++){
        //         const token = tokens[i];

        //         message = {
        //         notification: {
        //             title: "Leaderboard Ranking!",
        //             body: `You ranked ${results.length - i} this week!`
        //         },
        //         token: token
        //         }
        //         console.log(message);
        //         console.log(uid);
                
        //         admin.messaging().send(message)
        //         .then((res) => {
        //             console.log('Successfully sent leaderboard noti: ', res);
        //         })
        //         .catch((err) => {
        //             console.log('Error sending leaderboard noti:', err);
        //         })

        //     }   
        // }
    })