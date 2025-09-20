import 'package:birthday_reminder/helper/common_import.dart';
import 'package:flutter/material.dart' as material;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

Future<void> generatePdfWithImageAndGreeting(String imagePath, String greetings, PdfColor color, String fontFamily, BuildContext context) async {
  showLoadingDialog(context);
  final pdf = pw.Document();
  final exampleImage = await getExampleImage(imagePath);
  final font = await loadFont(fontFamily);
  // First page with the image
  pdf.addPage(
    pw.Page(build: (context) {
      return pw.Padding(
        padding: const pw.EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5), // Add padding around the image
        child: pw.Container(
          decoration: pw.BoxDecoration(
            borderRadius: pw.BorderRadius.circular(20),
            image: pw.DecorationImage(
              image: pw.MemoryImage(exampleImage),
              fit: pw.BoxFit.fill,
            ),
          ),
        ),
      );
    }),
  );

  // Second page with the greeting message
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Container(
            height: 300,
            alignment: pw.Alignment.center,
            decoration: pw.BoxDecoration(
              color: color,
              borderRadius: pw.BorderRadius.circular(20),
            ), // Set container color
            child: pw.Text(
              greetings,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                font: font,
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        );
      },
    ),
  );

  // Save the PDF to a file
  DateTime now = DateTime.now();
/*  final file = File("/storage/emulated/0/Download/${now.month}_${now.day}_${now.hour}_${now.minute}.pdf");
  await file.writeAsBytes(await pdf.save());*/

  Directory tempDir = await getTemporaryDirectory();
  String filePath = '${tempDir.path}/${now.month}_${now.day}_${now.hour}_${now.minute}_${now.second}.pdf';

  // Save the PDF file
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());
  material.debugPrint('PDF saved at ${file.path}');
  Get.back();
  if (isTab(context)) {
    await Share.shareXFiles(
      [XFile(file.path)],
      text: 'Here is your PDF file!',
      sharePositionOrigin: Rect.fromLTWH(
        0,
        0,
        MediaQuery.sizeOf(context).width,
        MediaQuery.sizeOf(context).height / 2,
      ),
    );
  } else {
    Share.shareXFiles([XFile(file.path)], text: 'Here is your PDF file!');
  }
}

Future<Uint8List> getExampleImage(String imagePath) async {
  try {
    final bytes = await rootBundle.load(imagePath);
    return bytes.buffer.asUint8List();
  } catch (e) {
    throw Exception("Failed to load asset: $e");
  }
}

Future<pw.Font> loadFont(String fontFamily) async {
  final fontData = await rootBundle.load(fontFamily);
  final font = pw.Font.ttf(fontData);
  return font;
}

/// for the greetings only

Future<void> generatePdfWithGreeting(String name, String greetings, PdfColor color, String fontFamily, BuildContext context) async {
  showLoadingDialog(context);
  final pdf = pw.Document();
  final font = await loadFont(fontFamily);
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Container(
            height: 280,
            alignment: pw.Alignment.center,
            padding: const pw.EdgeInsets.all(15),
            decoration: pw.BoxDecoration(
              color: color,
              borderRadius: pw.BorderRadius.circular(20),
            ), // Set container color
            child: pw.Text(
              greetings,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                font: font,
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
        );
      },
    ),
  );

  // Save the PDF to a file
  DateTime now = DateTime.now();
/*  final file = File("/storage/emulated/0/Download/${now.month}_${now.day}_${now.hour}_${now.minute}.pdf");
  await file.writeAsBytes(await pdf.save());*/

  Directory tempDir = await getTemporaryDirectory();
  String filePath = '${tempDir.path}/$name\'s_card${now.month}-${now.day}(${now.hour}:${now.minute}:${now.second}).pdf';

  // Save the PDF file
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());
  material.debugPrint('PDF saved at ${file.path}');
  Get.back();
  if (isTab(context)) {
    Share.shareXFiles(
      [XFile(file.path)],
      text: 'Here is your PDF file!',
      sharePositionOrigin: Rect.fromLTWH(
        0,
        0,
        MediaQuery.sizeOf(context).width,
        MediaQuery.sizeOf(context).height / 2,
      ),
    );
  } else {
    Share.shareXFiles([XFile(file.path)], text: 'Here is your PDF file!');
  }
}
