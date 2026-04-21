import 'package:flutter_bloc/flutter_bloc.dart';

class BookingState {
  final String? vehicle;
  final String? service;
  final String? shop;
  final double? price;
  final String? bookingType; // e.g., 'standard', 'complete_set'

  BookingState({this.vehicle, this.service, this.shop, this.price, this.bookingType = 'standard'});

  BookingState copyWith({String? vehicle, String? service, String? shop, double? price, String? bookingType}) {
    return BookingState(
      vehicle: vehicle ?? this.vehicle,
      service: service ?? this.service,
      shop: shop ?? this.shop,
      price: price ?? this.price,
      bookingType: bookingType ?? this.bookingType,
    );
  }
}

class BookingBloc extends Cubit<BookingState> {
  BookingBloc() : super(BookingState());

  void setVehicle(String vehicle) => emit(state.copyWith(vehicle: vehicle));
  void setService(String service, double price) => emit(state.copyWith(service: service, price: price));
  void setShop(String shop) => emit(state.copyWith(shop: shop));
  void setBookingType(String type) => emit(state.copyWith(bookingType: type));
}
