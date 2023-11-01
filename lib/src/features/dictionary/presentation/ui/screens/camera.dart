import 'package:diccon_evo/src/features/features.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  List<CameraDescription>? cameras;
  Future<void> setupCameras() async{
    cameras = await availableCameras();
  }
  CameraController? cameraController;
  @override
  void initState(){
    super.initState();
    setupCameras().then((_) {
      if(cameras!.isNotEmpty){
        cameraController = CameraController(cameras![0],  ResolutionPreset.medium);
        cameraController?.initialize().then((_) {
          if(!mounted){
            return;
          }
          setState(() {});
        });
      }
    });
  }
  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if (cameraController == null || !cameraController!.value.isInitialized){
      return const Center(child: CircularProgressIndicator(),);
    }
    return  SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            CameraPreview(cameraController!),
            const Header(title: "",)
          ],
        ),
      ),
    );
  }
}
