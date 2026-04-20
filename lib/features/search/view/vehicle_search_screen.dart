import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/recent_search_tile.dart';
import '../widgets/search_result_tile.dart';

class VehicleSearchScreen extends StatefulWidget {
  const VehicleSearchScreen({super.key});

  @override
  State<VehicleSearchScreen> createState() => _VehicleSearchScreenState();
}

class _VehicleSearchScreenState extends State<VehicleSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isSearching = false;
  String _query = '';

  final List<Map<String, String>> _popularVehicles = [
    {'name': 'RAV4', 'emoji': '🚙'},
    {'name': 'F-150', 'emoji': '🛻'},
    {'name': 'Civic', 'emoji': '🚗'},
    {'name': 'CR-V', 'emoji': '🚙'},
    {'name': 'Elantra', 'emoji': '🚗'},
    {'name': 'Silverado', 'emoji': '🛻'},
  ];

  final List<Map<String, dynamic>> _searchResults = [
    {
      'name': 'RAV4',
      'brand': 'Toyota',
      'years': '2019–2024',
      'type': 'FWD / AWD',
      'emoji': '🚙',
    },
    {
      'name': 'RAV4 Hybrid',
      'brand': 'Toyota',
      'years': '2019–2024',
      'type': 'AWD',
      'emoji': '🚙',
    },
    {
      'name': 'F-150',
      'brand': 'Ford',
      'years': 'Multiple Generations',
      'type': '4WD / RWD',
      'emoji': '🛻',
    },
    {
      'name': '3 Series',
      'brand': 'BMW',
      'years': '2019–present',
      'type': 'Luxury',
      'emoji': '🚗',
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value;
      _isSearching = value.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(99),
                        border: Border.all(
                          color: _isSearching ? AppColors.primary : AppColors.border,
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(CupertinoIcons.search, color: AppColors.primary, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CupertinoTextField(
                              controller: _searchController,
                              focusNode: _focusNode,
                              placeholder: 'Make, model or year…',
                              placeholderStyle: const TextStyle(color: AppColors.textMuted),
                              style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
                              decoration: null,
                              cursorColor: AppColors.primary,
                              onChanged: _onSearchChanged,
                            ),
                          ),
                          if (_isSearching)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                _onSearchChanged('');
                              },
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.textMuted.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(CupertinoIcons.xmark, size: 10, color: AppColors.textPrimary),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _isSearching ? _buildSearchResults() : _buildSuggestions(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.09)),
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 10, 16, 6),
            child: Text(
              'POPULAR RIGHT NOW',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.textMuted,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(
            height: 94,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 6, 16, 14),
              itemCount: _popularVehicles.length,
              itemBuilder: (context, index) {
                final v = _popularVehicles[index];
                return GestureDetector(
                  onTap: () => _onVehicleSelected({
                    'name': v['name']!,
                    'emoji': v['emoji']!,
                    'brand': '',
                    'years': '',
                    'type': '',
                  }),
                  child: Container(
                    width: 64,
                    margin: const EdgeInsets.only(right: 7),
                    decoration: BoxDecoration(
                      color: const Color(0xFF252525),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.08)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(v['emoji']!, style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 3),
                        Text(
                          v['name']!,
                          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.textPrimary.withValues(alpha: 0.05)),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 6),
                  child: Text(
                    'RECENT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                RecentSearchTile(
                  title: 'Toyota RAV4',
                  subtitle: '2022 · 225/65R17',
                  onTap: () => _onVehicleSelected({
                    'name': 'RAV4',
                    'emoji': '🚙',
                    'brand': 'Toyota',
                    'years': '2022',
                    'type': 'FWD',
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    final filtered = _searchResults.where((v) => 
      v['name'].toString().toLowerCase().contains(_query.toLowerCase()) ||
      v['brand'].toString().toLowerCase().contains(_query.toLowerCase())
    ).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text('No results found', style: TextStyle(color: AppColors.textMuted)),
            const SizedBox(height: 16),
            const Text('💡 Try searching by model like "RAV4"', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.09)),
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: List.generate(filtered.length, (index) {
              final v = filtered[index];
              return SearchResultTile(
                vehicle: v,
                query: _query,
                onTap: () => _onVehicleSelected(v),
              );
            }),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          ' results · Matched letters in green',
          style: TextStyle(fontSize: 11, color: Color(0x33FFFFFF)),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF161616),
            border: Border.all(color: AppColors.textPrimary.withValues(alpha: 0.07)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: const [
              Text('💡', style: TextStyle(fontSize: 14)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Trucks like F-150 or Silverado? We\'ll ask one more question to get the right tire size.',
                  style: TextStyle(fontSize: 11, color: AppColors.textMuted, height: 1.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onVehicleSelected(Map<String, dynamic> vehicle) {
    context.push('/complex-vehicle-selection', extra: vehicle);
  }
}
