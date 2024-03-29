// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DoctorRequest _$DoctorRequestFromJson(Map<String, dynamic> json) =>
    DoctorRequest(
      json['bolt11'] as String,
    );

Map<String, dynamic> _$DoctorRequestToJson(DoctorRequest instance) =>
    <String, dynamic>{
      'bolt11': instance.bolt11,
    };

PaysStatusRequest _$PaysStatusRequestFromJson(Map<String, dynamic> json) =>
    PaysStatusRequest(
      json['bolt11'] as String,
    );

Map<String, dynamic> _$PaysStatusRequestToJson(PaysStatusRequest instance) =>
    <String, dynamic>{
      'bolt11': instance.bolt11,
    };

ListFundsRequest _$ListFundsRequestFromJson(Map<String, dynamic> json) =>
    ListFundsRequest();

Map<String, dynamic> _$ListFundsRequestToJson(ListFundsRequest instance) =>
    <String, dynamic>{};

PayRequest _$PayRequestFromJson(Map<String, dynamic> json) => PayRequest(
      json['bolt11'] as String,
    );

Map<String, dynamic> _$PayRequestToJson(PayRequest instance) =>
    <String, dynamic>{
      'bolt11': instance.bolt11,
    };

PayResponse _$PayResponseFromJson(Map<String, dynamic> json) => PayResponse(
      json['payment_preimage'] as String,
      json['payment_hash'] as String,
      json['created_at'] as int,
      json['parts'] as int,
      json['status'] as String,
      json['destination'] as String,
    );

Map<String, dynamic> _$PayResponseToJson(PayResponse instance) =>
    <String, dynamic>{
      'payment_preimage': instance.paymentPreimage,
      'payment_hash': instance.paymentHash,
      'created_at': instance.createdAt,
      'parts': instance.parts,
      'status': instance.status,
      'destination': instance.destination,
    };

FetchInvoiceRequest _$FetchInvoiceRequestFromJson(Map<String, dynamic> json) =>
    FetchInvoiceRequest(
      offer: json['offer'] as String,
      msatoshi: json['msatoshi'] as String?,
      amountMsat: json['amount_msat'] as int?,
    );

Map<String, dynamic> _$FetchInvoiceRequestToJson(FetchInvoiceRequest instance) {
  final val = <String, dynamic>{
    'offer': instance.offer,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('msatoshi', instance.msatoshi);
  writeNotNull('amount_msat', instance.amountMsat);
  return val;
}

FetchInvoiceResponse _$FetchInvoiceResponseFromJson(
        Map<String, dynamic> json) =>
    FetchInvoiceResponse(
      json['invoice'] as String,
    );

Map<String, dynamic> _$FetchInvoiceResponseToJson(
        FetchInvoiceResponse instance) =>
    <String, dynamic>{
      'invoice': instance.invoice,
    };
