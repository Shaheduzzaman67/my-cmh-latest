import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:my_cmh_updated/common/constants.dart';

/// A generic PDF viewer screen that works across all platforms
/// Supports both file path and URL viewing
class PdfViewerScreen extends StatefulWidget {
  final String? filePath;
  final String? pdfUrl;
  final String title;

  const PdfViewerScreen({
    Key? key,
    this.filePath,
    this.pdfUrl,
    this.title = 'PDF Report',
  }) : super(key: key);

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _validatePdfSource();
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
    if (widget.filePath != null) {
      try {
        final file = File(widget.filePath!);
        if (await file.exists()) {
          await Share.shareXFiles([
            XFile(widget.filePath!),
          ], subject: widget.title);
        }
      } catch (e) {
        _showSnackBar('Failed to share PDF: ${e.toString()}');
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: FONT_NAME,
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          if (widget.filePath != null)
            IconButton(
              icon: Icon(Icons.share),
              onPressed: _sharePdf,
              tooltip: 'Share PDF',
            ),
        ],
      ),
      body: _buildPdfViewer(),
    );
  }

  Widget _buildPdfViewer() {
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red),
            SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: TextStyle(fontSize: 16, fontFamily: FONT_NAME),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Go Back'),
              style: ElevatedButton.styleFrom(backgroundColor: colorAccent),
            ),
          ],
        ),
      );
    }

    // Load from file path
    if (widget.filePath != null) {
      return Stack(
        children: [
          SfPdfViewer.file(
            File(widget.filePath!),
            key: _pdfViewerKey,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _isLoading = false;
              });
            },
            onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              setState(() {
                _isLoading = false;
                _errorMessage = 'Failed to load PDF: ${details.error}';
              });
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
            key: _pdfViewerKey,
            onDocumentLoaded: (PdfDocumentLoadedDetails details) {
              setState(() {
                _isLoading = false;
              });
            },
            onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
              setState(() {
                _isLoading = false;
                _errorMessage = 'Failed to load PDF: ${details.error}';
              });
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
        style: TextStyle(fontSize: 16, fontFamily: FONT_NAME),
      ),
    );
  }
}
