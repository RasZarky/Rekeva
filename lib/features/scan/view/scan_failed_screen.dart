import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';

class ScanFailedScreen extends StatelessWidget {
  const ScanFailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      child: Stack(
        children: [
          // Mock Camera Feed (Darkened)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF181818), Color(0xFF0A0A0A)],
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
                        color: CupertinoColors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: CupertinoColors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: const Text(
                      'Torch 🔦',
                      style: TextStyle(color: Color(0x99FFFFFF), fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Failed Viewfinder
          Center(
            child: Container(
              width: 240,
              height: 100,
              margin: const EdgeInsets.only(bottom: 100),
              child: Stack(
                children: [
                  _CornerMarker(top: 0, left: 0),
                  _CornerMarker(top: 0, right: 0, isRight: true),
                  _CornerMarker(bottom: 0, left: 0, isBottom: true),
                  _CornerMarker(bottom: 0, right: 0, isBottom: true, isRight: true),
                  const Center(
                    child: Text('❌', style: TextStyle(fontSize: 28)),
                  ),
                ],
              ),
            ),
          ),

          // Error Message and Recovery Options
          Positioned(
            top: MediaQuery.of(context).size.height * 0.6,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  // Error box
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
                  
                  // Recovery actions
                  PrimaryButton(
                    text: 'Try again',
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      // TODO: Implement manual VIN entry
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
              ),
            ),
          ),
          
          const Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Center(
              child: _HomeIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CornerMarker extends StatelessWidget {
  final double? top, left, right, bottom;
  final bool isRight, isBottom;

  const _CornerMarker({this.top, this.left, this.right, this.bottom, this.isRight = false, this.isBottom = false});

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
            top: top != null ? const BorderSide(color: Color(0xFFEF4444), width: 2.5) : BorderSide.none,
            bottom: bottom != null ? const BorderSide(color: Color(0xFFEF4444), width: 2.5) : BorderSide.none,
            left: left != null ? const BorderSide(color: Color(0xFFEF4444), width: 2.5) : BorderSide.none,
            right: right != null ? const BorderSide(color: Color(0xFFEF4444), width: 2.5) : BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 134,
      height: 5,
      decoration: BoxDecoration(
        color: CupertinoColors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(99),
      ),
    );
  }
}
