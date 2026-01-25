import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraOverlayScreen extends StatefulWidget {
  const CameraOverlayScreen({super.key});

  @override
  State<CameraOverlayScreen> createState() => _CameraOverlayScreenState();
}

class _CameraOverlayScreenState extends State<CameraOverlayScreen> {
  CameraController? _controller;
  List<CameraDescription>? cameras;
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras!.first,
      ResolutionPreset.high,
    );
    await _controller!.initialize();
    if (!mounted) return;
    setState(() {
      _isReady = true;
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // CAMERA PREVIEW
          CameraPreview(_controller!),

          // SEMI-TRANSPARENT DARK OVERLAY
          Container(
            color: Colors.black26,
          ),

          // CENTER FRAME OR CROSS
          Center(
            child: Container(
              width: 250,
              height: 180,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.greenAccent,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  '+',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // CAPTURE BUTTON
          Positioned(
            bottom: 50,
            left: MediaQuery.of(context).size.width / 2 - 30,
            child: FloatingActionButton(
              onPressed: () async {
                final image = await _controller!.takePicture();
                Navigator.pop(context, image.path); // return image path
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }
}
