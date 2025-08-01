![Handsfree Banner](https://github.com/quartet02/handsfree/blob/master/assets/image/banner.png)
# Handsfree 
A new Flutter project that specialize in teaching American Sign Language. This project is aimed to solve 2 [United Nations SDGs](https://developers.google.com/community/gdsc-solution-challenge/UN-goals), namely **Quality Education** and **Reduced Inequalities**. 
In this project, we integrated ML Kit and Firebase(Authentication, Cloud Firestore, Functions, Cloud Messaging, Cloud Storage). There are five main pages, namely **Home**, **Dictionary**, **Learning**, **Social** and **Profile**.  
 [Demonstration video](https://youtu.be/HPf20P4IBVU)

Widget Tree:
<pre>
Handsfree
└── Authenticate
    ├── Sign In
    │   ├── Home
    │   │   └── Quiz (Submit Field)
    │   │   
    │   ├── Dictionary
    │   │   └── Search Bar 
    │   │       └── Translator (Definition and Image of each Sign)
    │   │
    │   ├── Learn (4 Syllabus)
    │   │   └── Learn Page (Branches in each syllabus)
    │   │       └── Sub-Lesson Page (Lessons in each branch)
    │   │           └── Main Learning Page (Tutorial/ Machine Learning Model Assessed Question)
    │   │
    │   ├── Social
    │   │   ├── Chatting System
    │   │   │   ├── Global Friend Search
    │   │   │   ├── Friend Request Page
    │   │   │   └── Available Friends to Chat
    │   │   │       └── Chatting Page
    │   │   │
    │   │   └── News
    │   │       └── Global News Search
    │   │           └── News Overlay
    │   │
    │   └── Profile (Profile Picture, Name, Email, Title, Experience Bar, Level, Leaderboard)
    │       └── Setting Page (Variety of Preference)
    │           ├── Confidential Data Change
    │           ├── Sign Out
    │           ├── Helpdesk
    │           ├── Feedback Form
    │           ├── Terms
    │           └── Acknowledgement 
    │
    └── Sign Up
</pre> 

## Installation
You can either download the testing version from [Google Play Store](https://play.google.com/store/apps/details?id=com.umquartet02.handsfree) or pull this version to you local machine and run it in the android emulator.

## Collaborators
We are first year student from University of Malaya, Malaysia who commit ourselves in Google Solution 2022 and aims to achieve [United Nations SDGs](https://developers.google.com/community/gdsc-solution-challenge/UN-goals) 4 and 10 which are Quality Education and Reduced Inequalities respectively. 

- Nah Wan Jun [(nwjun)](https://github.com/nwjun)
- Ng Gih Ming [(mingng18)](https://github.com/mingng18)
- Kuck Swee Nien [(KuckSN)](https://github.com/KuckSN)
- Lim Wei Xin [(Programmer420-1)](https://github.com/realdavian)

## Future Plan
Next step of our projects is to: <br />
<br />
    1) Expand our syllabus to almost every sign in American Sign Language <br />
&emsp;&emsp;- Increase vocabulary and thus fluency of sign language to users <br />
<br />
    2) Dictionary that offer more variety, which include ASL, BSL and AUSIAN <br />
&emsp;&emsp;- create borderless community <br />
&emsp;&emsp;- global citizenship <br />
<br />
    3) Offline Mode <br />
&emsp;&emsp;- Able to learn sign language even without Internet connection <br />
&emsp;&emsp;- Able to access dictionary to emergency use <br />
<br />
    4) Implement Sign Language Processing <br />
&emsp;&emsp;- Since the grammar of sign language is different from English, we have to use sign language processing in order to arrange the translated words from signs in the order that people can understand. <br />

## Architecture
- Firebase Firestore (NoSQL)
- Firebase Storage
- Google ML Kit
- Flutter (Dart)

## Library Used
- async
- autocomplete_textfield
- camera
- cloud_firestore
- cloud_functions
- confetti
- cupertino_icons
- cupertino_will_pop_scope
- expandable
- file_picker
- firebase_auth
- firebase_core
- firebase_database
- firebase_storage
- firebase_messaging
- flamingo
- flamingo_annotation
- fluttertoast 
- flutter_cube
- flutter_polygon
- flutter_spinkit
- flutter_svg
- flutter_typeahead
- flutter_webrtc
- gallery_saver
- google_fonts
- google_sign_in
- intl
- image_picker
- page_transition
- path_provider
- percent_indicator
- provider
- rxdart
- themed
- shared_preferences
- simple_shadow
- video_player

## Dataset
- [ASL Alphabet by Akash](https://www.kaggle.com/datasets/grassknoted/asl-alphabet)

## Limitation
- The tflite model is trained on 4 alphabets(A, B, C and D) with one epoch only due to hardware limitaion, so the recognition of hand signs might not be very accurate.

## Special Thanks
- **Dr Chan Chee Seng** for giving advices throughout the preparation for the second submission.
- **Google Communities**
- **Kwan Yang** from Universiti Malaya for helping in the early stage of Flutter app development.
