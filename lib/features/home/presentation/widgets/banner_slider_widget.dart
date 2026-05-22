import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:marshmallow/features/home/presentation/bloc/banner_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/theme/app_colors.dart';

class BannerSliderWidget extends StatefulWidget {
  const BannerSliderWidget({super.key});

  @override
  State<BannerSliderWidget> createState() => _BannerSliderWidgetState();
}

class _BannerSliderWidgetState extends State<BannerSliderWidget> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<BannerProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(),
            ),
          );
        }
        if(provider.banners.isEmpty){
          return const SizedBox();
        }
        return Column(
          children: [
            CarouselSlider.builder(
              itemCount: provider.banners.length,
              itemBuilder: (context, index, realIndex) {

                final banner = provider.banners[index];
                return Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        image: DecorationImage(
                          image: NetworkImage(
                            banner.file,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.black.withOpacity(0.35),
                      ),
                    ),
                    Positioned.fill(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            banner.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 35,
                              vertical: 14,
                            ),

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),

                              gradient: const LinearGradient(
                                colors: [Colors.red, Colors.orange],
                              ),
                            ),

                            child: const Text(
                              "SHOP NOW",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1,
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 15),
            AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: provider.banners.length,
              effect: ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: AppColors.primary,
              ),
            ),
          ],
        );
      },
    );
  }
}
