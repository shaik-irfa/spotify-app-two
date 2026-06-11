import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider/audio_provider.dart';
import '../widgets/music_image.dart';

class NowPlayingScreen extends ConsumerWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(audioProvider);
    final controller = ref.read(audioProvider.notifier);

    ref.listen(audioProvider, (previous, next) {
      if (next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
        ref.read(audioProvider.notifier).clearError();
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111111),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down,
              color: Colors.white, size: 32),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Now Playing",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenHeight = constraints.maxHeight;
            // Scale album image size based on screen height
            final imageSize = (screenHeight * 0.42).clamp(140.0, 300.0);
            final spacing = (screenHeight * 0.035).clamp(10.0, 30.0);

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: screenHeight,
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    child: Column(
                      children: [
                        SizedBox(height: spacing),

                        // ===== Album Art =====
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: MusicImage(
                              imageUrl: audioState.imageUrl ?? "",
                              height: imageSize,
                              width: imageSize,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        SizedBox(height: spacing),

                        // ===== Song Title =====
                        Text(
                          audioState.title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        // ===== Artist =====
                        Text(
                          audioState.artist ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 14,
                          ),
                        ),

                        SizedBox(height: spacing),

                        // ===== PROGRESS BAR =====
                        StreamBuilder<Duration>(
                          stream: controller.positionStream,
                          builder: (context, snapshot) {
                            final position = snapshot.data ?? Duration.zero;
                            final duration = controller.totalDuration;

                            return Column(
                              children: [
                                Slider(
                                  min: 0,
                                  max: duration.inSeconds
                                      .toDouble()
                                      .clamp(1, double.infinity),
                                  value: position.inSeconds
                                      .toDouble()
                                      .clamp(0, duration.inSeconds.toDouble()),
                                  activeColor: Colors.green,
                                  inactiveColor: Colors.white24,
                                  onChanged: (value) {
                                    controller
                                        .seek(Duration(seconds: value.toInt()));
                                  },
                                ),

                                // ===== Time Row =====
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _format(position),
                                        style: TextStyle(
                                          color:
                                              Colors.white.withValues(alpha: 0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        _format(duration),
                                        style: TextStyle(
                                          color:
                                              Colors.white.withValues(alpha: 0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        const Spacer(),

                        // ===== CONTROLS =====
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: controller.playPrevious,
                              icon: const Icon(
                                  Icons.skip_previous,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),

                            const SizedBox(width: 20),

                            // Loading state vs Play/Pause button
                            if (audioState.isLoading)
                              const SizedBox(
                                width: 70,
                                height: 70,
                                child: Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                    strokeWidth: 3.5,
                                  ),
                                ),
                              )
                            else
                              IconButton(
                                onPressed: () {
                                  audioState.isPlaying
                                      ? controller.pause()
                                      : controller.resume();
                                },
                                icon: Icon(
                                  audioState.isPlaying
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_fill,
                                  color: Colors.white,
                                  size: 70,
                                ),
                              ),

                            const SizedBox(width: 20),

                            IconButton(
                              onPressed: controller.playNext,
                              icon: const Icon(
                                Icons.skip_next,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: spacing * 1.5),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ===== TIME FORMAT =====
  String _format(Duration d) {
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
