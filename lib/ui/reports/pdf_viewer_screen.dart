import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:my_cmh_updated/common/constants.dart';

/// A generic PDF viewer screen that works across all platforms
/// Supports both file path and URL viewing with enhanced error handling
class PdfViewerScreen extends StatefulWidget {
  final String? filePath;
  final String? pdfUrl;
  final String title;

  const PdfViewerScreen({
    Key? key,
    this.filePath,
    this.pdfUrl,
    this.title = 'PDF Report',
  }) : assert(
         filePath != null || pdfUrl != null,
         'Either filePath or pdfUrl must be provided',
       ),
       super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _validatePdfSource();
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  void _validatePdfSource() {
    if (widget.filePath != null) {
      final file = File(widget.filePath!);
      if (!file.existsSync()) {
        setState(() {
          _errorMessage = 'PDF file not found';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sharePdf() async {
    if (widget.filePath == null) {
      _showSnackBar('Cannot share: No file path available');
      return;
    }

    try {
      final file = File(widget.filePath!);
      if (await file.exists()) {
        await Share.shareXFiles([
          XFile(widget.filePath!),
        ], subject: widget.title);
      } else {
        _showSnackBar('Cannot share: File does not exist');
      }
    } catch (e) {
      _showSnackBar('Failed to share PDF: ${e.toString()}');
    }
  }

  void _showSnackBar(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontFamily: FONT_NAME,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          if (widget.filePath != null)
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _sharePdf,
              tooltip: 'Share PDF',
            ),
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: () {
              _pdfViewerController.zoomLevel += 0.25;
            },
            tooltip: 'Zoom In',
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: () {
              _pdfViewerController.zoomLevel -= 0.25;
            },
            tooltip: 'Zoom Out',
          ),
        ],
      ),
      body: _buildPdfViewer(),
    );
  }

  Widget _buildPdfViewer() {
    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(fontSize: 16, fontFamily: FONT_NAME),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(backgroundColor: colorAccent),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      );
    }

    // Load from file path
    if (widget.filePath != null) {
      return Stack(
        children: [
          SfPdfViewer.file(
            File(widget.filePath!),
            controller: _pdfViewerController,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            enableDoubleTapZooming: true,
            enableTextSelection: true,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            },
            onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                  _errorMessage = 'Failed to load PDF: ${details.error}';
                });
              }
            },
          ),
          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.8),
              child: Center(
                child: CircularProgressIndicator(color: colorAccent),
              ),
            ),
        ],
      );
    }

    // Load from URL
    if (widget.pdfUrl != null) {
      return Stack(
        children: [
          SfPdfViewer.network(
            widget.pdfUrl!,
            controller: _pdfViewerController,
            canShowScrollHead: true,
            canShowScrollStatus: true,
            enableDoubleTapZooming: true,
            enableTextSelection: true,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            },
            onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                  _errorMessage = 'Failed to load PDF: ${details.error}';
                });
              }
            },
          ),
          if (_isLoading)
            Container(
              color: Colors.white.withOpacity(0.8),
              child: Center(
                child: CircularProgressIndicator(color: colorAccent),
              ),
            ),
        ],
      );
    }

    return Center(
      child: Text(
        'No PDF source provided',
        style: const TextStyle(fontSize: 16, fontFamily: FONT_NAME),
      ),
    );
  }
}
