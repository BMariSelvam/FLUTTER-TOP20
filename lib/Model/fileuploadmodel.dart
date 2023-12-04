import 'dart:io';

class FileUploadModel {
  File file;
  String? fileName;
  String keyName;
  String? serverFilePath;
  String? imgId;
  FileUploadModel({required this.file, this.fileName, required this.keyName});
}
