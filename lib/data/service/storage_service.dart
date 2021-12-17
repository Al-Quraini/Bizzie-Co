import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';

import 'authentication_service.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(File file, {String folder = ''}) async {
    String imageName = 'userImages${DateTime.now().millisecondsSinceEpoch}.'
        '${_mimeType(file)}';

    //Upload to Firebase
    try {
      Reference ref =
          _storage.ref().child('${AuthenticationService().getUser()!.uid}/'
              '$folder'
              '$imageName');

      UploadTask task = ref.putFile(file);
      TaskSnapshot snapshot = await task.whenComplete(() => task.snapshot);

      String downloadUrl = await snapshot.ref.getDownloadURL();

      // print(downloadUrl);
      return downloadUrl;
    } catch (e) {
      return null;
    }
  }

  String _mimeType(File file) {
    String mimeT = mime(file.path)!;
    List<String> pathString = (mimeT).split('/');
    String mimeType = pathString[pathString.length - 1];

    return mimeType;
  }
}
