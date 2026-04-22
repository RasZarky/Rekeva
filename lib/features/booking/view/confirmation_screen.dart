import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  void _showEnlargedQR(BuildContext context) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => CupertinoPageScaffold(
        backgroundColor: CupertinoColors.white,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFF000000).withOpacity(0.07),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(CupertinoIcons.xmark, size: 18, color: Color(0xFF555555)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Show to shop staff.',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamilySyne,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0C0C0C),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'They\'ll scan this to check you in.',
                style: TextStyle(fontSize: 13, color: Color(0xFF888888), fontWeight: FontWeight.w300),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0x14000000)),
                  boxShadow: const [
                    BoxShadow(color: Color(0x1A000000), blurRadius: 24, offset: Offset(0, 4)),
                  ],
                ),
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(color: CupertinoColors.black, borderRadius: BorderRadius.circular(12)),
                  child: GridView.builder(
                    padding: const EdgeInsets.all(14),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 7,
                      crossAxisSpacing: 3.0,
                      mainAxisSpacing: 3.0,
                    ),
                    itemCount: 49,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        color: (index % 2 == 0) ? CupertinoColors.white : CupertinoColors.black,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'RKV-20260319-4821',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamilySyne,
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0C0C0C),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(99)),
                child: const Text(
                  'ProTire Mississauga · Today 2:00 PM',
                  style: TextStyle(color: Color(0xFF15803D), fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 14),
              const Text('☀️ Screen brightness maximized for scanning', style: TextStyle(fontSize: 12, color: Color(0xFFAAAAAA))),
              const SizedBox(height: 8),
              const Text('Alex · Seasonal Swap · RAV4', style: TextStyle(fontSize: 11, color: Color(0xFFBBBBBB))),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                width: 64, height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FDF4),
                  border: Border.all(color: AppColors.primary, width: 2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(CupertinoIcons.checkmark, color: AppColors.primary, size: 28),
              ),
              const SizedBox(height: 14),
              const Text(
                'You\'re booked in.',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamilySyne,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0C0C0C),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Show this QR code when you arrive.',
                style: TextStyle(fontSize: 13, color: Color(0xFF888888), fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 18),
              
              GestureDetector(
                onTap: () => _showEnlargedQR(context),
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [BoxShadow(color: Color(0x1F000000), blurRadius: 24, offset: Offset(0, 4))],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 140, height: 140,
                        decoration: BoxDecoration(color: CupertinoColors.black, borderRadius: BorderRadius.circular(6)),
                        child: GridView.builder(
                          padding: const EdgeInsets.all(10),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 2.0,
                            mainAxisSpacing: 2.0,
                          ),
                          itemCount: 49,
                          itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                              color: (index % 3 == 0) ? CupertinoColors.white : CupertinoColors.black,
                              borderRadius: BorderRadius.circular(1),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'RKV-20260319-4821',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111111), letterSpacing: 0.5),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(color: const Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(99)),
                        child: const Text(
                          'ProTire Mississauga · 2:00 PM',
                          style: TextStyle(color: Color(0xFF15803D), fontSize: 10, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('☀️ Show to shop staff on arrival', style: TextStyle(fontSize: 10, color: Color(0xFF888888))),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: const Color(0xFFF6F6F4), borderRadius: BorderRadius.circular(14)),
                child: Column(
                  children: const [
                    _InfoRow(icon: '📍', label: 'Shop', value: 'ProTire Mississauga'),
                    _InfoRow(icon: '📅', label: 'Appointment', value: 'Today · 2:00 PM'),
                    _InfoRow(icon: '🏠', label: 'Address', value: '1234 Erin Mills Pkwy'),
                    _InfoRow(icon: '❄️', label: 'Service', value: 'Seasonal Swap'),
                    _InfoRow(icon: '👤', label: 'Name', value: 'Alex · +1 (647) 555'),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: _ActionBtn(icon: '📅', label: 'Calendar', onTap: () {})),
                  const SizedBox(width: 8),
                  Expanded(child: _ActionBtn(icon: '🗺', label: 'Directions', onTap: () {})),
                ],
              ),
              const SizedBox(height: 12),
              const Text('We texted you everything you need.', style: TextStyle(fontSize: 12, color: Color(0xFF999999))),
              
              const SizedBox(height: 20),
              Container(height: 1, color: const Color(0x14000000)),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text.rich(TextSpan(
                  text: 'Want your receipt by email? ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0x80000000)),
                  children: [
                    TextSpan(text: '(optional)', style: TextStyle(fontWeight: FontWeight.w400, color: Color(0x4D000000))),
                  ],
                )),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                      decoration: BoxDecoration(
                        color: const Color(0x0D000000),
                        border: Border.all(color: const Color(0x1F000000)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('alex@example.com', style: TextStyle(fontSize: 13, color: Color(0x59000000))),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(10)),
                      child: const Text('Send →', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: CupertinoColors.black)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Skip — I\'ll check my texts',
                style: TextStyle(fontSize: 11, color: Color(0x40000000), decoration: TextDecoration.underline),
              ),
              const SizedBox(height: 14),
              const Text.rich(TextSpan(
                text: 'Need somewhere to store your old tires? ',
                style: TextStyle(fontSize: 11, color: Color(0x4D000000)),
                children: [
                  TextSpan(text: 'Add storage →', style: TextStyle(fontWeight: FontWeight.w700, color: AppColors.primary)),
                ],
              )),
              
              const SizedBox(height: 32),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () => context.push('/booking-expectations'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: CupertinoColors.black, borderRadius: BorderRadius.circular(99)),
                  child: const Text(
                    'Add to calendar →',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: AppTextStyles.fontFamilySyne, fontSize: 15, fontWeight: FontWeight.w800, color: CupertinoColors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CupertinoButton(
                onPressed: () => context.go('/home'),
                child: const Text('Done', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String icon, label, value;
  const _InfoRow({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(width: 22, child: Text(icon, style: const TextStyle(fontSize: 13))),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF888888)))),
          Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF111111)),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String icon, label;
  final VoidCallback onTap;
  const _ActionBtn({required this.icon, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F4),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(icon, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF111111))),
          ],
        ),
      ),
    );
  }
}
