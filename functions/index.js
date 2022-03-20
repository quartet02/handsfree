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

exports.chatNoti = functions.https.onCall(async (data, context) => {
    const senderName = data.name
    const senderUid = context.auth.uid
    const roomId = data.roomId

    chat = await admin.firestore()
        .collection('chatRoom')
        .doc(roomId)
        .get()

    uidTokenMap = {}

    participants = chat.get('participants')
    createdBy = chat.get('createdBy')

    admin.firestore()
        .collection('devices')
        .get().then(snap => {
            console.log('Adding uid and token to map')
            snap.forEach(docSnap => {
                token = docSnap.get('token')
                uid = docSnap.get('uid')

                uidTokenMap[uid] = uidTokenMap[uid] || [];
                uidTokenMap[uid].push(token)
            })
        }).then(e => {
            console.log(`sending chat noti`)
            Object.keys(uidTokenMap).forEach(key => {
                if (key != senderUid) {

                    uidTokenMap[key].forEach(token => {
                        const message = {
                            notification: {
                                title: "New chat!",
                                body: `${senderName} sent a message to you!`,
                            },
                            android: {
                                notification: {
                                    title: "New chat!",
                                    body: `${senderName} sent a message to you!`,
                                    sound: 'default',
                                }
                            },
                            token: token,

                        }

                        admin.messaging().send(message)
                            .then((res) => {
                                console.log('Successfully sent chat noti: ', res);
                            })
                            .catch((err) => {
                                console.log('Error sending chat noti:', err);
                            })
                    })


                }
            })
        })


})

exports.friendRequest = functions.https.onCall(async (data, context) => {
    // need to change db to for subscription on msgNoti

    // data contain the message text, 
    // context parameters contain user auth information
    const senderName = data.name
    const receiverUid = data.receiverUid

    await admin.firestore()
        .collection('devices')
        .where('uid', "==", receiverUid)
        .get().then(snap => {
            snap.forEach(docSnap => {
                tokenDb = docSnap.get('token')
                message = {
                    notification: {
                        title: "New friend request!",
                        body: `${senderName} sent a friend request to you!`
                    },
                    token: tokenDb
                }

                admin.messaging().send(message)
                    .then((res) => {
                        console.log('Successfully sent friend request noti: ', res);
                    })
                    .catch((err) => {
                        console.log('Error sending friend request noti:', err);
                    })
            })
        })
})

exports.scheduledLeaderboards = functions.pubsub.schedule('every sunday 08:00')
    .onRun(async (context) => {
        uidTokenMap = {}
        admin.firestore()
            .collection('devices')
            .get()
            .then(snap => {
                snap.forEach(docSnap => {
                    console.log('Adding uid and token to map')
                    token = docSnap.get('token')
                    uid = docSnap.get('uid')

                    console.log(`adding token: ${token}, uid: ${uid} to map`)

                    uidTokenMap[uid] = uidTokenMap[uid] || [];
                    uidTokenMap[uid].push(token)
                })
            }).then(e => {
                console.log('Sending notification')
                admin.firestore()
                    .collection('users')
                    .orderBy('experience').get()
                    .then(querySnapshot => {
                        let total = querySnapshot.docs.length
                        let i = -1
                        querySnapshot.forEach(documentSnapshot => {
                            i++
                            if (!uidTokenMap.hasOwnProperty(documentSnapshot.get('uid'))) return
                            uidTokenMap[documentSnapshot.get('uid')].forEach(token => {
                                message = {
                                    notification: {
                                        title: "Leaderboard Ranking!",
                                        body: `You ranked ${total - i} this week!`
                                    },
                                    token: token
                                }
                                console.log(`uid: ${uid} message: ${message}`)
                                admin.messaging().send(message)
                                    .then((res) => {
                                        console.log('Successfully sent leaderboard noti: ', res);
                                    })
                                    .catch((err) => {
                                        console.log('Error sending leaderboard noti:', err);
                                    })
                            })
                        });
                    });
            })
    })

// 1 of month
exports.scheduledCleanDevices = functions.pubsub.schedule('every 5 minutes')
    .onRun(async (context) => {
        admin.firestore()
            .collection('devices')
            .get()
            .then(snap => {
                snap.forEach(docSnap => {
                    timestamp = docSnap.get('timestamp')
                    console.log(`timestamp for ${docSnap.get('uid')}: ${timestamp.valueOf()}`)
                    console.log(`cur: ${admin.firestore.Timestamp.now().valueOf()}`)
                })
            })
    })
