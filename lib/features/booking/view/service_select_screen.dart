import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/primary_button.dart';
import '../widgets/service_card.dart';

class ServiceSelectScreen extends StatelessWidget {
  const ServiceSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Select Service'),
        previousPageTitle: 'Home',
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('What are we\ndoing today?', style: AppTextStyles.headline),
              const SizedBox(height: 28),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      ServiceCard(
                        icon: '❄️', 
                        title: 'Seasonal Swap', 
                        desc: 'Swap to winters. Or back to summers.', 
                        price: 49.0,
                        isPopular: true,
                      ),
                      SizedBox(height: 12),
                      ServiceCard(
                        icon: '⚙️', 
                        title: 'Fit My Tires', 
                        desc: 'You\'ve got tires. We\'ll fit them.', 
                        price: 25.0,
                      ),
                      SizedBox(height: 12),
                      ServiceCard(
                        icon: '🛒', 
                        title: 'New Tires + Install', 
                        desc: 'We\'ll help you pick and fit same day', 
                        price: 289.0,
                      ),
                    ],
                  ),
                ),
              ),
              PrimaryButton(text: 'Continue →', onPressed: () => context.push('/shop-list')),
            ],
          ),
        ),
      ),
    );
  }
}
