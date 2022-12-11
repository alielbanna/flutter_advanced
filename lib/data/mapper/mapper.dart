import 'package:flutter_advanced/app/extensions.dart';
import 'package:flutter_advanced/data/response/responses.dart';
import 'package:flutter_advanced/domain/models/models.dart';
import 'package:flutter_advanced/app/constants.dart';

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id.orEmpty() ?? Constants.EMPTY,
      this?.name.orEmpty() ?? Constants.EMPTY,
      this?.numOfNotifications.orZero() ?? Constants.ZERO,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.phone.orEmpty() ?? Constants.EMPTY,
      this?.email.orEmpty() ?? Constants.EMPTY,
      this?.link.orEmpty() ?? Constants.EMPTY,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer.toDomain(),
      this?.contacts.toDomain(),
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? Constants.empty;
  }
}

extension ServiceResponseMapper on ServiceResponse? {
  Service toDomain() {
    return Service(
      this?.id.orZero() ?? Constants.ZERO,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension StoreResponseMapper on StoreResponse? {
  Store toDomain() {
    return Store(
      this?.id.orZero() ?? Constants.ZERO,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
    );
  }
}

extension BannersResponseMapper on BannersResponse? {
  BannerAd toDomain() {
    return BannerAd(
      this?.id.orZero() ?? Constants.ZERO,
      this?.title.orEmpty() ?? Constants.empty,
      this?.image.orEmpty() ?? Constants.empty,
      this?.link.orEmpty() ?? Constants.empty,
    );
  }
}

extension HomeResponseMapper on HomeResponse? {
  HomeObject toDomain() {
    List<Service> services = (this
                ?.data
                ?.services
                ?.map((serviceResponse) => serviceResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Service>()
        .toList();

    List<BannerAd> banners = (this
                ?.data
                ?.banners
                ?.map((bannersResponse) => bannersResponse.toDomain()) ??
            const Iterable.empty())
        .cast<BannerAd>()
        .toList();

    List<Store> stores = (this
                ?.data
                ?.stores
                ?.map((storesResponse) => storesResponse.toDomain()) ??
            const Iterable.empty())
        .cast<Store>()
        .toList();

    var data = HomeData(services, banners, stores);
    return HomeObject(data);
  }
}

extension StoreDetailsResponseMapper on StoreDetailsResponse? {
  StoreDetails toDomain() {
    return StoreDetails(
      this?.id?.orZero() ?? Constants.ZERO,
      this?.title?.orEmpty() ?? Constants.empty,
      this?.image?.orEmpty() ?? Constants.empty,
      this?.details?.orEmpty() ?? Constants.empty,
      this?.services?.orEmpty() ?? Constants.empty,
      this?.about?.orEmpty() ?? Constants.empty,
    );
  }
}
