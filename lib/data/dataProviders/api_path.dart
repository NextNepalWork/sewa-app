enum APIPath {
  getBanners,
  categories,
  latestProduct,
  featuredProduct,
  updateTransaction,
  categoryProduct,
  subCategoryProduct,
  subSubCategoryProduct,
  subCategory,
  childCategory,
  productDetail,
  relatedProduct,
  shopDetail,
  shopFeatured,
  shopTop,
  shopNew,
  shopAll,
  shopBrands,
  addToCart,
  getFromCart,
  deleteFromCart,
  getAddress,
  addAddress,
  getDefaultAddress,
  deleteAddress,
  searchProduct,
  topBrand,
  topBrandProduct,
  homeSlider,
  flashSale,
  login,
  socialLogin,
  register,
  logout,
  changePassword,
  forgotPassword,
  placeOrder,
  getUser,
  updateUser,
  purchaseHistory,
  trackOrder,
  purchaseHistoryDetail,
  getWishlist,
  deleteWishlist,
  checkWishlist,
  addToWishlist,
  getVariantPrice,
  getGeneralSetting,
  faq,
  cancelOrder,
  notifications,
  returnPolicy,
  privacyPolicy,
  termsAndConditions,
  district,
  deliveryLocation,
  deliveryCharge,
  searchShopProduct,
}

class APIPathHelper {
  static String getValue(APIPath path) {
    switch (path) {
      case APIPath.getBanners:
        return "banners";
      case APIPath.faq:
        return "faq";
      case APIPath.notifications:
        return "notifications";
      case APIPath.categories:
        return "categories";
      case APIPath.latestProduct:
        return "products";
      case APIPath.featuredProduct:
        return "products/featured";
      case APIPath.categoryProduct:
        return "products/category/";
      case APIPath.subCategory:
        return "sub-categories/";
      case APIPath.childCategory:
        return "sub-sub-categories/";
      case APIPath.productDetail:
        return "products/";
      case APIPath.relatedProduct:
        return "products/related/";
      case APIPath.updateTransaction:
        return "purchase-history/update-transaction";
      case APIPath.shopDetail:
        return "shops/details/";
      case APIPath.shopFeatured:
        return "shops/products/featured/";
      case APIPath.shopTop:
        return "shops/products/top/";
      case APIPath.shopNew:
        return "shops/products/new/";
      case APIPath.shopAll:
        return "shops/products/all/";
      case APIPath.shopBrands:
        return "shops/products/brands/";
      case APIPath.addToCart:
        return "carts/add";
      case APIPath.getFromCart:
        return "carts/";
      case APIPath.addAddress:
        return "addresses";
      case APIPath.getDefaultAddress:
        return "addresses/set_default/";
      case APIPath.deleteAddress:
        return "addresses/";
      case APIPath.getAddress:
        return "addresses";
      case APIPath.searchProduct:
        return "products/search";
      case APIPath.topBrand:
        return "brands";
      case APIPath.topBrandProduct:
        return "products/brand/";
      case APIPath.homeSlider:
        return "sliders";
      case APIPath.flashSale:
        return "products/flash-deal";
      case APIPath.login:
        return "auth/login";
      case APIPath.socialLogin:
        return "auth/social-login";
      case APIPath.register:
        return "auth/signup";
      case APIPath.logout:
        return "auth/logout";
      case APIPath.placeOrder:
        return "order/store";
      case APIPath.getUser:
        return "auth/user";
      case APIPath.updateUser:
        return "user/info/update";
      case APIPath.changePassword:
        return "auth/change-password";
      case APIPath.forgotPassword:
        return "auth/password/create";
      case APIPath.purchaseHistory:
        return "purchase-history/";
      case APIPath.cancelOrder:
        return "purchase-history/cancel";
      case APIPath.trackOrder:
        return "order/";
      case APIPath.purchaseHistoryDetail:
        return "purchase-history-details/";
      case APIPath.getWishlist:
        return "wishlists/";
      case APIPath.deleteWishlist:
        return "wishlists/";
      case APIPath.addToWishlist:
        return "wishlists";
      case APIPath.checkWishlist:
        return "wishlists/check-product";
      case APIPath.deleteFromCart:
        return "carts/";
      case APIPath.subCategoryProduct:
        return "products/sub-category/";
      case APIPath.subSubCategoryProduct:
        return "products/sub-sub-category/";
      case APIPath.getVariantPrice:
        return "products/variant/price";
      case APIPath.getGeneralSetting:
        return "business-settings";
      case APIPath.privacyPolicy:
        return "policies/privacy";
      case APIPath.returnPolicy:
        return "policies/return";
      case APIPath.termsAndConditions:
        return "policies/terms";
      case APIPath.district:
        return "districts";
      case APIPath.deliveryLocation:
        return "locations/";
      case APIPath.deliveryCharge:
        return "getlocation/";
      case APIPath.searchShopProduct:
        return "shop/search";

      default:
        return "";
    }
  }
}
