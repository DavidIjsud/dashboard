import 'package:equatable/equatable.dart';
import 'package:petshopdashboard/core/base_view_model.dart' show BaseViewModel;
import 'package:petshopdashboard/models/category.dart';
import 'package:petshopdashboard/models/order.model.dart';
import 'package:petshopdashboard/models/product.model.dart';
import 'package:petshopdashboard/models/user.model.dart';
import 'package:petshopdashboard/modules/home/repositories/home_repository.dart';

enum HomeViewPages { users, orders, products }

class OrdersState extends Equatable {
  final bool isLoadingOrders;
  final List<OrderModel> orders;
  final bool ocurredErrorOnGetOrders;

  const OrdersState({this.isLoadingOrders = false, this.orders = const [], this.ocurredErrorOnGetOrders = false});

  @override
  List<Object?> get props => [isLoadingOrders, orders, ocurredErrorOnGetOrders];
}

class ProductsState extends Equatable {
  final bool isLoadingProducts;
  final List<ProductModel> products;
  final bool ocurredErrorOnGetProducts;
  final bool showProductDetail;
  final ProductModel? productDetail;

  const ProductsState({
    this.isLoadingProducts = false,
    this.products = const [],
    this.ocurredErrorOnGetProducts = false,
    this.showProductDetail = false,
    this.productDetail,
  });

  copyWith({
    bool? isLoadingProducts,
    List<ProductModel>? products,
    bool? ocurredErrorOnGetProducts,
    bool? showProductDetail,
    ProductModel? productDetail,
  }) {
    return ProductsState(
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      products: products ?? this.products,
      ocurredErrorOnGetProducts: ocurredErrorOnGetProducts ?? this.ocurredErrorOnGetProducts,
      showProductDetail: showProductDetail ?? this.showProductDetail,
      productDetail: productDetail ?? this.productDetail,
    );
  }

  @override
  List<Object?> get props => [isLoadingProducts, products, ocurredErrorOnGetProducts, showProductDetail, productDetail];
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
  HomeViewmodel({required HomeRepository homeRepository}) : _homeRepository = homeRepository;

  final HomeRepository _homeRepository;

  void initState() {
    setState(HomeState());
  }

  void setCurrentPage(HomeViewPages page) {
    setState(state?.copyWith(currentPage: page));
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
  }

  Future<void> getAllProducts() async {
    setState(
      state?.copyWith(
        productsState: ProductsState(isLoadingProducts: true, products: [], ocurredErrorOnGetProducts: false),
      ),
    );

    final responseProducts = await _homeRepository.getProducts();
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
}
