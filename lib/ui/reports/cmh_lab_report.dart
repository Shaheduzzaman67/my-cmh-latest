import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_cmh_updated/controller/app_controller.dart';

import 'package:my_cmh_updated/controller/reports_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CmhLabReportViewer extends StatefulWidget {
  const CmhLabReportViewer({Key? key}) : super(key: key);

  @override
  State<CmhLabReportViewer> createState() => _CmhLabReportViewerState();
}

class _CmhLabReportViewerState extends State<CmhLabReportViewer> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  late final ReportsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = GetControllers.shared.getReportsController();
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radiology Report'),
        actions: [
          Obx(() {
            if (_controller.pdfBytes.value != null) {
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.zoom_in),
                    onPressed: () {
                      _pdfViewerController.zoomLevel =
                          _pdfViewerController.zoomLevel + 0.25;
                    },
                    tooltip: 'Zoom In',
                  ),
                  IconButton(
                    icon: const Icon(Icons.zoom_out),
                    onPressed: () {
                      _pdfViewerController.zoomLevel =
                          _pdfViewerController.zoomLevel - 0.25;
                    },
                    tooltip: 'Zoom Out',
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading PDF...'),
              ],
            ),
          );
        }

        if (_controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    _controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        }

        if (_controller.pdfBytes.value != null) {
          return SfPdfViewer.memory(
            _controller.pdfBytes.value!,
            controller: _pdfViewerController,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            enableDoubleTapZooming: true,
            enableTextSelection: true,
            onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              _controller.errorMessage.value =
                  'Failed to load PDF: ${details.error}';
            },
          );
        }

        return const Center(child: Text('No PDF available'));
      }),
    );
  }
}
