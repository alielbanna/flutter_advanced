import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced/app/di.dart';
import 'package:flutter_advanced/domain/models/models.dart';
import 'package:flutter_advanced/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:flutter_advanced/presentation/main/pages/home/viewmodel/home_viewmodel.dart';
import 'package:flutter_advanced/presentation/resources/color_manager.dart';
import 'package:flutter_advanced/presentation/resources/routes_manager.dart';
import 'package:flutter_advanced/presentation/resources/strings_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.start();
                  }) ??
                  _getContentWidget();
            }),
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<HomeViewObject>(
        stream: _viewModel.outputHomeData,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: AppSize.size4,
              ),
              _getBannerWidget(snapshot.data?.banners),
              _getSection(AppStrings.services.tr()),
              _getServicesWidget(snapshot.data?.services),
              _getSection(AppStrings.stores.tr()),
              _getStoresWidget(snapshot.data?.stores),
            ],
          );
        });
  }

  Widget _getBannerWidget(List<BannerAd>? banners) {
    if (banners != null) {
      return CarouselSlider(
        items: banners
            .map((banner) => SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: AppSize.size1_5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.size12),
                        side: BorderSide(
                            color: ColorManager.primary, width: AppSize.size1)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.size12),
                      child: Image.network(banner.image, fit: BoxFit.cover),
                    ),
                  ),
                ))
            .toList(),
        options: CarouselOptions(
          height: AppSize.size190,
          autoPlay: true,
          enableInfiniteScroll: true,
          enlargeCenterPage: true,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppPadding.padding12,
        left: AppPadding.padding12,
        right: AppPadding.padding12,
        bottom: AppPadding.padding2,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall,
      ),
    );
  }

  Widget _getServicesWidget(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.padding12,
          right: AppPadding.padding12,
        ),
        child: Container(
          height: AppSize.size160,
          margin: const EdgeInsets.symmetric(
            vertical: AppMargin.margin12,
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map(
                  (service) => Card(
                    elevation: AppSize.size4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSize.size12),
                      side: BorderSide(
                        color: ColorManager.white,
                        width: AppSize.size1,
                      ),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppSize.size12),
                          child: Image.network(
                            service.image,
                            fit: BoxFit.cover,
                            width: AppSize.size120,
                            height: AppSize.size120,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: AppPadding.padding8,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              service.title,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStoresWidget(List<Store>? stores) {
    if (stores != null) {
      return Padding(
        padding: const EdgeInsets.only(
          left: AppPadding.padding12,
          right: AppPadding.padding12,
          top: AppPadding.padding12,
        ),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisCount: AppSize.size2,
              crossAxisSpacing: AppSize.size8,
              mainAxisSpacing: AppSize.size8,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(stores.length, (index) {
                return InkWell(
                  onTap: () {
                    // navigate to store details screen
                    Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                  },
                  child: Card(
                    elevation: AppSize.size4,
                    child: Image.network(
                      stores[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
