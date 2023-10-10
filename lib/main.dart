// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// void main(List<String> args) {
//   runApp(Example());
// }
//
// class Example extends StatelessWidget {
//   const Example({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       color: Colors.white,
//       debugShowCheckedModeBanner: false,
//       home: VideoPlayersList(),
//     );
//   }
// }
//
// class VideoPlayersList extends StatelessWidget {
//   const VideoPlayersList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     List<String> paths = [
//       "https://player.vimeo.com/external/438144831.sd.mp4?s=c76014f62762554ad378904af31eb64a6c36b0ac&profile_id=164&oauth2_token_id=57447761",
//       "https://player.vimeo.com/external/438144831.sd.mp4?s=c76014f62762554ad378904af31eb64a6c36b0ac&profile_id=164&oauth2_token_id=57447761",
//       "https://player.vimeo.com/external/438144831.sd.mp4?s=c76014f62762554ad378904af31eb64a6c36b0ac&profile_id=164&oauth2_token_id=57447761",
//       "https://player.vimeo.com/external/438144831.sd.mp4?s=c76014f62762554ad378904af31eb64a6c36b0ac&profile_id=164&oauth2_token_id=57447761",
//       "https://player.vimeo.com/external/438144831.sd.mp4?s=c76014f62762554ad378904af31eb64a6c36b0ac&profile_id=164&oauth2_token_id=57447761",
//     ];
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(children: [
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const BouncingScrollPhysics(),
//             itemCount: paths.length,
//             itemBuilder: (BuildContext context, int index) {
//               return VideoPlay(
//                 pathh: paths[index],
//               );
//             },
//           ),
//         ]),
//       ),
//     );
//   }
// }
//
// class VideoPlay extends StatefulWidget {
//   String? pathh;
//
//   @override
//   _VideoPlayState createState() => _VideoPlayState();
//
//   VideoPlay({
//     Key? key,
//     this.pathh, // Video from assets folder
//   }) : super(key: key);
// }
//
// class _VideoPlayState extends State<VideoPlay> {
//   ValueNotifier<VideoPlayerValue?> currentPosition = ValueNotifier(null);
//   VideoPlayerController? controller;
//   late Future<void> futureController;
//
//   initVideo() {
//     controller = VideoPlayerController.network(widget.pathh!);
//
//     futureController = controller!.initialize();
//   }
//
//   @override
//   void initState() {
//     initVideo();
//     controller!.addListener(() {
//       if (controller!.value.isInitialized) {
//         currentPosition.value = controller!.value;
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     controller!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: futureController,
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const CircularProgressIndicator.adaptive();
//         } else {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: SizedBox(
//               height: controller!.value.size.height,
//               width: double.infinity,
//               child: AspectRatio(
//                   aspectRatio: controller!.value.aspectRatio,
//                   child: Stack(children: [
//                     Positioned.fill(
//                         child: Container(
//                             foregroundDecoration: BoxDecoration(
//                               gradient: LinearGradient(
//                                   colors: [
//                                     Colors.black.withOpacity(.7),
//                                     Colors.transparent
//                                   ],
//                                   stops: [
//                                     0,
//                                     .3
//                                   ],
//                                   begin: Alignment.bottomCenter,
//                                   end: Alignment.topCenter),
//                             ),
//                             child: VideoPlayer(controller!))),
//                     Positioned.fill(
//                       child: Column(
//                         children: [
//                           Expanded(
//                             flex: 8,
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   flex: 3,
//                                   child: GestureDetector(
//                                     onDoubleTap: () async {
//                                       Duration? position =
//                                       await controller!.position;
//                                       setState(() {
//                                         controller!.seekTo(Duration(
//                                             seconds: position!.inSeconds - 10));
//                                       });
//                                     },
//                                     child: const Icon(
//                                       Icons.fast_rewind_rounded,
//                                       color: Colors.black,
//                                       size: 40,
//                                     ),
//                                   ),
//                                 ),
//                                 Expanded(
//                                     flex: 4,
//                                     child: IconButton(
//                                       icon: Icon(
//                                         controller!.value.isPlaying
//                                             ? Icons.pause
//                                             : Icons.play_arrow,
//                                         color: Colors.black,
//                                         size: 40,
//                                       ),
//                                       onPressed: () {
//                                         setState(() {
//                                           if (controller!.value.isPlaying) {
//                                             controller!.pause();
//                                           } else {
//                                             controller!.play();
//                                           }
//                                         });
//                                       },
//                                     )),
//                                 Expanded(
//                                   flex: 3,
//                                   child: GestureDetector(
//                                     onDoubleTap: () async {
//                                       Duration? position =
//                                       await controller!.position;
//                                       setState(() {
//                                         controller!.seekTo(Duration(
//                                             seconds: position!.inSeconds + 10));
//                                       });
//                                     },
//                                     child: const Icon(
//                                       Icons.fast_forward_rounded,
//                                       color: Colors.black,
//                                       size: 40,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Expanded(
//                               flex: 2,
//                               child: Align(
//                                 alignment: Alignment.bottomCenter,
//                                 child: ValueListenableBuilder(
//                                     valueListenable: currentPosition,
//                                     builder: (context,
//                                         VideoPlayerValue? videoPlayerValue, w) {
//                                       return Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 20, vertical: 10),
//                                         child: Row(
//                                           children: [
//                                             Text(
//                                               videoPlayerValue!.position
//                                                   .toString()
//                                                   .substring(
//                                                   videoPlayerValue.position
//                                                       .toString()
//                                                       .indexOf(':') +
//                                                       1,
//                                                   videoPlayerValue.position
//                                                       .toString()
//                                                       .indexOf('.')),
//                                               style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 22),
//                                             ),
//                                             const Spacer(),
//                                             Text(
//                                               videoPlayerValue.duration
//                                                   .toString()
//                                                   .substring(
//                                                   videoPlayerValue.duration
//                                                       .toString()
//                                                       .indexOf(':') +
//                                                       1,
//                                                   videoPlayerValue.duration
//                                                       .toString()
//                                                       .indexOf('.')),
//                                               style: const TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 22),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     }),
//                               ))
//                         ],
//                       ),
//                     ),
//                   ])),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
void main(){
  runApp(A());
}
class A extends StatelessWidget {
  const A({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: H(),
    );
  }
}
class H extends StatefulWidget {
  const H({super.key});

  @override
  State<H> createState() => _HState();
}
//bool _ist = true;
bool val1 = false;
String value = "";
List<String> val = [
  "Acet",
  "Acoe",
  "Adtp"
];
class _HState extends State<H> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SwitchListTile(value: val1, onChanged: (va){
              setState(() {
                val1 = va;
              });
            }),
            Center(
              child: (val1==true)?
                  Container(
                    height: 700,
                    width: 500,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage("assets/ons.jpg"),
                      ),


                    ),
                  ): Container(
                height: 700,
                width: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(image:
                    NetworkImage("assets/off.jpg"),
                    )
                ),
              )
              //Image(image: NetworkImage("https://cdn.pixabay.com/photo/2013/07/12/14/34/filament-148482_640.png")):Image(image: NetworkImage("https://cdn.pixabay.com/photo/2013/07/12/14/34/light-148483_640.png"))
            ),
          ],
        ),
      )

    );
  }
}

