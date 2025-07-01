import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petshopdashboard/core/base_view_model.dart' show BaseViewModel;
import 'package:petshopdashboard/models/category.dart';
import 'package:petshopdashboard/models/order.model.dart';
import 'package:petshopdashboard/models/order_detail.model.dart';
import 'package:petshopdashboard/models/product.model.dart';
import 'package:petshopdashboard/models/user.model.dart';
import 'package:petshopdashboard/modules/home/repositories/home_repository.dart';
import 'package:petshopdashboard/services/images_picker/images_picker.dart';

enum HomeViewPages { users, orders, products }

class OrdersState extends Equatable {
  final bool isLoadingOrders;
  final List<OrderModel> orders;
  final bool ocurredErrorOnGetOrders;

  //TODO: by the momento these 3 lines are not used, in the future we can use them to show order details
  final bool isLoadingOrderDetails;
  final bool ocurredErrorOnGetOrderDetails;
  final List<OrderDetail> orderDetails;

  final bool showOrderDetail;
  final OrderModel? orderDetail;

  const OrdersState({
    this.isLoadingOrders = false,
    this.orders = const [],
    this.ocurredErrorOnGetOrders = false,
    this.isLoadingOrderDetails = false,
    this.ocurredErrorOnGetOrderDetails = false,
    this.orderDetails = const [],
    this.showOrderDetail = false,
    this.orderDetail,
  });

  OrdersState copyWith({
    bool? isLoadingOrders,
    List<OrderModel>? orders,
    bool? ocurredErrorOnGetOrders,
    bool? isLoadingOrderDetails,
    bool? ocurredErrorOnGetOrderDetails,
    List<OrderDetail>? orderDetails,
    bool? showOrderDetail,
    OrderModel? orderDetail,
  }) {
    return OrdersState(
      isLoadingOrders: isLoadingOrders ?? this.isLoadingOrders,
      orders: orders ?? this.orders,
      ocurredErrorOnGetOrders: ocurredErrorOnGetOrders ?? this.ocurredErrorOnGetOrders,
      isLoadingOrderDetails: isLoadingOrderDetails ?? this.isLoadingOrderDetails,
      ocurredErrorOnGetOrderDetails: ocurredErrorOnGetOrderDetails ?? this.ocurredErrorOnGetOrderDetails,
      orderDetails: orderDetails ?? this.orderDetails,
      showOrderDetail: showOrderDetail ?? this.showOrderDetail,
      orderDetail: orderDetail ?? this.orderDetail,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingOrders,
    orders,
    ocurredErrorOnGetOrders,
    isLoadingOrderDetails,
    ocurredErrorOnGetOrderDetails,
    orderDetails,
  ];
}

class ProductsState extends Equatable {
  final bool isLoadingProducts;
  final List<ProductModel> products;
  final bool ocurredErrorOnGetProducts;
  final bool showProductDetail;
  final ProductModel? productDetail;
  final XFile? fileToUpload;
  final bool isUpdatingProduct;
  final bool isSupendingProduct;

  const ProductsState({
    this.isLoadingProducts = false,
    this.products = const [],
    this.ocurredErrorOnGetProducts = false,
    this.showProductDetail = false,
    this.productDetail,
    this.fileToUpload,
    this.isUpdatingProduct = false,
    this.isSupendingProduct = false,
  });

  copyWith({
    bool? isLoadingProducts,
    List<ProductModel>? products,
    bool? ocurredErrorOnGetProducts,
    bool? showProductDetail,
    ProductModel? productDetail,
    XFile? fileToUpload,
    bool? isUpdatingProduct,
    bool? isSupendingProduct,
  }) {
    return ProductsState(
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      products: products ?? this.products,
      ocurredErrorOnGetProducts: ocurredErrorOnGetProducts ?? this.ocurredErrorOnGetProducts,
      showProductDetail: showProductDetail ?? this.showProductDetail,
      productDetail: productDetail ?? this.productDetail,
      fileToUpload: fileToUpload ?? this.fileToUpload,
      isUpdatingProduct: isUpdatingProduct ?? this.isUpdatingProduct,
      isSupendingProduct: isSupendingProduct ?? this.isSupendingProduct,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingProducts,
    products,
    ocurredErrorOnGetProducts,
    showProductDetail,
    productDetail,
    fileToUpload,
    isUpdatingProduct,
  ];
}

class HomeState extends Equatable {
  final bool isLoadingUsers;
  final List<UserModel> users;
  final bool ocurredErrorOnGetUsers;
  final OrdersState ordersState;
  final ProductsState productsState;
  final HomeViewPages currentPage;
  final List<Category> categories;

  const HomeState({
    this.isLoadingUsers = false,
    this.users = const [],
    this.ocurredErrorOnGetUsers = false,
    this.ordersState = const OrdersState(isLoadingOrders: false, orders: [], ocurredErrorOnGetOrders: false),
    this.productsState = const ProductsState(isLoadingProducts: false, products: [], ocurredErrorOnGetProducts: false),
    this.currentPage = HomeViewPages.products,
    this.categories = const [],
  });

  copyWith({
    bool? isLoadingUsers,
    List<UserModel>? users,
    bool? ocurredErrorOnGetUsers,
    OrdersState? ordersState,
    ProductsState? productsState,
    HomeViewPages? currentPage,
    List<Category>? categories,
  }) {
    return HomeState(
      isLoadingUsers: isLoadingUsers ?? this.isLoadingUsers,
      users: users ?? this.users,
      ocurredErrorOnGetUsers: ocurredErrorOnGetUsers ?? this.ocurredErrorOnGetUsers,
      ordersState: ordersState ?? this.ordersState,
      productsState: productsState ?? this.productsState,
      currentPage: currentPage ?? this.currentPage,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
    isLoadingUsers,
    users,
    ocurredErrorOnGetUsers,
    ordersState,
    productsState,
    currentPage,
    categories,
  ];

  Category getCategoryById(String id) => categories.firstWhere((category) => category.id == id);
}

class HomeViewmodel extends BaseViewModel<HomeState> {
  HomeViewmodel({required HomeRepository homeRepository, required ImagesPicker imagesPicker})
    : _homeRepository = homeRepository,
      _imagesPicker = imagesPicker;

  final HomeRepository _homeRepository;
  final ImagesPicker _imagesPicker;

  void initState() {
    setState(HomeState());
  }

  void setCurrentPage(HomeViewPages page) {
    setState(state?.copyWith(currentPage: page));
  }

  void showOrderDetail(OrderModel? order) {
    if (order == null) return;
    setState(state?.copyWith(ordersState: state?.ordersState.copyWith(showOrderDetail: true, orderDetail: order)));
  }

  void hideOrderDetail() {
    setState(state?.copyWith(ordersState: state?.ordersState.copyWith(showOrderDetail: false, orderDetail: null)));
  }

  void showProductDetail(ProductModel? product) {
    if (product == null) return;
    setState(
      state?.copyWith(productsState: state?.productsState.copyWith(showProductDetail: true, productDetail: product)),
    );
  }

  void hideProductDetail() {
    setState(
      state?.copyWith(productsState: state?.productsState.copyWith(showProductDetail: false, productDetail: null)),
    );
    removeImage();
  }

  Future<void> pickImage() async {
    final image = await _imagesPicker.pickImage();
    if (image != null && _imagesPicker.isCorrectImageMimeType(image.mimeType!)) {
      print('Image picked: ${image.path} and mime type is ${image.mimeType}');
      setState(state?.copyWith(productsState: state?.productsState.copyWith(fileToUpload: image)));
    }
  }

  Future<void> removeImage() async {
    setState(state?.copyWith(productsState: state?.productsState.copyWith(fileToUpload: null)));
  }

  String _getImageType(String? mimeType) {
    if (mimeType == null) return '';
    return mimeType.split('/').last;
  }

  Future<void> updateProduct({
    required String id,
    required String name,
    required num price,
    required int totalInStock,
    required String detailOfProduct,
    required String categoryId,
  }) async {
    setState(state?.copyWith(productsState: state?.productsState.copyWith(isUpdatingProduct: true)));

    final response = await _homeRepository.updateProduct(
      id: id,
      name: name,
      price: price,
      totalInStock: totalInStock,
      detailOfProduct: detailOfProduct,
      categoryId: categoryId,
      imageFile: state?.productsState.fileToUpload,
    );

    response.fold(
      (fail) {
        print('Error: ${fail.failure.toString()}');
        setState(state?.copyWith(productsState: state?.productsState.copyWith(isUpdatingProduct: false)));
      },
      (success) {
        setState(state?.copyWith(productsState: state?.productsState.copyWith(isUpdatingProduct: false)));
        getAllProducts();
        hideProductDetail();
      },
    );
  }

  Future<void> getAllProducts({
    String? searchTerm,
    String? selectedCategoryId,
    int? stockMin,
    int? stockMax,
    double? priceMin,
    double? priceMax,
    bool? isSuspended,
  }) async {
    setState(
      state?.copyWith(
        productsState: ProductsState(isLoadingProducts: true, products: [], ocurredErrorOnGetProducts: false),
      ),
    );

    final responseProducts = await _homeRepository.getProducts(
      searchTerm: searchTerm,
      selectedCategoryId: selectedCategoryId,
      stockMin: stockMin,
      stockMax: stockMax,
      priceMin: priceMin,
      priceMax: priceMax,
      isSuspended: isSuspended,
    );
    final responseCategories = await _homeRepository.getCategories();

    responseProducts.fold(
      (fail) {
        print('Error: $fail');
        setState(
          state?.copyWith(
            productsState: ProductsState(isLoadingProducts: false, products: [], ocurredErrorOnGetProducts: true),
          ),
        );
      },
      (products) {
        responseCategories.fold(
          (fail) {
            setState(
              state?.copyWith(
                productsState: ProductsState(isLoadingProducts: false, products: [], ocurredErrorOnGetProducts: true),
              ),
            );
          },
          (categories) => setState(
            state?.copyWith(
              productsState: ProductsState(
                isLoadingProducts: false,
                products: products,
                ocurredErrorOnGetProducts: false,
              ),
              categories: categories,
            ),
          ),
        );
      },
    );
  }

  Future<void> getAllOrders() async {
    setState(
      state?.copyWith(ordersState: OrdersState(isLoadingOrders: true, orders: [], ocurredErrorOnGetOrders: false)),
    );

    final responseOrders = await _homeRepository.getOrders();

    responseOrders.fold(
      (fail) {
        setState(
          state?.copyWith(ordersState: OrdersState(isLoadingOrders: false, orders: [], ocurredErrorOnGetOrders: true)),
        );
      },
      (orders) => setState(
        state?.copyWith(
          ordersState: OrdersState(isLoadingOrders: false, orders: orders, ocurredErrorOnGetOrders: false),
        ),
      ),
    );
  }

  Future<void> getAllUsers() async {
    setState(state?.copyWith(isLoadingUsers: true, ocurredErrorOnGetUsers: false));

    final responseUsers = await _homeRepository.getUsers();

    responseUsers.fold((fail) {
      setState(state?.copyWith(isLoadingUsers: false, ocurredErrorOnGetUsers: true));
    }, (users) => setState(state?.copyWith(isLoadingUsers: false, users: users)));
  }

  Future<void> suspendProduct(String id, bool suspendProduct) async {
    setState(state?.copyWith(productsState: state?.productsState.copyWith(isSupendingProduct: true)));
    final response = await _homeRepository.suspendProduct(id, suspendProduct);
    setState(state?.copyWith(productsState: state?.productsState.copyWith(isSupendingProduct: false)));
    response.fold(
      (fail) {
        print('Error suspending product: ${fail.failure.toString()}');
      },
      (success) {
        getAllProducts();
        hideProductDetail();
      },
    );
  }

  Future<void> getOrderDetailsByOrderId(String orderId) async {
    // Set loading state
    setState(
      state?.copyWith(
        ordersState: state?.ordersState.copyWith(
          isLoadingOrderDetails: true,
          ocurredErrorOnGetOrderDetails: false,
          orderDetails: [],
        ),
      ),
    );

    final response = await _homeRepository.getOrderDetails(orderId);

    response.fold(
      (fail) {
        setState(
          state?.copyWith(
            ordersState: state?.ordersState.copyWith(
              isLoadingOrderDetails: false,
              ocurredErrorOnGetOrderDetails: true,
              orderDetails: [],
            ),
          ),
        );
      },
      (orderDetails) {
        setState(
          state?.copyWith(
            ordersState: state?.ordersState.copyWith(
              isLoadingOrderDetails: false,
              ocurredErrorOnGetOrderDetails: false,
              orderDetails: orderDetails,
            ),
          ),
        );
      },
    );
  }
}
