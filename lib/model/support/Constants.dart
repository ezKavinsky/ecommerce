class Constants {
  // app info
  static final String APP_VERSION = "0.0.1";
  static final String APP_NAME = "SitoECommerce";

  // addresses
  static final String ADDRESS_STORE_SERVER = "localhost:8081";
  static final String ADDRESS_AUTHENTICATION_SERVER = "localhost:8080";

  // authentication
  static final String REALM = "store";
  static final String CLIENT_ID = "store-flutter";
  static final String REQUEST_LOGIN = "realms/" + REALM + "/protocol/openid-connect/token";
  static final String REQUEST_LOGOUT = "realms/" + REALM + "/protocol/openid-connect/logout";

  // requests
  static final String REQUEST_SEARCH_PRODUCTS = "/products/search/by_name";
  static final String REQUEST_ADD_USER = "/users";
  static final String REQUEST_PROMOS = "/promos";
  static final String REQUEST_PRODUCT= "/products/";
  static final String ADD_PRODUCT_IN_CART = "/cart";
  static final String REQUEST_REVIEWS = "/reviews";
  static final String REQUEST_PRODUCTS_IN_PROMO = "/productsInPromo";


  // states
  static final String STATE_CLUB = "club";

  // responses
  static final String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS = "ERROR_MAIL_USER_ALREADY_EXISTS";
  static final String RESPONSE_ERROR_PRODUCT_NOT_FOUND = "ERROR_PRODUCT_NOT_FOUND";

  // messages
  static final String MESSAGE_CONNECTION_ERROR = "connection_error";


}