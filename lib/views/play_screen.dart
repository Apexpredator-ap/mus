// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import '../controllers/player_controller.dart';
//
// class PlayScreen extends StatelessWidget {
//   final SongModel song;
//
//   const PlayScreen({Key? key, required this.song}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final PlayerController playerController = Get.find();
//
//     return Scaffold(
//       backgroundColor: Colors.blueGrey.shade900,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Now Playing',
//           style: GoogleFonts.jost(
//             color: Colors.white,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           // Large Artwork
//           Center(
//             child: Container(
//               width: 300,
//               height: 300,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.5),
//                     blurRadius: 20,
//                     spreadRadius: 5,
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: QueryArtworkWidget(
//                   id: song.id,
//                   type: ArtworkType.AUDIO,
//                   artworkWidth: 300,
//                   artworkHeight: 300,
//                   artworkFit: BoxFit.cover,
//                   nullArtworkWidget: Image.asset(
//                     'assets/images/music_back.jpg',
//                     width: 300,
//                     height: 300,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 30),
//
//           // Song Info
//           Text(
//             song.title,
//             style: GoogleFonts.jost(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             song.artist ?? 'Unknown Artist',
//             style: GoogleFonts.jost(
//               color: Colors.white70,
//               fontSize: 16,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//
//           const SizedBox(height: 30),
//
//           // Playback Progress
//           Obx(() {
//             final current = playerController.currentPlaybackPosition.value;
//             final total = playerController.totalDuration.value;
//             final progress = total > 0 ? current / total : 0.0;
//
//             return Column(
//               children: [
//                 Obx(() {
//                   final currentPosition = playerController.currentPlaybackPosition.value;
//                   final totalDuration = playerController.totalDuration.value;
//                   return Slider(
//                     min: 0,
//                     max: totalDuration,
//                     value: currentPosition,
//                     onChanged: (value) {
//                       // Ensure value is within the valid range and call the seek method
//                       playerController.seekToPosition(value);
//                     },
//                   );
//                 }),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         _formatDuration(Duration(milliseconds: current.toInt())),
//                         style: const TextStyle(color: Colors.white70),
//                       ),
//                       Text(
//                         _formatDuration(Duration(milliseconds: total.toInt())),
//                         style: const TextStyle(color: Colors.white70),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           }),
//
//           const SizedBox(height: 30),
//
//           // Playback Controls
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: const Icon(Icons.skip_previous, color: Colors.white, size: 40),
//                 onPressed: () {
//                   playerController.playPreviousSong();
//                 },
//               ),
//               const SizedBox(width: 20),
//               Obx(() => IconButton(
//                 icon: Icon(
//                   playerController.isPlaying.value
//                       ? Icons.pause_circle_filled
//                       : Icons.play_circle_filled,
//                   color: Colors.white,
//                   size: 70,
//                 ),
//                 onPressed: () {
//                   playerController.togglePlayPause();
//                 },
//               )),
//               const SizedBox(width: 20),
//               IconButton(
//                 icon: const Icon(Icons.skip_next, color: Colors.white, size: 40),
//                 onPressed: () {
//                   playerController.playNextSong();
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Helper method to format duration
//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }
// }
//
//
//



/// new code with animation for next song
///
///
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:on_audio_query/on_audio_query.dart';
// import '../controllers/player_controller.dart';
//
// class PlayScreen extends StatefulWidget {
//   final SongModel song;
//
//   const PlayScreen({Key? key, required this.song}) : super(key: key);
//
//   @override
//   _PlayScreenState createState() => _PlayScreenState();
// }
//
// class _PlayScreenState extends State<PlayScreen> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<Offset> _slideAnimation;
//   late Animation<double> _fadeAnimation;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeAnimations();
//   }
//
//   // Initialize animations
//   void _initializeAnimations() {
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//
//     _slideAnimation = Tween<Offset>(
//       begin: const Offset(1.0, 0.0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeOutQuad,
//     ));
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _animationController,
//         curve: Curves.easeIn,
//       ),
//     );
//
//     _animationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final PlayerController playerController = Get.find();
//
//     return Scaffold(
//       backgroundColor: Colors.blueGrey.shade900,
//       appBar: _buildAppBar(),
//       body: SlideTransition(
//         position: _slideAnimation,
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: Obx(() {
//             final currentSong = playerController.currentSong.value!;
//
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 _buildArtwork(currentSong),
//                 const SizedBox(height: 30),
//                 _buildSongInfo(currentSong),
//                 const SizedBox(height: 30),
//                 _buildPlaybackProgress(playerController),
//                 const SizedBox(height: 30),
//                 _buildPlaybackControls(playerController),
//               ],
//             );
//           }),
//         ),
//       ),
//     );
//   }
//
//   // AppBar Widget
//   AppBar _buildAppBar() {
//     return AppBar(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       leading: IconButton(
//         icon: const Icon(Icons.arrow_back, color: Colors.white),
//         onPressed: () => Get.back(),
//       ),
//       title: Text(
//         'Now Playing',
//         style: GoogleFonts.jost(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       centerTitle: true,
//     );
//   }
//
//   // Artwork Widget with transition animation
//   Widget _buildArtwork(SongModel currentSong) {
//     return AnimatedSwitcher(
//       duration: const Duration(milliseconds: 500),
//       transitionBuilder: (child, animation) {
//         return ScaleTransition(
//           scale: animation,
//           child: FadeTransition(
//             opacity: animation,
//             child: child,
//           ),
//         );
//       },
//       child: Center(
//         key: ValueKey(currentSong.id),
//         child: Container(
//           width: 300,
//           height: 300,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.5),
//                 blurRadius: 20,
//                 spreadRadius: 5,
//               ),
//             ],
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: QueryArtworkWidget(
//               id: currentSong.id,
//               type: ArtworkType.AUDIO,
//               artworkWidth: 300,
//               artworkHeight: 300,
//               artworkFit: BoxFit.cover,
//               nullArtworkWidget: Image.asset(
//                 'assets/images/music_back.jpg',
//                 width: 300,
//                 height: 300,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Song Information Widget
//   Widget _buildSongInfo(SongModel currentSong) {
//     return AnimatedSwitcher(
//       duration: const Duration(milliseconds: 500),
//       transitionBuilder: (child, animation) {
//         return FadeTransition(
//           opacity: animation,
//           child: SlideTransition(
//             position: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(animation),
//             child: child,
//           ),
//         );
//       },
//       child: Column(
//         key: ValueKey(currentSong.id),
//         children: [
//           Text(
//             currentSong.title,
//             style: GoogleFonts.jost(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//           Text(
//             currentSong.artist ?? 'Unknown Artist',
//             style: GoogleFonts.jost(
//               color: Colors.white70,
//               fontSize: 16,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Playback Progress Widget
//   Widget _buildPlaybackProgress(PlayerController playerController) {
//     return Obx(() {
//       final current = playerController.currentPlaybackPosition.value;
//       final total = playerController.totalDuration.value;
//
//       return Column(
//         children: [
//           Slider(
//             min: 0,
//             max: total,
//             value: current,
//             onChanged: (value) => playerController.seekToPosition(value),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(_formatDuration(Duration(milliseconds: current.toInt())), style: const TextStyle(color: Colors.white70)),
//                 Text(_formatDuration(Duration(milliseconds: total.toInt())), style: const TextStyle(color: Colors.white70)),
//               ],
//             ),
//           ),
//         ],
//       );
//     });
//   }
//
//   // Playback Controls Widget
//   Widget _buildPlaybackControls(PlayerController playerController) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(
//           icon: const Icon(Icons.skip_previous, color: Colors.white, size: 40),
//           onPressed: () => playerController.playPreviousSong(),
//         ),
//         const SizedBox(width: 20),
//         Obx(() => IconButton(
//           icon: Icon(
//             playerController.isPlaying.value ? Icons.pause_circle_filled : Icons.play_circle_filled,
//             color: Colors.white,
//             size: 70,
//           ),
//           onPressed: () => playerController.togglePlayPause(),
//         )),
//         const SizedBox(width: 20),
//         IconButton(
//           icon: const Icon(Icons.skip_next, color: Colors.white, size: 40),
//           onPressed: () => playerController.playNextSong(),
//         ),
//       ],
//     );
//   }
//
//   // Helper method to format duration
//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }
// }
//
//


/// new all working code
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/player_controller.dart';

class PlayScreen extends StatefulWidget {
  final SongModel song;

  const PlayScreen({Key? key, required this.song}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  // Initialize animations
  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutQuad,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PlayerController playerController = Get.find();

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: _buildAppBar(),
      body: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Obx(() {
            final currentSong = playerController.currentSong.value!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildArtwork(currentSong),
                const SizedBox(height: 30),
                _buildSongInfo(currentSong),
                const SizedBox(height: 30),
                _buildPlaybackProgress(playerController),
                const SizedBox(height: 30),
                _buildPlaybackControls(playerController),
              ],
            );
          }),
        ),
      ),
    );
  }

  // AppBar Widget
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'Now Playing',
        style: GoogleFonts.jost(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  // Artwork Widget with transition animation
  Widget _buildArtwork(SongModel currentSong) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: Center(
        key: ValueKey(currentSong.id),
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: QueryArtworkWidget(
              id: currentSong.id,
              type: ArtworkType.AUDIO,
              artworkWidth: 300,
              artworkHeight: 300,
              artworkFit: BoxFit.cover,
              nullArtworkWidget: Image.asset(
                'assets/images/music_back.jpg',
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Song Information Widget
  Widget _buildSongInfo(SongModel currentSong) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(animation),
            child: child,
          ),
        );
      },
      child: Column(
        key: ValueKey(currentSong.id),
        children: [
          Text(
            currentSong.title,
            style: GoogleFonts.jost(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            currentSong.artist ?? 'Unknown Artist',
            style: GoogleFonts.jost(
              color: Colors.white70,
              fontSize: 16,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // Playback Progress Widget
  Widget _buildPlaybackProgress(PlayerController playerController) {
    return Obx(() {
      final current = playerController.currentPlaybackPosition.value;
      final total = playerController.totalDuration.value;

      return Column(
        children: [
          Slider(
            min: 0,
            max: total,
            value: current,
            onChanged: (value) => playerController.seekToPosition(value),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatDuration(Duration(milliseconds: current.toInt())), style: const TextStyle(color: Colors.white70)),
                Text(_formatDuration(Duration(milliseconds: total.toInt())), style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
      );
    });
  }

  // Playback Controls Widget
  Widget _buildPlaybackControls(PlayerController playerController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Repeat mode button
        Obx(() => IconButton(
          icon: Icon(
            playerController.repeatMode.value == 0
                ? Icons.repeat
                : (playerController.repeatMode.value == 1
                ? Icons.repeat_one
                : Icons.repeat_on),
            color: playerController.repeatMode.value > 0
                ? Colors.blue
                : Colors.white,
          ),
          onPressed: () => playerController.toggleRepeatMode(),
        )),

        IconButton(
          icon: const Icon(Icons.skip_previous, color: Colors.white, size: 40),
          onPressed: () => playerController.playPreviousSong(),
        ),

        Obx(() => IconButton(
          icon: Icon(
            playerController.isPlaying.value
                ? Icons.pause_circle_filled
                : Icons.play_circle_filled,
            color: Colors.white,
            size: 70,
          ),
          onPressed: () => playerController.togglePlayPause(),
        )),

        IconButton(
          icon: const Icon(Icons.skip_next, color: Colors.white, size: 40),
          onPressed: () => playerController.playNextSong(),
        ),

        // Shuffle mode button
        Obx(() => IconButton(
          icon: Icon(
            Icons.shuffle,
            color: playerController.isShuffleMode.value
                ? Colors.blue
                : Colors.white,
          ),
          onPressed: () => playerController.toggleShuffle(),
        )),
      ],
    );
  }

  // Helper method to format duration
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}


