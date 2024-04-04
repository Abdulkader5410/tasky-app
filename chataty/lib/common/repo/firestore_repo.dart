import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreRepoProvider =
    Provider((ref) => FireStoreRepo(storage: FirebaseStorage.instance));

class FireStoreRepo {
  final FirebaseStorage storage;

  FireStoreRepo({required this.storage});

  storeFileToFirestore(String ref, var file) async {
    UploadTask? task;
    task = storage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await task;
    String imageUrl = await snapshot.ref.getDownloadURL();
    return imageUrl;
  }
}