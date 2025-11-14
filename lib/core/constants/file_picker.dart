import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:ghorx_mobile_app_new/core/common_widgets/custom_scaffold_meessanger.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_editor_plus/options.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';

class ImagePickerService {
  final ImagePicker _imagePicker = ImagePicker();
  final List<XFile> imageFileList = <XFile>[];
  final List<File> fileList = <File>[];

  /// Pick multiple images from gallery
  Future<void> pickImageFromGallery(BuildContext context) async {
    bool permissionGranted = await requestStoragePermission(context);

    if (permissionGranted) {
      final List<XFile>? images = await _imagePicker.pickMultiImage();
      if (images?.isNotEmpty ?? false) {
        for (final image in images!) {
          File file = File(image.path);
          imageFileList.insert(0, image);
          fileList.insert(0, file); // ✅ Add to fileList too
        }
      }
    } else {
      CustomScaffoldMessenger.showSuccessMessage(
        context,
        "Please allow access to the gallery.",
      );
    }
  }

  Future<void> pickSingleImageFromGallery(BuildContext context) async {
    bool permissionGranted = await requestStoragePermission(context);

    if (permissionGranted) {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
      if (image != null) {
        File file = File(image.path);

        // ✅ Open image editor
        final editedImage = await Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => ImageEditor(
                  image: file.readAsBytesSync(),
                  blurOption: null,
                  brushOption: null,
                  emojiOption: null,
                  filtersOption: null,
                  flipOption: null,
                  textOption: null,
                  cropOption: const CropOption(),
                  rotateOption: const RotateOption(),
                ),
          ),
        );

        if (editedImage != null) {
          // ✅ Save edited image
          final File editedFile = await File(
            image.path,
          ).writeAsBytes(editedImage);

          imageFileList
            ..clear()
            ..add(image);
          fileList
            ..clear()
            ..add(editedFile);
        }
      }
    }
  }

  // Future<void> pickProfileImageFromCamera(BuildContext context) async {
  //   bool permissionGranted = await requestStoragePermission(context);

  //   if (permissionGranted) {
  //     final XFile? image = await _imagePicker.pickImage(
  //       source: ImageSource.camera,
  //     );

  //     if (image != null) {
  //       File file = File(image.path);

  //       // ✅ Open image editor (same as gallery)
  //       final editedImage = await Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder:
  //               (context) => ImageEditor(
  //                 image: file.readAsBytesSync(),
  //                 blurOption: null,
  //                 brushOption: null,
  //                 emojiOption: null,
  //                 filtersOption: null,
  //                 flipOption: null,
  //                 textOption: null,
  //                 cropOption: CropOption(),
  //                 rotateOption: const RotateOption(),
  //               ),
  //         ),
  //       );

  //       if (editedImage != null) {
  //         Directory tempDir = await getApplicationDocumentsDirectory();
  //         String newPath =
  //             "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
  //         File newFile = await File(newPath).writeAsBytes(editedImage);

  //         imageFileList
  //           ..clear()
  //           ..add(XFile(newFile.path));
  //         fileList
  //           ..clear()
  //           ..add(newFile);
  //       }
  //     } else {
  //       CustomScaffoldMessenger.showErrorMessage(
  //         context,
  //         "Please capture an image.",
  //       );
  //     }
  //   }
  // }
  Future<void> picksingleImageFromCamera(BuildContext context) async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (image == null) {
      CustomScaffoldMessenger.showErrorMessage(
        context,
        "Please capture an image.",
      );
      return;
    }

    final File file = File(image.path);
    final bytes = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final img = frame.image;

    // Crop square from center
    final size = img.width < img.height ? img.width : img.height;
    final x = (img.width - size) ~/ 2;
    final y = (img.height - size) ~/ 2;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint();

    canvas.drawImageRect(
      img,
      Rect.fromLTWH(
        x.toDouble(),
        y.toDouble(),
        size.toDouble(),
        size.toDouble(),
      ),
      Rect.fromLTWH(0, 0, size.toDouble(), size.toDouble()),
      paint,
    );

    final croppedImage = await recorder.endRecording().toImage(size, size);
    final byteData = await croppedImage.toByteData(
      format: ui.ImageByteFormat.png,
    );

    Directory tempDir = await getApplicationDocumentsDirectory();
    String newPath =
        "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png";
    final newFile = await File(
      newPath,
    ).writeAsBytes(byteData!.buffer.asUint8List());

    imageFileList.insert(0, XFile(newFile.path));
    fileList.insert(0, newFile);
  }

  /// Pick an image from the camera
  Future<void> pickImageFromCamera(BuildContext context) async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      Directory tempDir = await getApplicationDocumentsDirectory();
      String newPath =
          "${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
      File newFile = await File(image.path).copy(newPath);

      imageFileList.insert(0, XFile(newFile.path));
      fileList.insert(0, newFile);
    } else {
      CustomScaffoldMessenger.showSuccessMessage(
        context,
        "Please capture an image.",
      );
    }
  }

  /// Handle permission requests for storage or photos
  Future<bool> requestStoragePermission(BuildContext context) async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      if (sdkInt >= 33) {
        // Android 13+ system picker (no permission required)
        return true;
      } else if (sdkInt >= 30) {
        var status = await Permission.manageExternalStorage.status;
        if (status.isGranted) return true;

        if (status.isDenied) {
          status = await Permission.manageExternalStorage.request();
          return status.isGranted;
        }

        if (status.isPermanentlyDenied) {
          CustomScaffoldMessenger.showSuccessMessage(
            context,

            "Please enable storage access in settings.",
          );
          await openAppSettings();
          return false;
        }
      } else {
        var status = await Permission.storage.status;
        if (status.isGranted) return true;

        if (status.isDenied) {
          status = await Permission.storage.request();
          return status.isGranted;
        }

        if (status.isPermanentlyDenied) {
          CustomScaffoldMessenger.showSuccessMessage(
            context,

            "Please enable storage access in settings.",
          );
          await openAppSettings();
          return false;
        }
      }

      CustomScaffoldMessenger.showSuccessMessage(
        context,

        "Storage access is required.",
      );
      return false;
    }

    if (Platform.isIOS) {
      var status = await Permission.photos.status;

      if (status.isGranted || status.isLimited) {
        return true;
      }

      if (status.isDenied) {
        status = await Permission.photos.request();
        if (status.isGranted || status.isLimited) {
          return true;
        }
        return false;
      }

      if (status.isPermanentlyDenied || status.isRestricted) {
        CustomScaffoldMessenger.showSuccessMessage(
          context,

          "Please enable photo access in settings.",
        );
        await openAppSettings();
        return false;
      }

      CustomScaffoldMessenger.showSuccessMessage(
        context,

        "Photo access is required.",
      );
      return false;
    }

    return false;
  }

  /// Pick files (e.g. PDFs, docs, etc.)
  Future<void> pickFile(BuildContext context) async {
    if (Platform.isIOS || Platform.isAndroid) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx'],
      );

      if (result != null && result.files.isNotEmpty) {
        String? filePath = result.files.single.path;
        if (filePath != null) {
          File file = File(filePath);
          fileList.insert(0, file);
        } else {
          CustomScaffoldMessenger.showSuccessMessage(
            context,

            "File path is null.",
          );
        }
      }
    }
  }
}
