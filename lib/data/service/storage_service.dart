import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
// import 'package:mime_type/mime_type.dart';

import 'authentication_service.dart';

class StorageService {
  final _storage = FirebaseStorage.instance;

  Future<String?> uploadImage(File file, {String path = ''}) async {
    String fullPath = '${AuthenticationService().getUser()!.uid}/$path';

    //Upload to Firebase
    try {
      Reference ref = _storage.ref().child(fullPath);

      UploadTask task = ref.putFile(
        file,
      );

      // TaskSnapshot snapshot =
      await task.whenComplete(() {});

      // String downloadUrl = await snapshot.ref.getDownloadURL();

      // print(downloadUrl);
      // return downloadUrl;f
      return fullPath;
    } catch (e) {
      return null;
    }
  }

  Future<String?> getImageUrl(String? path) async {
    log('loading loading loading');
    if (path == null) return null;
    try {
      Reference ref = _storage.ref().child(path);

      String url = await ref.getDownloadURL();
      return url;
    } catch (error) {
      return null;
    }
  }

  // this method returns the mime type of the file
/*   String _mimeType(File file) {
    String mimeT = mime(file.path)!;
    List<String> pathString = (mimeT).split('/');
    String mimeType = pathString[pathString.length - 1];

    return mimeType;
  } */

}
