class AppointmentDataList {
  Header header;
  List<EpisodeUpcomingAppointment> episodeUpcomingAppointment;
  List<EpisodePastAppointment> episodePastAppointment;

  AppointmentDataList(
      {this.header,
        this.episodeUpcomingAppointment,
        this.episodePastAppointment});

  AppointmentDataList.fromJson(Map<String, dynamic> json) {
    header =
    json['header'] != null ? new Header.fromJson(json['header']) : null;
    if (json['episodeUpcomingAppointment'] != null) {
      episodeUpcomingAppointment = new List<EpisodeUpcomingAppointment>();
      json['episodeUpcomingAppointment'].forEach((v) {
        episodeUpcomingAppointment
            .add(new EpisodeUpcomingAppointment.fromJson(v));
      });
    }
    if (json['episodePastAppointment'] != null) {
      episodePastAppointment = new List<EpisodePastAppointment>();
      json['episodePastAppointment'].forEach((v) {
        episodePastAppointment.add(new EpisodePastAppointment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    if (this.episodeUpcomingAppointment != null) {
      data['episodeUpcomingAppointment'] =
          this.episodeUpcomingAppointment.map((v) => v.toJson()).toList();
    }
    if (this.episodePastAppointment != null) {
      data['episodePastAppointment'] =
          this.episodePastAppointment.map((v) => v.toJson()).toList();
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

class EpisodePastAppointment {

  int appointmentId;
  String appointmentDate;
  String providerName;
  String practiceName;
  String locationName;
  double lattitude;
  double longitude;
  String appointmentType;

  EpisodePastAppointment(
      {this.appointmentId,
        this.appointmentDate,
        this.providerName,
        this.practiceName,
        this.locationName,
        this.lattitude,
        this.longitude,
        this.appointmentType});

  EpisodePastAppointment.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointmentId'];
    appointmentDate = json['appointmentDate'];
    providerName = json['providerName'];
    practiceName = json['practiceName'];
    locationName = json['locationName'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    appointmentType = json['appointmentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentId'] = this.appointmentId;
    data['appointmentDate'] = this.appointmentDate;
    data['providerName'] = this.providerName;
    data['practiceName'] = this.practiceName;
    data['locationName'] = this.locationName;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['appointmentType'] = this.appointmentType;
    return data;

  }
}
class EpisodeUpcomingAppointment {
  int appointmentId;
  String appointmentDate;
  String providerName;
  String practiceName;
  String locationName;
  double lattitude;
  double longitude;
  String appointmentType;

  EpisodeUpcomingAppointment(
      {this.appointmentId,
        this.appointmentDate,
        this.providerName,
        this.practiceName,
        this.locationName,
        this.lattitude,
        this.longitude,
        this.appointmentType});

  EpisodeUpcomingAppointment.fromJson(Map<String, dynamic> json) {
    appointmentId = json['appointmentId'];
    appointmentDate = json['appointmentDate'];
    providerName = json['providerName'];
    practiceName = json['practiceName'];
    locationName = json['locationName'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
    appointmentType = json['appointmentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentId'] = this.appointmentId;
    data['appointmentDate'] = this.appointmentDate;
    data['providerName'] = this.providerName;
    data['practiceName'] = this.practiceName;
    data['locationName'] = this.locationName;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    data['appointmentType'] = this.appointmentType;
    return data;
  }
}

