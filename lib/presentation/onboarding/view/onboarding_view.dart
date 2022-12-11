import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advanced/app/app_preferences.dart';
import 'package:flutter_advanced/app/di.dart';
import 'package:flutter_advanced/domain/models/models.dart';
import 'package:flutter_advanced/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:flutter_advanced/presentation/resources/color_manager.dart';
import 'package:flutter_advanced/presentation/resources/routes_manager.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  //bool _isLast = false;

  _bind() {
    _appPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: 0.0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.white,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                itemCount: sliderViewObject.numOfSlides,
                onPageChanged: (index) {
                  _viewModel.onPageChanged(index);
                },
                itemBuilder: (context, index) =>
                    OnBoardingPage(sliderViewObject.sliderObject),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  Routes.loginRoute,
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.size40,
                ),
                child: Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Text(
                    AppStrings.skip.tr(),
                    style: TextStyle(
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.size20,
            ),
            Padding(
              padding: const EdgeInsets.all(AppSize.size40),
              child: Row(
                children: [
                  const Spacer(),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: sliderViewObject.numOfSlides,
                    effect: ExpandingDotsEffect(
                      dotColor: ColorManager.grey,
                      activeDotColor: ColorManager.primary,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      expansionFactor: 4.0,
                      spacing: 5.0,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // if (_isLast) {
                      //   submit();
                      // } else {
                      _pageController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                      if (sliderViewObject.currentIndex ==
                          sliderViewObject.numOfSlides - 1) {
                        Navigator.pushReplacementNamed(
                            context, Routes.loginRoute);
                      }
                      //}
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.size60,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.padding8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.padding8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        // const SizedBox(
        //   height: AppSize.size60,
        // ),
        SvgPicture.asset(
          _sliderObject.image,
        ),
      ],
    );
  }
}
