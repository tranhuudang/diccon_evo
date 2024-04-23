enum IAPProductIds { starter_try, daily_use, life_time }

class IAPProducts {
  static Set<String> productIds = {
    IAPProductIds.starter_try.name,
    IAPProductIds.daily_use.name,
    IAPProductIds.life_time.name
  };
}
