class DocumentFolderModel {
  Header header;
  List<EpisodeDocumentFolder> episodeDocumentFolder;

  DocumentFolderModel({this.header, this.episodeDocumentFolder});

  DocumentFolderModel.fromJson(Map<String, dynamic> json) {
    header =
    json['header'] != null ? new Header.fromJson(json['header']) : null;
    if (json['episodeDocumentFolder'] != null) {
      episodeDocumentFolder = new List<EpisodeDocumentFolder>();
      json['episodeDocumentFolder'].forEach((v) {
        episodeDocumentFolder.add(new EpisodeDocumentFolder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header.toJson();
    }
    if (this.episodeDocumentFolder != null) {
      data['episodeDocumentFolder'] =
          this.episodeDocumentFolder.map((v) => v.toJson()).toList();
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

class EpisodeDocumentFolder {
  int id;
  String name;
  int episodeId;
  int categoryId;
  int totalDocumentCountPerFolder;
  int surgeonId;
  int episodeSurgeryDetailsId;
  bool isExpanded;

  EpisodeDocumentFolder(
      {this.id,
        this.name,
        this.episodeId,
        this.categoryId,
        this.totalDocumentCountPerFolder,
        this.surgeonId,
        this.episodeSurgeryDetailsId,
        this.isExpanded =false,});

  EpisodeDocumentFolder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    episodeId = json['episodeId'];
    categoryId = json['categoryId'];
    totalDocumentCountPerFolder = json['totalDocumentCountPerFolder'];
    surgeonId = json['surgeonId'];
    episodeSurgeryDetailsId = json['episodeSurgeryDetailsId'];
    isExpanded = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['episodeId'] = this.episodeId;
    data['categoryId'] = this.categoryId;
    data['totalDocumentCountPerFolder'] = this.totalDocumentCountPerFolder;
    data['surgeonId'] = this.surgeonId;
    data['episodeSurgeryDetailsId'] = this.episodeSurgeryDetailsId;
    data['isExpanded']= false;
    return data;
  }
}