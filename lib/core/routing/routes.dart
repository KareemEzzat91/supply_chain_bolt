class Routes {
  // Auth Routes
  static const String start = '/';
  static const String loginScreen = '/login';
  static const String managerLoginScreen = '/manager-login';
  static const String managerSignupScreen = '/manager-signup';
  static const String distributorLoginScreen = '/distributor-login';
  static const String distributorSignupScreen = '/distributor-signup';

  // Main Routes
  static const String main = '/main';
  static const String managerMain = '/manager-main';
  static const String distributorMain = '/distributor-main';

  // Feature Routes
  static const String orderListPage = '/orders';
  static const String orderDetailsScreen = '/order-details';
  static const String scanScreen = '/scan';
  static const String scanSuccessScreen = '/scan-success';
  static const String profileScreen = '/profile';
  static const String notificationsScreen = '/notifications';

  // Manager Routes
  static const String managerHome = '/manager-home';
  static const String orderList = '/manager/orders';
  static const String createOrder = '/manager/orders/create';
  static const String orderDetails = '/manager/orders/:id';
  static const String distributorList = '/manager/distributors';
  static const String addDistributor = '/manager/distributors/add';
  static const String distributorDetails = '/manager/distributors/:id';
  static const String inventory = '/manager/inventory';
  static const String addProduct = '/manager/inventory/add';
  static const String editProduct = '/manager/inventory/:id/edit';
  static const String reports = '/manager/reports';
  static const String activityLog = '/manager/activities';
  static const String settings = '/manager/settings';
  static const String profile = '/manager/profile';

  // Distributor Routes
  static const String distributorHome = '/distributor-home';
  static const String taskList = '/distributor/tasks';
  static const String taskDetails = '/distributor/tasks/:id';
  static const String scan = '/distributor/scan';
  static const String notifications = '/notifications';
  static const String distributorProfile = '/distributor/profile';

  // Common Routes
  static const String chat = '/chat/:id';
  static const String map = '/map';
  static const String help = '/help';
}
