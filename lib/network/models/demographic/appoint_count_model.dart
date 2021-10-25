class AppointmentCountModel {
  AppointmentCount appointmentCount;
  Header header;

  AppointmentCountModel({this.appointmentCount, this.header});

  AppointmentCountModel.fromJson(Map<String, dynamic> json) {
    appointmentCount = json['appointmentCount'] != null
        ? new AppointmentCount.fromJson(json['appointmentCount'])
        : null;
    header =
    json['header'] != null ? new Header.fromJson(json['header']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appointmentCount != null) {
      data['appointmentCount'] = this.appointmentCount.toJson();
    }
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    return data;
  }
}

class AppointmentCount {
  int appointmentsCount;
  int appointmentCompletedCount;
  int referalSourceCount;
  int careTeamMembersCount;
  int assessementsCount;
  int documentsFolderCount;

  AppointmentCount(
      {this.appointmentsCount,
        this.appointmentCompletedCount,
        this.referalSourceCount,
        this.careTeamMembersCount,
        this.assessementsCount,
        this.documentsFolderCount});

  AppointmentCount.fromJson(Map<String, dynamic> json) {
    appointmentsCount = json['appointmentsCount'];
    appointmentCompletedCount = json['appointmentCompletedCount'];
    referalSourceCount = json['referalSourceCount'];
    careTeamMembersCount = json['careTeamMembersCount'];
    assessementsCount = json['assessementsCount'];
    documentsFolderCount = json['documentsFolderCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentsCount'] = this.appointmentsCount;
    data['appointmentCompletedCount'] = this.appointmentCompletedCount;
    data['referalSourceCount'] = this.referalSourceCount;
    data['careTeamMembersCount'] = this.careTeamMembersCount;
    data['assessementsCount'] = this.assessementsCount;
    data['documentsFolderCount'] = this.documentsFolderCount;
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
