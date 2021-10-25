class CaseDetailsLists {
  Header header;
  CaseDetails caseDetails;

  CaseDetailsLists({this.header, this.caseDetails});

  CaseDetailsLists.fromJson(Map<String, dynamic> json) {
    header =
    json['header'] != null ? new Header.fromJson(json['header']) : null;
    caseDetails = json['caseDetails'] != null
        ? new CaseDetails.fromJson(json['caseDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    if (this.caseDetails != null) {
      data['caseDetails'] = this.caseDetails.toJson();
    }
    return data;
  }
}

class Header {
  String status;
  String statusCode;
  String statusMessage;

  Header({this.status, this.statusCode, this.statusMessage});

  Header.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    statusMessage = json['statusMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['statusMessage'] = this.statusMessage;
    return data;
  }
}

class CaseDetails {
  String attroneyName;
  String phoneNumber;
  int episodeId;
  int patientId;
  String accidentDate;
  String stateName;
  String claimNumber;
  String payerName;
  int payerId;
  String planName;

  CaseDetails(
      {this.attroneyName,
        this.phoneNumber,
        this.episodeId,
        this.patientId,
        this.accidentDate,
        this.stateName,
        this.claimNumber,
        this.payerName,
        this.payerId,
        this.planName});

  CaseDetails.fromJson(Map<String, dynamic> json) {
    attroneyName = json['attroneyName'];
    phoneNumber = json['phoneNumber'];
    episodeId = json['episodeId'];
    patientId = json['patientId'];
    accidentDate = json['accidentDate'];
    stateName = json['stateName'];
    claimNumber = json['claimNumber'];
    payerName = json['payerName'];
    payerId = json['payerId'];
    planName = json['planName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attroneyName'] = this.attroneyName;
    data['phoneNumber'] = this.phoneNumber;
    data['episodeId'] = this.episodeId;
    data['patientId'] = this.patientId;
    data['accidentDate'] = this.accidentDate;
    data['stateName'] = this.stateName;
    data['claimNumber'] = this.claimNumber;
    data['payerName'] = this.payerName;
    data['payerId'] = this.payerId;
    data['planName'] = this.planName;
    return data;
  }
}