import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/gen/assets.gen.dart';

/// Onboarding Page dengan 3 screens, background image, dan animasi
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _imageAnimationController;
  int _currentPage = 0;

  final List<OnboardingItem> _onboardingItems = [
    OnboardingItem(
      image: Assets.images.onboarding1,
      title: 'No More Waiting,\nNo More Hassle!',
      description:
          'Gas production and distribution, right from your location. Hassle-free, everything\'s integrated in one app.',
      buttonText: 'Next',
    ),
    OnboardingItem(
      image: Assets.images.onboarding2,
      title: 'Just One Scan\nfor Everything!',
      description:
          'Scan the item\'s QR to update its status, from filling, delivery, to return. No hassle, instant updates!',
      buttonText: 'Next',
    ),
    OnboardingItem(
      image: Assets.images.onboarding3,
      title: 'Cylinder Tracking Made Easy',
      description:
          'Monitor cylinder movement at every point. With controlled circulation, your supply stays reliable and secure.',
      buttonText: 'Get Started',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _imageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
    
    // Auto-scroll setiap 5 detik
    Future.delayed(const Duration(seconds: 5), _autoScroll);
  }
  
  void _autoScroll() {
    if (mounted && _currentPage < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
      // Schedule next auto-scroll
      Future.delayed(const Duration(seconds: 5), _autoScroll);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _imageAnimationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingItems.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to login
      if (mounted) {
        context.go('/login');
      }
    }
  }

  void _skipOnboarding() {
    context.go('/login');
  }

  void _resetAnimations() {
    _imageAnimationController.reset();
    _imageAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
          _resetAnimations();
        },
        itemCount: _onboardingItems.length,
        itemBuilder: (context, index) {
          return _buildOnboardingScreen(
            item: _onboardingItems[index],
            isLastPage: index == _onboardingItems.length - 1,
          );
        },
      ),
    );
  }

  Widget _buildOnboardingScreen({
    required OnboardingItem item,
    required bool isLastPage,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    // Atur ukuran image berdasarkan index - responsive
    late double imageWidth;
    late double imageHeight;
    
    if (_currentPage == 0) {
      // Screen 1: ukuran besar (95% of screen width)
      imageWidth = screenWidth * 0.95;
      imageHeight = screenHeight * 0.59;
    } else if (_currentPage == 1) {
      // Screen 2: ukuran lebih kecil (62% of screen width)
      imageWidth = screenWidth * 0.62;
      imageHeight = screenHeight * 0.38;
    } else {
      // Screen 3: ukuran medium (72% of screen width)
      imageWidth = screenWidth * 0.72;
      imageHeight = screenHeight * 0.45;
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        image: DecorationImage(
          image: Assets.images.onboardingBg.provider(),
          fit: BoxFit.cover,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: Stack(
        children: [
          // Animated Image at top
          Positioned(
            left: (390 - imageWidth) / 2, // Center horizontal
            top: 55,
            child: FadeTransition(
              opacity: _imageAnimationController.drive(
                Tween<double>(begin: 0, end: 1),
              ),
              child: ScaleTransition(
                scale: _imageAnimationController.drive(
                  Tween<double>(begin: 0.9, end: 1),
                ),
                child: Container(
                  width: imageWidth,
                  height: imageHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: item.image.provider(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Curved bottom content
          Positioned(
            left: -214,
            top: 416,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 215, vertical: 84),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(500),
                    topRight: Radius.circular(500),
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 48,
                children: [
                  Container(
                    width: 389,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(500),
                          topRight: Radius.circular(500),
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      spacing: screenHeight * 0.076,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: screenHeight * 0.028,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                                child: Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF242424),
                                    fontSize: screenWidth * 0.082,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w700,
                                    height: 1.20,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                                child: Text(
                                  item.description,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: const Color(0xFF677487),
                                    fontSize: screenWidth * 0.041,
                                    fontFamily: 'Nunito Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 1.60,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                          Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: screenWidth * 0.026,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                spacing: screenWidth * 0.007,
                                children: List.generate(
                                  _onboardingItems.length,
                                  (index) => AnimatedContainer(
                                    duration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    width: index == _currentPage ? screenWidth * 0.123 : screenWidth * 0.021,
                                    height: screenWidth * 0.021,
                                    decoration: ShapeDecoration(
                                      color: index == _currentPage
                                          ? const Color(0xFF007EFF)
                                          : const Color(0xFFB3D8FF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(screenWidth * 0.11),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (_currentPage == 0)
                                GestureDetector(
                                  onTap: _skipOnboarding,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.062,
                                      vertical: screenHeight * 0.014,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFB3D8FF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      'Skip',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF007EFF),
                                        fontSize: screenWidth * 0.041,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                GestureDetector(
                                  onTap: _nextPage,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.062,
                                      vertical: screenHeight * 0.014,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFF007EFF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      isLastPage ? 'Get Started' : 'Next',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: screenWidth * 0.041,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Model untuk Onboarding Item
class OnboardingItem {
  final AssetGenImage image;
  final String title;
  final String description;
  final String buttonText;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}
