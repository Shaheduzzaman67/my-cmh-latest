// class GetUserResp {
//   bool isSuccess;
//   PatientData data;

//   GetUserResp({this.isSuccess, this.data});

//   GetUserResp.fromJson(Map<String, dynamic> json) {
//     isSuccess = json['isSuccess'];
//     data = json['data'] != null ? new PatientData.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['isSuccess'] = this.isSuccess;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     return data;
//   }
// }

// class PatientData {
//   String regNo;
//   String hospitalNumber;
//   String regDate;
//   String salutation;
//   String fname;
//   String lname;
//   String patientName;
//   String gender;
//   String genderData;
//   String mStatus;
//   String mStatusData;
//   String ageDd;
//   String ageMm;
//   String ageYy;
//   String age;
//   String dob;
//   String bloodGroup;
//   String religion;
//   String phoneMobile;
//   String email;
//   String address;
//   String fatherName;
//   String motherName;
//   String spouseName;
//   String passportNo;
//   String nationality;
//   String nationalId;
//   String patTypeNo;
//   String regPoint;
//   String ssCreator;
//   String ssCreatedOn;
//   String ssCreatedSession;
//   String ssModifier;
//   String ssModifiedOn;
//   String ssModifiedSession;
//   String ssUploadedOn;
//   String companyNo;
//   String phoneTnt;
//   String upazilaNo;
//   String upazilaName;
//   String corClientNo;
//   String corClientCardNo;
//   String empNo;
//   String relationNo;
//   String activeStat;
//   String nokName;
//   String nokRelation;
//   String nokContact;
//   String eligibilityStatus;
//   String serviceCategory;
//   String personCategory;
//   String rankNo;
//   String corps;
//   String joiningDate;
//   String identityMark;
//   String medicalCategory;
//   String coid;
//   String uniCheck;
//   String recCheck;
//   String regType;
//   String personalNumber;
//   String serviceHolderId;
//   String presentDistrict;
//   String permanentDistrict;
//   String pastIllnessDate;
//   String pastIllnessDesc;
//   String pastIllnessDispose;
//   String persNumbPrefix;
//   String unitNo;
//   String personalId;
//   String phoneMobile2;
//   String estRtdDate;
//   String extendedYears;
//   String extendedMonths;
//   String presentdistrict;
//   String patientPhoto;
//   String deathFlag;
//   String corpNo;
//   String presentAddress;
//   String nokAddress;
//   String permanentAddress;

//   PatientData(
//       {this.regNo,
//         this.hospitalNumber,
//         this.regDate,
//         this.salutation,
//         this.fname,
//         this.lname,
//         this.patientName,
//         this.gender,
//         this.genderData,
//         this.mStatus,
//         this.mStatusData,
//         this.ageDd,
//         this.ageMm,
//         this.ageYy,
//         this.age,
//         this.dob,
//         this.bloodGroup,
//         this.religion,
//         this.phoneMobile,
//         this.email,
//         this.address,
//         this.fatherName,
//         this.motherName,
//         this.spouseName,
//         this.passportNo,
//         this.nationality,
//         this.nationalId,
//         this.patTypeNo,
//         this.regPoint,
//         this.ssCreator,
//         this.ssCreatedOn,
//         this.ssCreatedSession,
//         this.ssModifier,
//         this.ssModifiedOn,
//         this.ssModifiedSession,
//         this.ssUploadedOn,
//         this.companyNo,
//         this.phoneTnt,
//         this.upazilaNo,
//         this.upazilaName,
//         this.corClientNo,
//         this.corClientCardNo,
//         this.empNo,
//         this.relationNo,
//         this.activeStat,
//         this.nokName,
//         this.nokRelation,
//         this.nokContact,
//         this.eligibilityStatus,
//         this.serviceCategory,
//         this.personCategory,
//         this.rankNo,
//         this.corps,
//         this.joiningDate,
//         this.identityMark,
//         this.medicalCategory,
//         this.coid,
//         this.uniCheck,
//         this.recCheck,
//         this.regType,
//         this.personalNumber,
//         this.serviceHolderId,
//         this.presentDistrict,
//         this.permanentDistrict,
//         this.pastIllnessDate,
//         this.pastIllnessDesc,
//         this.pastIllnessDispose,
//         this.persNumbPrefix,
//         this.unitNo,
//         this.personalId,
//         this.phoneMobile2,
//         this.estRtdDate,
//         this.extendedYears,
//         this.extendedMonths,
//         this.presentdistrict,
//         this.patientPhoto,
//         this.deathFlag,
//         this.corpNo,
//         this.presentAddress,
//         this.nokAddress,
//         this.permanentAddress});

//   PatientData.fromJson(Map<String, dynamic> json) {
//     regNo = json['reg_no'];
//     hospitalNumber = json['hospital_number'];
//     regDate = json['reg_date'];
//     salutation = json['salutation'];
//     fname = json['fname'];
//     lname = json['lname'];
//     patientName = json['patient_name'];
//     gender = json['gender'];
//     genderData = json['gender_data'];
//     mStatus = json['m_status'];
//     mStatusData = json['m_status_data'];
//     ageDd = json['age_dd'];
//     ageMm = json['age_mm'];
//     ageYy = json['age_yy'];
//     age = json['age'];
//     dob = json['dob'];
//     bloodGroup = json['blood_group'];
//     religion = json['religion'];
//     phoneMobile = json['phone_mobile'];
//     email = json['email'];
//     address = json['address'];
//     fatherName = json['father_name'];
//     motherName = json['mother_name'];
//     spouseName = json['spouse_name'];
//     passportNo = json['passport_no'];
//     nationality = json['nationality'];
//     nationalId = json['national_id'];
//     patTypeNo = json['pat_type_no'];
//     regPoint = json['reg_point'];
//     ssCreator = json['ss_creator'];
//     ssCreatedOn = json['ss_created_on'];
//     ssCreatedSession = json['ss_created_session'];
//     ssModifier = json['ss_modifier'];
//     ssModifiedOn = json['ss_modified_on'];
//     ssModifiedSession = json['ss_modified_session'];
//     ssUploadedOn = json['ss_uploaded_on'];
//     companyNo = json['company_no'];
//     phoneTnt = json['phone_tnt'];
//     upazilaNo = json['upazila_no'];
//     upazilaName = json['upazila_name'];
//     corClientNo = json['cor_client_no'];
//     corClientCardNo = json['cor_client_card_no'];
//     empNo = json['emp_no'];
//     relationNo = json['relation_no'];
//     activeStat = json['active_stat'];
//     nokName = json['nok_name'];
//     nokRelation = json['nok_relation'];
//     nokContact = json['nok_contact'];
//     eligibilityStatus = json['eligibility_status'];
//     serviceCategory = json['service_category'];
//     personCategory = json['person_category'];
//     rankNo = json['rank_no'];
//     corps = json['corps'];
//     joiningDate = json['joining_date'];
//     identityMark = json['identity_mark'];
//     medicalCategory = json['medical_category'];
//     coid = json['coid'];
//     uniCheck = json['uni_check'];
//     recCheck = json['rec_check'];
//     regType = json['reg_type'];
//     personalNumber = json['personal_number'];
//     serviceHolderId = json['service_holder_id'];
//     presentDistrict = json['present_district'];
//     permanentDistrict = json['permanent_district'];
//     pastIllnessDate = json['past_illness_date'];
//     pastIllnessDesc = json['past_illness_desc'];
//     pastIllnessDispose = json['past_illness_dispose'];
//     persNumbPrefix = json['pers_numb_prefix'];
//     unitNo = json['unit_no'];
//     personalId = json['personal_id'];
//     phoneMobile2 = json['phone_mobile2'];
//     estRtdDate = json['est_rtd_date'];
//     extendedYears = json['extended_years'];
//     extendedMonths = json['extended_months'];
//     presentdistrict = json['presentdistrict'];
//     patientPhoto = json['patient_photo'];
//     deathFlag = json['death_flag'];
//     corpNo = json['corp_no'];
//     presentAddress = json['present_address'];
//     nokAddress = json['nok_address'];
//     permanentAddress = json['permanent_address'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['reg_no'] = this.regNo;
//     data['hospital_number'] = this.hospitalNumber;
//     data['reg_date'] = this.regDate;
//     data['salutation'] = this.salutation;
//     data['fname'] = this.fname;
//     data['lname'] = this.lname;
//     data['patient_name'] = this.patientName;
//     data['gender'] = this.gender;
//     data['gender_data'] = this.genderData;
//     data['m_status'] = this.mStatus;
//     data['m_status_data'] = this.mStatusData;
//     data['age_dd'] = this.ageDd;
//     data['age_mm'] = this.ageMm;
//     data['age_yy'] = this.ageYy;
//     data['age'] = this.age;
//     data['dob'] = this.dob;
//     data['blood_group'] = this.bloodGroup;
//     data['religion'] = this.religion;
//     data['phone_mobile'] = this.phoneMobile;
//     data['email'] = this.email;
//     data['address'] = this.address;
//     data['father_name'] = this.fatherName;
//     data['mother_name'] = this.motherName;
//     data['spouse_name'] = this.spouseName;
//     data['passport_no'] = this.passportNo;
//     data['nationality'] = this.nationality;
//     data['national_id'] = this.nationalId;
//     data['pat_type_no'] = this.patTypeNo;
//     data['reg_point'] = this.regPoint;
//     data['ss_creator'] = this.ssCreator;
//     data['ss_created_on'] = this.ssCreatedOn;
//     data['ss_created_session'] = this.ssCreatedSession;
//     data['ss_modifier'] = this.ssModifier;
//     data['ss_modified_on'] = this.ssModifiedOn;
//     data['ss_modified_session'] = this.ssModifiedSession;
//     data['ss_uploaded_on'] = this.ssUploadedOn;
//     data['company_no'] = this.companyNo;
//     data['phone_tnt'] = this.phoneTnt;
//     data['upazila_no'] = this.upazilaNo;
//     data['upazila_name'] = this.upazilaName;
//     data['cor_client_no'] = this.corClientNo;
//     data['cor_client_card_no'] = this.corClientCardNo;
//     data['emp_no'] = this.empNo;
//     data['relation_no'] = this.relationNo;
//     data['active_stat'] = this.activeStat;
//     data['nok_name'] = this.nokName;
//     data['nok_relation'] = this.nokRelation;
//     data['nok_contact'] = this.nokContact;
//     data['eligibility_status'] = this.eligibilityStatus;
//     data['service_category'] = this.serviceCategory;
//     data['person_category'] = this.personCategory;
//     data['rank_no'] = this.rankNo;
//     data['corps'] = this.corps;
//     data['joining_date'] = this.joiningDate;
//     data['identity_mark'] = this.identityMark;
//     data['medical_category'] = this.medicalCategory;
//     data['coid'] = this.coid;
//     data['uni_check'] = this.uniCheck;
//     data['rec_check'] = this.recCheck;
//     data['reg_type'] = this.regType;
//     data['personal_number'] = this.personalNumber;
//     data['service_holder_id'] = this.serviceHolderId;
//     data['present_district'] = this.presentDistrict;
//     data['permanent_district'] = this.permanentDistrict;
//     data['past_illness_date'] = this.pastIllnessDate;
//     data['past_illness_desc'] = this.pastIllnessDesc;
//     data['past_illness_dispose'] = this.pastIllnessDispose;
//     data['pers_numb_prefix'] = this.persNumbPrefix;
//     data['unit_no'] = this.unitNo;
//     data['personal_id'] = this.personalId;
//     data['phone_mobile2'] = this.phoneMobile2;
//     data['est_rtd_date'] = this.estRtdDate;
//     data['extended_years'] = this.extendedYears;
//     data['extended_months'] = this.extendedMonths;
//     data['presentdistrict'] = this.presentdistrict;
//     data['patient_photo'] = this.patientPhoto;
//     data['death_flag'] = this.deathFlag;
//     data['corp_no'] = this.corpNo;
//     data['present_address'] = this.presentAddress;
//     data['nok_address'] = this.nokAddress;
//     data['permanent_address'] = this.permanentAddress;
//     return data;
//   }
// }
