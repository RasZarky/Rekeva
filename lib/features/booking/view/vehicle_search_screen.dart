import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets/search/search_result_tile.dart';

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
              child: _isSearching ? _buildSearchResults() : _buildSuggestions(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'POPULAR RIGHT NOW',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _popularVehicles.length,
              itemBuilder: (context, index) {
                final v = _popularVehicles[index];
                return GestureDetector(
                  onTap: () => _onVehicleSelected({
                    'name': v['name']!,
                    'emoji': v['emoji']!,
                    'brand': '', // brand would normally be fetched
                    'years': '',
                    'type': '',
                  }),
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(v['emoji']!, style: const TextStyle(fontSize: 24)),
                        const SizedBox(height: 4),
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
          const SizedBox(height: 24),
          const Text(
            'RECENT',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.textMuted,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 12),
          _RecentSearchTile(
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
            const Text('No results found', style: TextStyle(color: AppColors.textMuted)),
            const SizedBox(height: 16),
            const Text('💡 Try searching by model like "RAV4"', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final v = filtered[index];
        return SearchResultTile(
          vehicle: v,
          query: _query,
          onTap: () => _onVehicleSelected(v),
        );
      },
    );
  }

  void _onVehicleSelected(Map<String, dynamic> vehicle) {
    context.push('/complex-vehicle-selection', extra: vehicle);
  }
}

class _RecentSearchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _RecentSearchTile({required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            const Icon(CupertinoIcons.time, color: AppColors.textMuted, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                  Text(subtitle, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
            ),
            const Text('Select', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
