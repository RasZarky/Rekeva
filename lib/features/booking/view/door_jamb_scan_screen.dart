import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class DoorJambScanScreen extends StatefulWidget {
  const DoorJambScanScreen({super.key});

  @override
  State<DoorJambScanScreen> createState() => _DoorJambScanScreenState();
}

class _DoorJambScanScreenState extends State<DoorJambScanScreen> with TickerProviderStateMixin {
  late AnimationController _scanningController;
  late Animation<double> _scanningAnimation;
  
  late AnimationController _loadingController;
  late Animation<double> _loadingAnimation;
  
  CameraController? _cameraController;
  bool _isPermissionGranted = false;
  bool _showBottomSheet = false;
  bool _scanFailed = false;
  bool _isTorchOn = false;
  Timer? _scanTimer;

  @override
  void initState() {
    super.initState();
    
    // Scanning line animation
    _scanningController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _scanningAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _scanningController, curve: Curves.easeInOut),
    );

    // Bottom sheet loading animation
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _loadingAnimation = Tween<double>(begin: 0, end: 1).animate(_loadingController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          context.push('/vehicle-confirmation');
        }
      });

    _initializeCamera();
    _startScanTimer();
  }

  void _startScanTimer() {
    _scanTimer?.cancel();
    _scanTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showBottomSheet = true;
          // In a real app, this logic would depend on actual detection results.
          // Toggling _scanFailed to false for default success behavior.
          _scanFailed = false; 
          if (!_scanFailed) {
            _loadingController.forward();
          }
        });
      }
    });
  }

  Future<void> _initializeCamera() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      _cameraController = CameraController(
        cameras.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      try {
        await _cameraController!.initialize();
        if (mounted) {
          setState(() {
            _isPermissionGranted = true;
          });
        }
      } catch (e) {
        debugPrint('Camera initialization error: $e');
      }
    }
  }

  Future<void> _toggleTorch() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      try {
        _isTorchOn = !_isTorchOn;
        await _cameraController!.setFlashMode(
          _isTorchOn ? FlashMode.torch : FlashMode.off,
        );
        setState(() {});
      } catch (e) {
        debugPrint('Flash error: $e');
      }
    }
  }

  @override
  void dispose() {
    _scanTimer?.cancel();
    _scanningController.dispose();
    _loadingController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _scanFailed ? const Color(0xFFEF4444) : AppColors.primary;

    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      child: Stack(
        children: [
          // Camera Preview
          if (_isPermissionGranted && _cameraController != null && _cameraController!.value.isInitialized)
            SizedBox.expand(
              child: CameraPreview(_cameraController!),
            )
          else
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF181818), Color(0xFF0A0A0A)],
                ),
              ),
              child: const Center(
                child: Text(
                  'Initializing camera...',
                  style: TextStyle(color: CupertinoColors.white, fontSize: 12),
                ),
              ),
            ),

          // Top Controls
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: CupertinoColors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_scanFailed) {
                        _toggleTorch();
                      } else {
                        // Manual trigger for failure state demo
                        setState(() {
                          _showBottomSheet = true;
                          _scanFailed = true;
                          _scanTimer?.cancel();
                          _loadingController.stop();
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: CupertinoColors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        _scanFailed ? 'Torch 🔦' : 'Enter manually',
                        style: TextStyle(
                          color: _scanFailed ? CupertinoColors.white : const Color(0xB2FFFFFF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Instructions
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  'Point at the door jamb sticker',
                  style: TextStyle(color: CupertinoColors.white, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  'Driver\'s side · Inside the door frame',
                  style: TextStyle(color: CupertinoColors.white.withValues(alpha: 0.45), fontSize: 11),
                ),
              ],
            ),
          ),

          // Helper Diagram
          Positioned(
            top: 160,
            right: 20,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: CupertinoColors.black.withValues(alpha: 0.6),
                    border: Border.all(color: CupertinoColors.white.withValues(alpha: 0.15)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      const Text('🚗', style: TextStyle(fontSize: 20)),
                      const SizedBox(height: 4),
                      Container(
                        width: 24,
                        height: 3,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'HERE',
                        style: TextStyle(color: AppColors.primary, fontSize: 9, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Door\njamb',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: CupertinoColors.white.withValues(alpha: 0.3), fontSize: 9),
                ),
              ],
            ),
          ),

          // Viewfinder
          Center(
            child: Container(
              width: 220,
              height: 140,
              color: CupertinoColors.transparent,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Corner markers
                  _CornerMarker(top: 0, left: 0, color: statusColor),
                  _CornerMarker(top: 0, right: 0, isRight: true, color: statusColor),
                  _CornerMarker(bottom: 0, left: 0, isBottom: true, color: statusColor),
                  _CornerMarker(bottom: 0, right: 0, isBottom: true, isRight: true, color: statusColor),

                  // Scanning line animation
                  if (!_showBottomSheet)
                    AnimatedBuilder(
                      animation: _scanningAnimation,
                      builder: (context, child) {
                        return Positioned(
                          top: 140 * _scanningAnimation.value,
                          left: 10,
                          right: 10,
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.8),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary.withValues(alpha: 0),
                                  AppColors.primary,
                                  AppColors.primary.withValues(alpha: 0),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  
                  if (_scanFailed)
                    const Center(
                      child: Text('❌', style: TextStyle(fontSize: 28)),
                    ),
                ],
              ),
            ),
          ),

          // Bottom Confirmation Sheet
          if (_showBottomSheet)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  border: Border(top: BorderSide(color: CupertinoColors.white.withValues(alpha: 0.1))),
                ),
                child: _scanFailed ? _buildFailedContent(context) : _buildSuccessContent(context),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSuccessContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: CupertinoColors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: AppColors.primary, blurRadius: 6)],
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'VIN detected',
              style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: 6),
        const Text(
          '2T3BFREV9NW123456',
          style: TextStyle(color: CupertinoColors.white, fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1),
        ),
        const SizedBox(height: 4),
        Text(
          'Looking up your vehicle…',
          style: TextStyle(color: CupertinoColors.white.withValues(alpha: 0.4), fontSize: 12),
        ),
        const SizedBox(height: 14),
        AnimatedBuilder(
          animation: _loadingAnimation,
          builder: (context, child) {
            return Container(
              height: 3,
              decoration: BoxDecoration(
                color: CupertinoColors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(99),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _loadingAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFailedContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: CupertinoColors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFEF4444).withValues(alpha: 0.12),
            border: Border.all(color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              const Text(
                'Couldn\'t read the sticker',
                style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.w700, fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                'Try better lighting or clean the sticker. Or enter your VIN manually.',
                textAlign: TextAlign.center,
                style: TextStyle(color: CupertinoColors.white.withValues(alpha: 0.45), fontSize: 12, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            setState(() {
              _showBottomSheet = false;
              _scanFailed = false;
              _startScanTimer();
            });
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(99),
            ),
            child: const Text(
              'Try again',
              textAlign: TextAlign.center,
              style: TextStyle(color: CupertinoColors.black, fontWeight: FontWeight.w800, fontSize: 15),
            ),
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // TODO: Implement manual VIN entry navigation
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 13),
            decoration: BoxDecoration(
              color: CupertinoColors.white.withValues(alpha: 0.08),
              border: Border.all(color: CupertinoColors.white.withValues(alpha: 0.12)),
              borderRadius: BorderRadius.circular(99),
            ),
            child: const Text(
              'Enter VIN manually →',
              textAlign: TextAlign.center,
              style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ),
        ),
        const SizedBox(height: 8),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => context.push('/scan-tips'),
          child: Text(
            'Search my vehicle instead',
            style: TextStyle(color: CupertinoColors.white.withValues(alpha: 0.45), fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _CornerMarker extends StatelessWidget {
  final double? top, left, right, bottom;
  final bool isRight, isBottom;
  final Color color;

  const _CornerMarker({
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.isRight = false,
    this.isBottom = false,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          border: Border(
            top: top != null ? BorderSide(color: color, width: 2.5) : BorderSide.none,
            bottom: bottom != null ? BorderSide(color: color, width: 2.5) : BorderSide.none,
            left: left != null ? BorderSide(color: color, width: 2.5) : BorderSide.none,
            right: right != null ? BorderSide(color: color, width: 2.5) : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
