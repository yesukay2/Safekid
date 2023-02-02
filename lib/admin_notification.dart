
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Initialize Firestore and FCM instances
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseMessaging _fcm = FirebaseMessaging.instance;

void checkForNewDataAndSendNotification(String collectionName, String email) {
  // Reference to the collection in Firestore
  CollectionReference collectionRef = _firestore.collection(collectionName);

  // Listen for real-time updates to the collection
  collectionRef.snapshots().listen((snapshot) {
    if (snapshot.docChanges.length > 0) {
      // Iterate through the document changes and check for added documents
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.added) {
          // Send notification to the specific email address
          _fcm.sendMessage(
            to: "yesukay2@gmail.com",
            messageType: "New report submitted!"
          );
        }
      }
    }
  });

}

// sendMessage(
// to: email,
// messageType: Notification(
// title: "New data added",
// body: "New data has been added to the $collectionName collection.",
// ),
// );