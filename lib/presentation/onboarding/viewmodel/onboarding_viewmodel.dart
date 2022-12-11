import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_advanced/domain/models/models.dart';
import 'package:flutter_advanced/presentation/base/baseviewmodel.dart';
import 'package:flutter_advanced/presentation/resources/assets_manager.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  // stream controller for outputs

  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  // onBoarding viewModel inputs

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    _list = _getSliderData();
    _postDataToView();
  }

  @override
  void goNext() {
    // TODO: implement goNext

    // _pageController.nextPage(
    //   duration: const Duration(
    //     milliseconds: 750,
    //   ),
    //   curve: Curves.fastLinearToSlowEaseIn,
    // );
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // onBoarding viewModel outputs

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  //onBoarding private functions

  List<SliderObject> _getSliderData() => [
        SliderObject(
          AppStrings.onBoardingTitle1.tr(),
          AppStrings.onBoardingSubTitle1.tr(),
          ImageAssets.onBoardingLogo1,
        ),
        SliderObject(
          AppStrings.onBoardingTitle2.tr(),
          AppStrings.onBoardingSubTitle2.tr(),
          ImageAssets.onBoardingLogo2,
        ),
        SliderObject(
          AppStrings.onBoardingTitle3.tr(),
          AppStrings.onBoardingSubTitle3.tr(),
          ImageAssets.onBoardingLogo3,
        ),
        SliderObject(
          AppStrings.onBoardingTitle4.tr(),
          AppStrings.onBoardingSubTitle4.tr(),
          ImageAssets.onBoardingLogo4,
        ),
      ];

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
      _list[_currentIndex],
      _list.length,
      _currentIndex,
    ));
  }
}

abstract class OnBoardingViewModelInputs {
  void goNext();
  void onPageChanged(int index);

  //stream controller input

  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  //stream controller input
  Stream get outputSliderViewObject;
}
