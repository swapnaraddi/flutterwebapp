class GetSearchedPatients {
  Header header;
  PagingInfo pagingInfo;
  List<PatientList> patientList;
  List<CaseDetailsList> caseDetailsList;
  PatientDetails patientDetails;

  GetSearchedPatients({this.header, this.pagingInfo, this.patientList, this.caseDetailsList, this.patientDetails});

  GetSearchedPatients.fromJson(Map<String, dynamic> json) {
    header = json['header'] != null ? new Header.fromJson(json['header']) : null;
    pagingInfo = json['pagingInfo'] != null ? new PagingInfo.fromJson(json['pagingInfo']) : null;
    if (json['patientList'] != null) {
      patientList = new List<PatientList>();
      json['patientList'].forEach((v) { patientList.add(new PatientList.fromJson(v)); });
    }
    if (json['caseDetailsList'] != null) {
      caseDetailsList = new List<CaseDetailsList>();
      json['caseDetailsList'].forEach((v) { caseDetailsList.add(new CaseDetailsList.fromJson(v)); });
    }
    patientDetails = json['patientDetails'] != null ? new PatientDetails.fromJson(json['patientDetails']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    if (this.pagingInfo != null) {
      data['pagingInfo'] = this.pagingInfo.toJson();
    }
    if (this.patientList != null) {
      data['patientList'] = this.patientList.map((v) => v.toJson()).toList();
    }
    if (this.caseDetailsList != null) {
      data['caseDetailsList'] = this.caseDetailsList.map((v) => v.toJson()).toList();
    }
    if (this.patientDetails != null) {
      data['patientDetails'] = this.patientDetails.toJson();
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

class PagingInfo {
  int totalItems;
  int itemsPerPage;
  int currentPage;

  PagingInfo({this.totalItems, this.itemsPerPage, this.currentPage});

  PagingInfo.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    itemsPerPage = json['itemsPerPage'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['itemsPerPage'] = this.itemsPerPage;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

class PatientList {
  int patientId;
  String displayName;
  String accountNumber;
  String dob;
  int numberOfCases;
  int directAccess;
  int externalPatientId;

  PatientList({this.patientId, this.displayName, this.accountNumber, this.dob, this.numberOfCases, this.directAccess, this.externalPatientId});

  PatientList.fromJson(Map<String, dynamic> json) {
    patientId = json['patientId'];
    displayName = json['displayName'];
    accountNumber = json['accountNumber'];
    dob = json['dob'];
    numberOfCases = json['numberOfCases'];
    directAccess = json['directAccess'];
    externalPatientId = json['externalPatientId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientId'] = this.patientId;
    data['displayName'] = this.displayName;
    data['accountNumber'] = this.accountNumber;
    data['dob'] = this.dob;
    data['numberOfCases'] = this.numberOfCases;
    data['directAccess'] = this.directAccess;
    data['externalPatientId'] = this.externalPatientId;
    return data;
  }
}

class CaseDetailsList {
  String caseNum;
  String doa;
  int episodeId;

  CaseDetailsList({this.caseNum, this.doa, this.episodeId});

  CaseDetailsList.fromJson(Map<String, dynamic> json) {
    caseNum = json['case'];
    doa = json['doa'];
    episodeId = json['episodeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['case'] = this.caseNum;
    data['doa'] = this.doa;
    data['episodeId'] = this.episodeId;
    return data;
  }
}

class PatientDetails {
  String patientName;
  String gender;
  String dob;
  String age;
  String address;
  String email;
  String phoneNumber;

  PatientDetails({this.patientName, this.gender, this.dob, this.age, this.address, this.email, this.phoneNumber});

  PatientDetails.fromJson(Map<String, dynamic> json) {
    patientName = json['patientName'];
    gender = json['gender'];
    dob = json['dob'];
    age = json['age'];
    address = json['address'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['patientName'] = this.patientName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['address'] = this.address;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
