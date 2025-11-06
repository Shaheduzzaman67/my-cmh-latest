import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class RadiologyReportViewer extends StatefulWidget {
  final String invoiceNo;
  final String itemNo;

  const RadiologyReportViewer({
    Key? key,
    required this.invoiceNo,
    required this.itemNo,
  }) : super(key: key);

  @override
  State<RadiologyReportViewer> createState() => _RadiologyReportViewerState();
}

class _RadiologyReportViewerState extends State<RadiologyReportViewer> {
  List<int>? pdfBytes;
  bool isLoading = true;
  String? errorMessage;
  final PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  void initState() {
    super.initState();
    fetchPdf();
  }

  Future<void> fetchPdf() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // Make API call
      final url = Uri.parse(
        'https://cmhmobappapi.tilbd.net/api/v1/emr-radiology-report',
      );

      final response = await http.post(
        url,
        headers: {'Accept': '*/*', 'Content-Type': 'application/json'},
        body: jsonEncode({
          'invoiceNo': widget.invoiceNo,
          'itemNo': widget.itemNo,
        }),
      );
      print(url);

      if (response.statusCode == 200) {
        print(response.statusCode);
        setState(() {
          print(response.bodyBytes);
          pdfBytes = response.bodyBytes;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load PDF. Status: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
        isLoading = false;
      });
    }
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
          if (pdfBytes != null) ...[
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
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: fetchPdf,
              tooltip: 'Refresh',
            ),
          ],
        ],
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading PDF...'),
                ],
              ),
            )
          : errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: fetchPdf,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          : pdfBytes != null
          ? SfPdfViewer.memory(
              Uint8List.fromList(pdfBytes!),
              controller: _pdfViewerController,
              canShowScrollHead: true,
              canShowScrollStatus: true,
              enableDoubleTapZooming: true,
              enableTextSelection: true,
              onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                setState(() {
                  errorMessage = 'Failed to load PDF: ${details.error}';
                });
              },
            )
          : const Center(child: Text('No PDF available')),
    );
  }
}
