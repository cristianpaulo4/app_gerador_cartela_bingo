import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatefulWidget {
  final String path;
  final Uint8List bytes;

  PdfPreviewScreen({this.path, this.bytes});

  @override
  _PdfPreviewScreenState createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        title: Text('Cartelas'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              await Printing.sharePdf(
                  bytes: widget.bytes, filename: 'cartelas.pdf');
            },
          )
        ],
      ),
      path: widget.path,
    );
  }
}
