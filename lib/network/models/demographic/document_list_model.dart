class DocumentListModel {
  Header header;
  List<EpisodeDocumentList> episodeDocumentList;

  DocumentListModel({this.header, this.episodeDocumentList});

  DocumentListModel.fromJson(Map<String, dynamic> json) {
    header =
    json['header'] != null ? new Header.fromJson(json['header']) : null;
    if (json['episodeDocumentList'] != null) {
      episodeDocumentList = new List<EpisodeDocumentList>();
      json['episodeDocumentList'].forEach((v) {
        episodeDocumentList.add(new EpisodeDocumentList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    if (this.episodeDocumentList != null) {
      data['episodeDocumentList'] =
          this.episodeDocumentList.map((v) => v.toJson()).toList();
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

class EpisodeDocumentList {
  String treatmentDate;
  String fileName;
  String providerName;

  EpisodeDocumentList({this.treatmentDate, this.fileName, this.providerName});

  EpisodeDocumentList.fromJson(Map<String, dynamic> json) {
    treatmentDate = json['treatmentDate'];
    fileName = json['fileName'];
    providerName = json['providerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['treatmentDate'] = this.treatmentDate;
    data['fileName'] = this.fileName;
    data['providerName'] = this.providerName;
    return data;
  }
}