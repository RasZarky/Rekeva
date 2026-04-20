import 'package:flutter/cupertino.dart';
import '../../../../core/theme/app_colors.dart';

class SearchResultTile extends StatelessWidget {
  final Map<String, dynamic> vehicle;
  final String query;
  final VoidCallback onTap;

  const SearchResultTile({
    super.key,
    required this.vehicle,
    required this.query,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: Text(vehicle['emoji'], style: const TextStyle(fontSize: 20)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHighlightedText(vehicle['name'], query),
                  const SizedBox(height: 2),
                  Text(
                    '${vehicle['brand']} · ${vehicle['years']} · ${vehicle['type']}',
                    style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                  ),
                ],
              ),
            ),
            const Icon(CupertinoIcons.chevron_right, size: 14, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText(String text, String query) {
    if (query.isEmpty || !text.toLowerCase().contains(query.toLowerCase())) {
      return Text(text,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary));
    }

    final int start = text.toLowerCase().indexOf(query.toLowerCase());
    final int end = start + query.length;

    return RichText(
      text: TextSpan(
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        children: [
          TextSpan(text: text.substring(0, start)),
          TextSpan(text: text.substring(start, end), style: const TextStyle(color: AppColors.primary)),
          TextSpan(text: text.substring(end)),
        ],
      ),
    );
  }
}
