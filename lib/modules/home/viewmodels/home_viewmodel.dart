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
  final List<OrderModel> allOrders; // <-- Add this line
  final bool ocurredErrorOnGetOrders;

  //TODO: by the momento these 3 lines are not used, in the future we can use them to show order details
  final bool isLoadingOrderDetails;
  final bool ocurredErrorOnGetOrderDetails;
  final List<OrderDetail> orderDetails;

  final bool showOrderDetail;
  final OrderModel? orderDetail;

  final bool isUpdatingOrderStatus; // <-- Add this line

  const OrdersState({
    this.isLoadingOrders = false,
    this.orders = const [],
    this.allOrders = const [], // <-- Add this line
    this.ocurredErrorOnGetOrders = false,
    this.isLoadingOrderDetails = false,
    this.ocurredErrorOnGetOrderDetails = false,
    this.orderDetails = const [],
    this.showOrderDetail = false,
    this.orderDetail,
    this.isUpdatingOrderStatus = false, // <-- Add this line
  });

  OrdersState copyWith({
    bool? isLoadingOrders,
    List<OrderModel>? orders,
    List<OrderModel>? allOrders, // <-- Add this line
    bool? ocurredErrorOnGetOrders,
    bool? isLoadingOrderDetails,
    bool? ocurredErrorOnGetOrderDetails,
    List<OrderDetail>? orderDetails,
    bool? showOrderDetail,
    OrderModel? orderDetail,
    bool? isUpdatingOrderStatus, // <-- Add this line
  }) {
    return OrdersState(
      isLoadingOrders: isLoadingOrders ?? this.isLoadingOrders,
      orders: orders ?? this.orders,
      allOrders: allOrders ?? this.allOrders, // <-- Add this line
      ocurredErrorOnGetOrders: ocurredErrorOnGetOrders ?? this.ocurredErrorOnGetOrders,
      isLoadingOrderDetails: isLoadingOrderDetails ?? this.isLoadingOrderDetails,
      ocurredErrorOnGetOrderDetails: ocurredErrorOnGetOrderDetails ?? this.ocurredErrorOnGetOrderDetails,
      orderDetails: orderDetails ?? this.orderDetails,
      showOrderDetail: showOrderDetail ?? this.showOrderDetail,
      orderDetail: orderDetail ?? this.orderDetail,
      isUpdatingOrderStatus: isUpdatingOrderStatus ?? this.isUpdatingOrderStatus, // <-- Add this line
    );
  }

  @override
  List<Object?> get props => [
    isLoadingOrders,
    orders,
    allOrders, // <-- Add this line
    ocurredErrorOnGetOrders,
    isLoadingOrderDetails,
    ocurredErrorOnGetOrderDetails,
    orderDetails,
    isUpdatingOrderStatus, // <-- Add this line
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
  final bool isCreatingNewProduct;

  const ProductsState({
    this.isLoadingProducts = false,
    this.products = const [],
    this.ocurredErrorOnGetProducts = false,
    this.showProductDetail = false,
    this.productDetail,
    this.fileToUpload,
    this.isUpdatingProduct = false,
    this.isSupendingProduct = false,
    this.isCreatingNewProduct = false,
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
    bool? isCreatingNewProduct,
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
      isCreatingNewProduct: isCreatingNewProduct ?? this.isCreatingNewProduct,
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
    isSupendingProduct,
    isCreatingNewProduct,
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

  Future<XFile?> pickImageToCreateProduct() async {
    final image = await _imagesPicker.pickImage();
    if (image != null && _imagesPicker.isCorrectImageMimeType(image.mimeType!)) {
      return image;
    }
    return null;
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

  Future<void> createProduct({
    required String productName,
    required num price,
    required int totalInStock,
    required String detailOfProduct,
    required String categoryId,
    required XFile image, // <-- Not optional anymore
  }) async {
    setState(state?.copyWith(productsState: state?.productsState.copyWith(isCreatingNewProduct: true)));

    final response = await _homeRepository.createProduct(
      name: productName,
      price: price,
      totalInStock: totalInStock,
      detailOfProduct: detailOfProduct,
      categoryId: categoryId,
      imageFile: image, // <-- Not optional anymore
    );

    response.fold(
      (fail) {
        print('Error creating product: ${fail.failure.toString()}');
        setState(state?.copyWith(productsState: state?.productsState.copyWith(isCreatingNewProduct: false)));
      },
      (success) {
        setState(state?.copyWith(productsState: state?.productsState.copyWith(isCreatingNewProduct: false)));
        if (success) {
          getAllProducts();
        }
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

  Future<void> getAllOrders({String? searchTermName, DateTime? dateOrdersCreated, String? orderStatus}) async {
    setState(
      state?.copyWith(
        ordersState: OrdersState(isLoadingOrders: true, orders: [], allOrders: [], ocurredErrorOnGetOrders: false),
      ),
    );

    final responseOrders = await _homeRepository.getOrders(
      searchTermName: searchTermName,
      dateOrdersCreated: dateOrdersCreated,
      orderStatus: orderStatus,
    );

    responseOrders.fold(
      (fail) {
        setState(
          state?.copyWith(
            ordersState: OrdersState(isLoadingOrders: false, orders: [], allOrders: [], ocurredErrorOnGetOrders: true),
          ),
        );
      },
      (orders) => setState(
        state?.copyWith(
          ordersState: OrdersState(
            isLoadingOrders: false,
            orders: orders,
            allOrders: orders, // Save all orders for filtering
            ocurredErrorOnGetOrders: false,
          ),
        ),
      ),
    );
  }

  void filterOrdersByStatus(String status) {
    final allOrders = state?.ordersState.allOrders ?? [];
    final filtered =
        allOrders.where((order) {
          print(
            'Filtering order: ${order.id} with status: ${order.status.toString().split('.').last} and the status is $status',
          );
          return order.status.toString().split('.').last == status;
        }).toList();
    setState(state?.copyWith(ordersState: state?.ordersState.copyWith(orders: filtered)));
  }

  void clearOrderStatusFilter() {
    setState(state?.copyWith(ordersState: state?.ordersState.copyWith(orders: state?.ordersState.allOrders)));
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

  Future<void> updateOrderPaymentStatus(String orderId, String newStatus) async {
    setState(state?.copyWith(ordersState: state?.ordersState.copyWith(isUpdatingOrderStatus: true)));

    final response = await _homeRepository.updatePaymentStatu(orderId, newStatus);
    response.fold(
      (fail) {
        print('Error updating order status: ${fail.failure.toString()}');
        setState(state?.copyWith(ordersState: state?.ordersState.copyWith(isUpdatingOrderStatus: false)));
      },
      (success) {
        setState(state?.copyWith(ordersState: state?.ordersState.copyWith(isUpdatingOrderStatus: false)));
        if (success) {
          getAllOrders();
        }
      },
    );
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    setState(state?.copyWith(ordersState: state?.ordersState.copyWith(isUpdatingOrderStatus: true)));

    final response = await _homeRepository.updateOrderStatu(orderId, newStatus);
    response.fold(
      (fail) {
        print('Error updating order status: ${fail.failure.toString()}');
        setState(state?.copyWith(ordersState: state?.ordersState.copyWith(isUpdatingOrderStatus: false)));
      },
      (success) {
        setState(state?.copyWith(ordersState: state?.ordersState.copyWith(isUpdatingOrderStatus: false)));
        if (success) {
          getAllOrders();
        }
      },
    );
  }
}
