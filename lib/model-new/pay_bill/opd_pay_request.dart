class OpdPayRequest {
  String? invoiceId;
  String? payAmt;
  String? orderId;

  OpdPayRequest({
    this.invoiceId,
    this.payAmt,
    this.orderId,
  });

  OpdPayRequest.fromJson(Map<String, dynamic> json) {
    invoiceId = json['invoiceId'];
    payAmt = json['payAmt'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['invoiceId'] = this.invoiceId;
    data['payAmt'] = this.payAmt;
    data['order_id'] = this.orderId;
    return data;
  }
}
