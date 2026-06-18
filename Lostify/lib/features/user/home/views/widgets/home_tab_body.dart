import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lostify/core/app_route/route_names.dart';
import 'package:lostify/core/cache/cache_helper.dart';
import 'package:lostify/core/di/dependancy_injection.dart';
import 'package:lostify/core/utilies/assets/images/app_images.dart';
import 'package:lostify/core/utilies/colors/app_colors.dart';
import 'package:lostify/core/utilies/extensions/app_extensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeTabBody extends StatefulWidget {
  const HomeTabBody({super.key});

  @override
  State<HomeTabBody> createState() => _HomeTabBodyState();
}

class _HomeTabBodyState extends State<HomeTabBody> {
  int _currentSlide = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  final List<Map<String, String>> _slides = [
    {
      'image':
          'https://images.unsplash.com/photo-1555374018-13a8994ab246?w=800',
      'title': 'Lost Something?',
      'subtitle': 'Report it and let the community help you find it',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1568992687947-868a62a9f521?w=800',
      'title': 'Found Something?',
      'subtitle': 'Help reunite lost items with their rightful owners',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1528360983277-13d401cdc186?w=800',
      'title': 'Community Help',
      'subtitle': 'Together we can recover what matters most',
    },
    {
      'image':
          'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800',
      'title': 'Connect Safely',
      'subtitle': 'Private and secure messaging between verified users',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildHeroSlider(context),
          const SizedBox(height: 16),
          AnimatedSmoothIndicator(
            activeIndex: _currentSlide,
            count: _slides.length,
            effect: ExpandingDotsEffect(
              dotColor: Colors.grey.shade300,
              activeDotColor: AppColors.kPrimaryColor,
              dotHeight: 8,
              dotWidth: 8,
              expansionFactor: 3,
            ),
          ),
          const SizedBox(height: 28),
          _buildBrandingSection(context),
          const SizedBox(height: 32),
          _buildActionButtons(context),
          const SizedBox(height: 32),
          _buildFeaturesSection(context),
          const SizedBox(height: 28),
          _buildStatsSection(context),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeroSlider(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return CarouselSlider(
      carouselController: _carouselController,
      options: CarouselOptions(
        height: screenHeight * 0.38,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        onPageChanged: (index, reason) {
          setState(() => _currentSlide = index);
        },
      ),
      items: _slides
          .map(
            (slide) => _buildSlide(
              imageUrl: slide['image']!,
              title: slide['title']!,
              subtitle: slide['subtitle']!,
            ),
          )
          .toList(),
    );
  }

  Widget _buildSlide({
    required String imageUrl,
    required String title,
    required String subtitle,
  }) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: AppColors.kPrimaryColor.withValues(alpha: 0.2),
            child: const Icon(Icons.image_not_supported,
                size: 48, color: Colors.white54),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.15),
                Colors.black.withValues(alpha: 0.68),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 36,
          left: 24,
          right: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(color: Colors.black54, blurRadius: 6),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14.5,
                  height: 1.4,
                  shadows: const [
                    Shadow(color: Colors.black54, blurRadius: 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBrandingSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.kPrimaryColor.withValues(alpha: 0.2),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                AppImages.logoImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Lostify',
            style: TextStyle(
              color: AppColors.kPrimaryColor,
              fontSize: 34,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Where Lost Things Find Their Way Back',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Post your lost or found items and connect with the right people in your community. Your privacy is our priority — only registered users can view listings.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13.5,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _GradientButton(
            label: 'Report Lost Item',
            icon: Icons.search_rounded,
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6B35), Color(0xFFE53E3E)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            onTap: () => _navigateToPostAd(context),
          ),
          const SizedBox(height: 14),
          _GradientButton(
            label: 'Report Found Item',
            icon: Icons.volunteer_activism_rounded,
            gradient: const LinearGradient(
              colors: [Color(0xFF38A169), Color(0xFF00B4D8)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            onTap: () => _navigateToPostAd(context),
          ),
        ],
      ),
    );
  }

  void _navigateToPostAd(BuildContext context) {
    final isLoggedIn = getIt<CacheHelper>().getUserModel() != null;
    if (!isLoggedIn) {
      context.pushScreen(RouteNames.signInScreen);
      return;
    }
    context.pushScreen(RouteNames.addItemScreen);
  }

  Widget _buildFeaturesSection(BuildContext context) {
    final features = [
      {
        'emoji': '🔒',
        'title': 'Private\n& Secure',
        'desc': 'Ads only visible to verified members',
      },
      {
        'emoji': '🤖',
        'title': 'AI-Powered\nSearch',
        'desc': 'Search by photo using our AI',
      },
      {
        'emoji': '💬',
        'title': 'Direct\nMessaging',
        'desc': 'Connect with finders or owners',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 16),
            child: Text(
              'Why Lostify?',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: features.map((f) {
              return Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  padding: const EdgeInsets.symmetric(
                      vertical: 18, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.kPrimaryColor.withValues(alpha: 0.07),
                        blurRadius: 14,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(
                      color: AppColors.kPrimaryColor.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        f['emoji']!,
                        style: const TextStyle(fontSize: 28),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        f['title']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.kPrimaryColor,
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        f['desc']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 10,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    final stats = [
      {'number': '500+', 'label': 'Items\nRecovered'},
      {'number': '1K+', 'label': 'Community\nMembers'},
      {'number': 'AI', 'label': 'Powered\nMatching'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.kPrimaryColor,
            const Color(0xFF1565C0),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.kPrimaryColor.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: stats.asMap().entries.map((entry) {
          final isLast = entry.key == stats.length - 1;
          return Expanded(
            child: Container(
              decoration: !isLast
                  ? BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.white.withValues(alpha: 0.25),
                          width: 1,
                        ),
                      ),
                    )
                  : null,
              child: Column(
                children: [
                  Text(
                    entry.value['number']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    entry.value['label']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.label,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.18),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
