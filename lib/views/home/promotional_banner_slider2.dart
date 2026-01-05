import 'package:bctpay/globals/globals.dart';
import 'package:bctpay/globals/index.dart';
import 'package:carousel_slider/carousel_slider.dart' as cs;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PromotionalBannerSlider2 extends StatelessWidget {
  final bannersListBloc = ApisBloc(ApisBlocInitialState())
    ..add(BannersList2Event(page: 1, limit: 9999));
  final carouselController = cs.CarouselSliderController();
  final selectDotIndicatorBloc = SelectionBloc(SelectIntState(0));

  PromotionalBannerSlider2({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: bannersListBloc,
        builder: (context, state) {
          if (state is BannersListState) {
            var banners = state.value.data?.promotionList ?? [];
            if (banners.isEmpty) {
              return const SizedBox();
            }
            return Column(
              children: [
                cs.CarouselSlider(
                  carouselController: carouselController,
                  options: cs.CarouselOptions(
                      onPageChanged: (index, reason) {
                        selectDotIndicatorBloc.add(SelectIntEvent(index));
                      },
                      autoPlay: banners.length <= 1 ? false : true,
                      enableInfiniteScroll: banners.length <= 1 ? false : true,
                      viewportFraction: 1,
                      enlargeCenterPage: true,
                      aspectRatio: 16 / 5),
                  items: banners
                      .map((e) => ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: baseUrlBanner + e.promotionBanner,
                              progressIndicatorBuilder:
                                  progressIndicatorBuilder,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              width: width,
                              fit: BoxFit.fill,
                            ),
                          ))
                      .toList(),
                ),
                const SizedBox(
                  height: 5,
                ),
                BlocBuilder(
                    bloc: selectDotIndicatorBloc,
                    builder: (context, state) {
                      if (state is SelectIntState) {
                        return AnimatedSmoothIndicator(
                          activeIndex: state.value,
                          count: banners.length,
                          onDotClicked: (index) {
                            carouselController.animateToPage(index);
                          },
                          effect: const WormEffect(
                            spacing: 4.0,
                            radius: 2.0,
                            dotWidth: 8.0,
                            dotHeight: 3.0,
                            strokeWidth: 1.5,
                          ),
                        );
                      }
                      return const Loader();
                    })
              ],
            );
          }
          return const Loader();
        });
  }
}
