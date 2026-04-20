import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';
import '../widgets/generation_tile.dart';

class ComplexVehicleSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> vehicle;

  const ComplexVehicleSelectionScreen({super.key, required this.vehicle});

  @override
  State<ComplexVehicleSelectionScreen> createState() => _ComplexVehicleSelectionScreenState();
}

class _ComplexVehicleSelectionScreenState extends State<ComplexVehicleSelectionScreen> {
  int _selectedIndex = 1;

  final List<Map<String, String>> _generations = [
    {
      'years': '2004 – 2008',
      'tireSize': '265/70R17',
    },
    {
      'years': '2009 – 2020',
      'tireSize': '265/65R18',
    },
    {
      'years': '2021 – present',
      'tireSize': '265/60R18 · Raptor 315/70R17',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => context.pop(),
                child: Row(
                  children: [
                    const Icon(CupertinoIcons.left_chevron, size: 14, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    const Text('Back', style: TextStyle(color: AppColors.textSecondary, fontSize: 14, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        '${widget.vehicle['emoji']} ${widget.vehicle['brand']} ${widget.vehicle['name']}',
                        style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Pick your\ngeneration.',
                style: TextStyle(
                  fontFamily: AppTextStyles.fontFamilySyne,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: CupertinoColors.white,
                  letterSpacing: -0.5,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tap the shape that matches your vehicle.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  itemCount: _generations.length,
                  itemBuilder: (context, index) {
                    final gen = _generations[index];
                    final isSelected = _selectedIndex == index;
                    return GenerationTile(
                      years: gen['years']!,
                      tireSize: isSelected ? '${gen['tireSize']!} confirmed ✓' : gen['tireSize']!,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'Older generation? Enter year manually',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12, decoration: TextDecoration.underline),
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'That\'s my vehicle → ${_generations[_selectedIndex]['tireSize']!.split(' · ').first}',
                onPressed: () => context.push('/luxury-handoff', extra: widget.vehicle),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Configuration matched for ${widget.vehicle['name']}',
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
