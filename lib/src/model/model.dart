import 'package:cln_common/cln_common.dart';

class DoctorRequest extends Serializable {
  final String invoice;

  DoctorRequest(this.invoice);

  @override
  T as<T>() {
    return this as T;
  }

  ListPaysRequest toListPaysRequest() => ListPaysRequest(invoice);

  ListFundsRequest toListFundsRequest() => ListFundsRequest();

  // TODO implement autogenerator
  factory DoctorRequest.fromJson(Map<String, dynamic> json) {
    return DoctorRequest("");
  }

  @override
  Map<String, dynamic> toJSON() => {};
}

class ListPaysRequest extends Serializable {
  final String invoice;

  ListPaysRequest(this.invoice);

  // TODO implement autogenerator
  factory ListPaysRequest.fromJson(Map<String, dynamic> json) {
    return ListPaysRequest("");
  }

  @override
  Map<String, dynamic> toJSON() => {};
}

class ListFundsRequest extends Serializable {
  ListFundsRequest();

  @override
  Map<String, dynamic> toJSON() => {};
}

class PayRequest extends Serializable {
  PayRequest();

  factory PayRequest.fromJson(Map<String, dynamic> json) {
    return PayRequest();
  }

  @override
  Map<String, dynamic> toJSON() => {};
}
