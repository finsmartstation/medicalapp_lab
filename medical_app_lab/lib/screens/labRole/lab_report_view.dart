import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LabReportPdfView extends StatefulWidget {
  final pdf;
  const LabReportPdfView({super.key, required this.pdf});

  @override
  State<LabReportPdfView> createState() => _LabReportPdfViewState();
}

class _LabReportPdfViewState extends State<LabReportPdfView> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Colors.grey[350],
          appBar: AppBar(
            backgroundColor: Colors.grey[350],
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
               // size: 30,
                 color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Lab report',style: TextStyle(color: Colors.black),),
          ),
        body: SfPdfViewer.network(
          widget.pdf,
          key: _pdfViewerKey,
        ));
  }
}