import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:plotline_mobile/common/helpers/is_dark_mode.dart';

class LiquidMarbleBackground extends StatefulWidget {
  const LiquidMarbleBackground({super.key});

  @override
  State<LiquidMarbleBackground> createState() => _LiquidMarbleBackgroundState();
}

class _LiquidMarbleBackgroundState extends State<LiquidMarbleBackground>
    with SingleTickerProviderStateMixin {
  static const Duration _frameInterval = Duration(microseconds: 33333);

  late final Ticker _ticker;
  late final ValueNotifier<double> _time;

  ui.FragmentShader? _shader;
  Duration _lastFrame = Duration.zero;

  bool? _lastDarkMode;
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    _time = ValueNotifier<double>(0.0);

    _ticker = createTicker((elapsed) {
      if (elapsed - _lastFrame < _frameInterval) return;

      _lastFrame = elapsed;
      _time.value = elapsed.inMicroseconds / Duration.microsecondsPerSecond;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final isDark = context.isDarkMode;

    if (_lastDarkMode != isDark) {
      _lastDarkMode = isDark;
      _loadShader(isDark);
    }
  }

  Future<void> _loadShader(bool isDark) async {
    if (_loading) return;
    _loading = true;

    ui.FragmentShader? newShader;

    try {
      final asset = isDark
          ? 'shaders/liquid_marble/liquid_marble_dark.frag'
          : 'shaders/liquid_marble/liquid_marble_light.frag';

      final program = await ui.FragmentProgram.fromAsset(asset);
      newShader = program.fragmentShader();

      if (!mounted) {
        newShader.dispose();
        return;
      }

      final oldShader = _shader;

      setState(() {
        _shader = newShader;
      });

      newShader = null;
      oldShader?.dispose();

      if (!_ticker.isActive) {
        _ticker.start();
      }

      debugPrint('Liquid shader loaded successfully.');
    } catch (error, stackTrace) {
      newShader?.dispose();
      debugPrint('Liquid shader failed to load: $error');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _loading = false;

      // If the theme changed while loading, load the latest theme.
      if (mounted && _lastDarkMode != isDark) {
        _loadShader(_lastDarkMode!);
      }
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    _time.dispose();
    _shader?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shader = _shader;

    if (shader == null) {
      return ColoredBox(
        color: context.isDarkMode
            ? const Color(0xFF000000)
            : const Color(0xFFF8FAFC),
        child: const SizedBox.expand(),
      );
    }

    return RepaintBoundary(
      child: CustomPaint(
        painter: _LiquidMarblePainter(shader: shader, time: _time),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _LiquidMarblePainter extends CustomPainter {
  _LiquidMarblePainter({required this.shader, required this.time})
    : super(repaint: time);

  final ui.FragmentShader shader;
  final ValueListenable<double> time;

  @override
  void paint(Canvas canvas, Size size) {
    shader
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, time.value);

    canvas.drawRect(Offset.zero & size, Paint()..shader = shader);
  }

  @override
  bool shouldRepaint(covariant _LiquidMarblePainter oldDelegate) {
    return oldDelegate.shader != shader || oldDelegate.time != time;
  }
}
