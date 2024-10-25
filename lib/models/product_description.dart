class mainDescription {
  List<Message>? message;

  mainDescription({this.message});

  mainDescription.fromJson(Map<String, dynamic> json) {
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message!.add(new Message.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Message {
  String? name;
  String? creation;
  String? modified;
  String? modifiedBy;
  String? owner;
  int? docstatus;
  Null? parent;
  Null? parentfield;
  Null? parenttype;
  int? idx;
  String? namingSeries;
  String? customer;
  String? customerName;
  String? addressDisplay;
  String? contactDisplay;
  String? contactMobile;
  String? contactEmail;
  String? mntcDate;
  String? mntcTime;
  String? completionStatus;
  String? maintenanceType;
  Null? customerFeedback;
  String? status;
  Null? amendedFrom;
  String? company;
  String? customerAddress;
  String? contactPerson;
  String? territory;
  String? customerGroup;
  Null? nUserTags;
  Null? nComments;
  String? sAssign;
  Null? nLikedBy;
  Null? maintenanceSchedule;
  Null? maintenanceScheduleDetail;
  Null? maintenanceCertified;
  String? description;
  String? maintenanceDescription;
  String? soNo;
  Null? cDescription;
  Null? pDescription;
  Null? checktreeDescription;
  String? deliveryAddress;
  String? detailedAddress;
  String? addressHtml;
  String? subject;

  Message(
      {this.name,
      this.creation,
      this.modified,
      this.modifiedBy,
      this.owner,
      this.docstatus,
      this.parent,
      this.parentfield,
      this.parenttype,
      this.idx,
      this.namingSeries,
      this.customer,
      this.customerName,
      this.addressDisplay,
      this.contactDisplay,
      this.contactMobile,
      this.contactEmail,
      this.mntcDate,
      this.mntcTime,
      this.completionStatus,
      this.maintenanceType,
      this.customerFeedback,
      this.status,
      this.amendedFrom,
      this.company,
      this.customerAddress,
      this.contactPerson,
      this.territory,
      this.customerGroup,
      this.nUserTags,
      this.nComments,
      this.sAssign,
      this.nLikedBy,
      this.maintenanceSchedule,
      this.maintenanceScheduleDetail,
      this.maintenanceCertified,
      this.description,
      this.maintenanceDescription,
      this.soNo,
      this.cDescription,
      this.pDescription,
      this.checktreeDescription,
      this.deliveryAddress,
      this.detailedAddress,
      this.addressHtml,
      this.subject});

  Message.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    creation = json['creation'];
    modified = json['modified'];
    modifiedBy = json['modified_by'];
    owner = json['owner'];
    docstatus = json['docstatus'];
    parent = json['parent'];
    parentfield = json['parentfield'];
    parenttype = json['parenttype'];
    idx = json['idx'];
    namingSeries = json['naming_series'];
    customer = json['customer'];
    customerName = json['customer_name'];
    addressDisplay = json['address_display'];
    contactDisplay = json['contact_display'];
    contactMobile = json['contact_mobile'];
    contactEmail = json['contact_email'];
    mntcDate = json['mntc_date'];
    mntcTime = json['mntc_time'];
    completionStatus = json['completion_status'];
    maintenanceType = json['maintenance_type'];
    customerFeedback = json['customer_feedback'];
    status = json['status'];
    amendedFrom = json['amended_from'];
    company = json['company'];
    customerAddress = json['customer_address'];
    contactPerson = json['contact_person'];
    territory = json['territory'];
    customerGroup = json['customer_group'];
    nUserTags = json['_user_tags'];
    nComments = json['_comments'];
    sAssign = json['_assign'];
    nLikedBy = json['_liked_by'];
    maintenanceSchedule = json['maintenance_schedule'];
    maintenanceScheduleDetail = json['maintenance_schedule_detail'];
    maintenanceCertified = json['maintenance_certified'];
    description = json['description'];
    maintenanceDescription = json['maintenance_description'];
    soNo = json['so_no'];
    cDescription = json['c_description'];
    pDescription = json['p_description'];
    checktreeDescription = json['checktree_description'];
    deliveryAddress = json['delivery_address'];
    detailedAddress = json['detailed_address'];
    addressHtml = json['address_html'];
    subject = json['subject'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['creation'] = this.creation;
    data['modified'] = this.modified;
    data['modified_by'] = this.modifiedBy;
    data['owner'] = this.owner;
    data['docstatus'] = this.docstatus;
    data['parent'] = this.parent;
    data['parentfield'] = this.parentfield;
    data['parenttype'] = this.parenttype;
    data['idx'] = this.idx;
    data['naming_series'] = this.namingSeries;
    data['customer'] = this.customer;
    data['customer_name'] = this.customerName;
    data['address_display'] = this.addressDisplay;
    data['contact_display'] = this.contactDisplay;
    data['contact_mobile'] = this.contactMobile;
    data['contact_email'] = this.contactEmail;
    data['mntc_date'] = this.mntcDate;
    data['mntc_time'] = this.mntcTime;
    data['completion_status'] = this.completionStatus;
    data['maintenance_type'] = this.maintenanceType;
    data['customer_feedback'] = this.customerFeedback;
    data['status'] = this.status;
    data['amended_from'] = this.amendedFrom;
    data['company'] = this.company;
    data['customer_address'] = this.customerAddress;
    data['contact_person'] = this.contactPerson;
    data['territory'] = this.territory;
    data['customer_group'] = this.customerGroup;
    data['_user_tags'] = this.nUserTags;
    data['_comments'] = this.nComments;
    data['_assign'] = this.sAssign;
    data['_liked_by'] = this.nLikedBy;
    data['maintenance_schedule'] = this.maintenanceSchedule;
    data['maintenance_schedule_detail'] = this.maintenanceScheduleDetail;
    data['maintenance_certified'] = this.maintenanceCertified;
    data['description'] = this.description;
    data['maintenance_description'] = this.maintenanceDescription;
    data['so_no'] = this.soNo;
    data['c_description'] = this.cDescription;
    data['p_description'] = this.pDescription;
    data['checktree_description'] = this.checktreeDescription;
    data['delivery_address'] = this.deliveryAddress;
    data['detailed_address'] = this.detailedAddress;
    data['address_html'] = this.addressHtml;
    data['subject'] = this.subject;
    return data;
  }
}
