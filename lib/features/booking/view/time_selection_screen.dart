import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class TimeSelectionScreen extends StatefulWidget {
  final String shopName;

  const TimeSelectionScreen({super.key, required this.shopName});

  @override
  State<TimeSelectionScreen> createState() => _TimeSelectionScreenState();
}

class _TimeSelectionScreenState extends State<TimeSelectionScreen> {
  String? _selectedTime;
  int _secondsLeft = 600; // 10 minutes
  Timer? _timer;
  
  // Demo state: Wednesday is fully booked to match wireframe
  bool _isBookedOut = false;
  String _selectedDay = 'Wed';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _onDayTap(String day) {
    setState(() {
      _selectedDay = day;
      _isBookedOut = day == 'Wed'; // Demo: Wed is fully booked
      _selectedTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Row(
                  children: const [
                    Icon(CupertinoIcons.left_chevron, size: 14, color: AppColors.textMuted),
                    SizedBox(width: 4),
                    Text('Back', style: TextStyle(color: AppColors.textMuted, fontSize: 14, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Pick your time.', style: AppTextStyles.headline),
              Text(widget.shopName, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
              const SizedBox(height: 24),
              
              // Date Strip
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _DatePill(day: 'Mon', num: '17', isPast: true),
                    _DatePill(day: 'Tue', num: '18', isPast: true),
                    _DatePill(day: 'Wed', num: '19', isActive: _selectedDay == 'Wed', onTap: () => _onDayTap('Wed')),
                    _DatePill(day: 'Thu', num: '20', isActive: _selectedDay == 'Thu', onTap: () => _onDayTap('Thu')),
                    _DatePill(day: 'Fri', num: '21', isActive: _selectedDay == 'Fri', onTap: () => _onDayTap('Fri')),
                    _DatePill(day: 'Sat', num: '22', isActive: _selectedDay == 'Sat', onTap: () => _onDayTap('Sat')),
                    _DatePill(day: 'Sun', num: '23', isActive: _selectedDay == 'Sun', onTap: () => _onDayTap('Sun')),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              if (_isBookedOut)
                Expanded(child: _buildBookedOutView())
              else ...[
                if (_selectedTime != null)
                  _SlotHeldBanner(timeLeft: _formatTime(_secondsLeft)),

                Expanded(
                  child: ListView(
                    children: [
                      const _SectionLabel(label: 'MORNING'),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          const _TimePill(time: '9:00 AM', isTaken: true),
                          _TimePill(time: '10:00 AM', isSelected: _selectedTime == '10:00 AM', onTap: () => setState(() => _selectedTime = '10:00 AM')),
                          _TimePill(time: '11:00 AM', tag: 'PRIORITY', isSelected: _selectedTime == '11:00 AM', onTap: () => setState(() => _selectedTime = '11:00 AM')),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const _SectionLabel(label: 'AFTERNOON'),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          _TimePill(time: '1:00 PM', isSelected: _selectedTime == '1:00 PM', onTap: () => setState(() => _selectedTime = '1:00 PM')),
                          _TimePill(time: '2:00 PM', isSelected: _selectedTime == '2:00 PM', onTap: () => setState(() => _selectedTime = '2:00 PM')),
                          const _TimePill(time: '3:00 PM', isTaken: true),
                          _TimePill(time: '5:00 PM', tag: 'LAST SLOT', isSelected: _selectedTime == '5:00 PM', onTap: () => setState(() => _selectedTime = '5:00 PM')),
                        ],
                      ),
                    ],
                  ),
                ),
                
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: _selectedTime != null ? () => context.push('/checkout') : null,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _selectedTime != null ? AppColors.primary : AppColors.surface,
                      borderRadius: BorderRadius.circular(99),
                      border: _selectedTime == null ? Border.all(color: AppColors.border) : null,
                    ),
                    child: Text(
                      _selectedTime != null ? 'Lock in $_selectedTime →' : 'Pick a time',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppTextStyles.fontFamilySyne,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: _selectedTime != null ? CupertinoColors.black : AppColors.textMuted,
                      ),
                    ),
                  ),
                ),
                const Center(child: Padding(padding: EdgeInsets.only(top: 8), child: Text('No payment yet.', style: TextStyle(fontSize: 11, color: AppColors.textMuted)))),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookedOutView() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.warning.withValues(alpha: 0.08),
            border: Border.all(color: AppColors.warning.withValues(alpha: 0.25)),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Text('📅', style: TextStyle(fontSize: 32)),
              const SizedBox(height: 12),
              const Text('Fully booked Wednesday', style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 18, fontWeight: FontWeight.w800, color: CupertinoColors.white)),
              const SizedBox(height: 6),
              const Text('No slots on Nov 19 at ProTire. Try the next day or a different shop.', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: AppColors.textMuted, height: 1.6)),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ActionChip(label: 'Try Nov 20 →', onTap: () => _onDayTap('Thu')),
                  const SizedBox(width: 8),
                  _ActionChip(label: 'Other shops', onTap: () => context.pop()),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              const Text('🔔', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Notify me when a slot opens', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: CupertinoColors.white)),
                    SizedBox(height: 2),
                    Text('We\'ll text you if Nov 19 frees up', style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  ],
                ),
              ),
              const CupertinoSwitch(value: true, activeColor: AppColors.primary, onChanged: null),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _ActionChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
      ),
    );
  }
}

class _SlotHeldBanner extends StatelessWidget {
  final String timeLeft;
  const _SlotHeldBanner({required this.timeLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text('🕐', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Your slot is held', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w700)),
                  Text('Complete to lock it in.', style: TextStyle(color: AppColors.textMuted, fontSize: 10)),
                ],
              ),
            ],
          ),
          Text(timeLeft, style: const TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.primary)),
        ],
      ),
    );
  }
}

class _DatePill extends StatelessWidget {
  final String day, num;
  final bool isActive;
  final bool isPast;
  final VoidCallback? onTap;
  const _DatePill({required this.day, required this.num, this.isActive = false, this.isPast = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isPast ? null : onTap,
      child: Opacity(
        opacity: isPast ? 0.4 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          constraints: const BoxConstraints(minWidth: 54),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isActive ? AppColors.primary : AppColors.border),
          ),
          child: Column(
            children: [
              Text(day.toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: isActive ? CupertinoColors.black.withValues(alpha: 0.7) : AppColors.textMuted)),
              Text(num, style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 20, fontWeight: FontWeight.w800, color: isActive ? CupertinoColors.black : CupertinoColors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimePill extends StatelessWidget {
  final String time;
  final String? tag;
  final bool isTaken;
  final bool isSelected;
  final VoidCallback? onTap;

  const _TimePill({required this.time, this.tag, this.isTaken = false, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isTaken ? null : onTap,
      child: Opacity(
        opacity: isTaken ? 0.3 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.circular(99),
            border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(time, style: TextStyle(fontSize: 13, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, color: isSelected ? CupertinoColors.black : CupertinoColors.white, decoration: isTaken ? TextDecoration.lineThrough : null)),
              if (tag != null) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSelected ? CupertinoColors.black.withValues(alpha: 0.1) : (tag == 'PRIORITY' ? AppColors.warning : AppColors.error),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(tag!, style: const TextStyle(color: CupertinoColors.white, fontSize: 8, fontWeight: FontWeight.w800)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Text(label, style: AppTextStyles.caption),
  );
}
