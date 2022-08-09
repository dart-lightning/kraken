import 'package:cln_common/cln_common.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class DoctorRequest extends Serializable {
  final String bolt11;

  DoctorRequest(this.bolt11);

  @override
  T as<T>() {
    return this as T;
  }

  ListPaysRequest toListPaysRequest() => ListPaysRequest(bolt11);

  ListFundsRequest toListFundsRequest() => ListFundsRequest();

  // TODO implement autogenerator
  factory DoctorRequest.fromJson(Map<String, dynamic> json) =>
      _$DoctorRequestFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$DoctorRequestToJson(this);
}

@JsonSerializable()
class ListPaysRequest extends Serializable {
  final String bolt11;

  ListPaysRequest(this.bolt11);

  factory ListPaysRequest.fromJson(Map<String, dynamic> json) =>
      _$ListPaysRequestFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$ListPaysRequestToJson(this);
}

@JsonSerializable()
class ListFundsRequest extends Serializable {
  ListFundsRequest();

  factory ListFundsRequest.fromJson(Map<String, dynamic> json) =>
      _$ListFundsRequestFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$ListFundsRequestToJson(this);
}

@JsonSerializable()
class PayRequest extends Serializable {
  String bolt11;

  PayRequest(this.bolt11);

  factory PayRequest.fromJson(Map<String, dynamic> json) =>
      _$PayRequestFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$PayRequestToJson(this);
}

@JsonSerializable()
class PayResponse extends Serializable {
  @JsonKey(name: "payment_preimage")
  final String paymentPreimage;
  @JsonKey(name: "payment_hash")
  final String paymentHash;
  @JsonKey(name: "created_at")
  final int createdAt;
  final int parts;
  final String status;
  final String destination;

  factory PayResponse.fromJson(Map<String, dynamic> json) =>
      _$PayResponseFromJson(json);

  PayResponse(this.paymentPreimage, this.paymentHash, this.createdAt,
      this.parts, this.status, this.destination);

  @override
  Map<String, dynamic> toJSON() => _$PayResponseToJson(this);
}

@JsonSerializable()
class FetchInvoiceRequest extends Serializable {
  String offer;
  String? msamsatoshi;

  FetchInvoiceRequest({required this.offer, this.msamsatoshi});

  factory FetchInvoiceRequest.fromJson(Map<String, dynamic> json) =>
      _$FetchInvoiceRequestFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$FetchInvoiceRequestToJson(this);
}

@JsonSerializable()
class FetchInvoiceResponse extends Serializable {
  String invoice;

  FetchInvoiceResponse(this.invoice);

  factory FetchInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$FetchInvoiceResponseFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$FetchInvoiceResponseToJson(this);
}
