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

  PaysStatusRequest toPaysStatusRequest() => PaysStatusRequest(bolt11);

  ListFundsRequest toListFundsRequest() => ListFundsRequest();

  factory DoctorRequest.fromJson(Map<String, dynamic> json) =>
      _$DoctorRequestFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$DoctorRequestToJson(this);
}

@JsonSerializable()
class PaysStatusRequest extends Serializable {
  final String bolt11;

  PaysStatusRequest(this.bolt11);

  factory PaysStatusRequest.fromJson(Map<String, dynamic> json) =>
      _$PaysStatusRequestFromJson(json);

  @override
  Map<String, dynamic> toJSON() => _$PaysStatusRequestToJson(this);
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

@JsonSerializable(includeIfNull: false)
class FetchInvoiceRequest extends Serializable {
  String offer;
  String? msatoshi;
  @JsonKey(name: "amount_msat")
  int? amountMsat;

  FetchInvoiceRequest({required this.offer, this.msatoshi, this.amountMsat});

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
