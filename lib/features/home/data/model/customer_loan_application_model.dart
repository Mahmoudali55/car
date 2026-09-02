import 'package:equatable/equatable.dart';

class CustomerLoanApplicationModel extends Equatable {
  final int customerID;
  final String idNo;
  final String carID;
  final String carName;
  final String makeYear;
  final int? bankID;
  final int? offerID;
  final double carPrice;
  final double downPayment;
  final double lastPayment;
  final double loanAmount;
  final int termMonths;
  final double monthlyInstallment;
  final int applicationStatus;
  final String applicationStatusTxt;
  final String genderTxt;
  final int applicationID;
  final int programType;
  final String programName;
  final String createdDate;
  final int? cityID;
  final int? gender;
  final double? workType;
  final String? employer;
  final String? jobTitle;
  final double? monthlySalary;
  final String? customerName;

  const CustomerLoanApplicationModel({
    required this.customerID,
    required this.idNo,
    required this.carID,
    required this.carName,
    required this.makeYear,
    this.bankID,
    this.offerID,
    required this.carPrice,
    required this.downPayment,
    required this.lastPayment,
    required this.loanAmount,
    required this.termMonths,
    required this.monthlyInstallment,
    required this.applicationStatus,
    required this.applicationStatusTxt,
    required this.genderTxt,
    required this.applicationID,
    required this.programType,
    required this.programName,
    required this.createdDate,
    this.cityID,
    this.gender,
    this.workType,
    this.employer,
    this.jobTitle,
    this.monthlySalary,
    this.customerName,
  });

  factory CustomerLoanApplicationModel.fromJson(Map<String, dynamic> json) {
    return CustomerLoanApplicationModel(
      customerID: json['CustomerID'] is int
          ? json['CustomerID']
          : int.tryParse(json['CustomerID']?.toString() ?? '') ?? 0,
      idNo: json['IDNO']?.toString() ?? '',
      carID: json['CarID']?.toString() ?? '',
      carName: json['CarName']?.toString() ?? '',
      makeYear: json['Make_year']?.toString() ?? '',
      bankID: json['BankID'] is int ? json['BankID'] : int.tryParse(json['BankID']?.toString() ?? ''),
      offerID: json['OfferID'] is int ? json['OfferID'] : int.tryParse(json['OfferID']?.toString() ?? ''),
      carPrice: (json['CarPrice'] as num?)?.toDouble() ?? 0.0,
      downPayment: (json['DownPayment'] as num?)?.toDouble() ?? 0.0,
      lastPayment: (json['lastPayment'] as num?)?.toDouble() ?? 0.0,
      loanAmount: (json['LoanAmount'] as num?)?.toDouble() ?? 0.0,
      termMonths: json['TermMonths'] is int
          ? json['TermMonths']
          : int.tryParse(json['TermMonths']?.toString() ?? '') ?? 0,
      monthlyInstallment: (json['MonthlyInstallment'] as num?)?.toDouble() ?? 0.0,
      applicationStatus: json['ApplicationStatus'] is int
          ? json['ApplicationStatus']
          : int.tryParse(json['ApplicationStatus']?.toString() ?? '') ?? 0,
      applicationStatusTxt: json['ApplicationStatustxt']?.toString() ?? '',
      genderTxt: json['Gendertxt']?.toString() ?? '',
      applicationID: json['ApplicationID'] is int
          ? json['ApplicationID']
          : int.tryParse(json['ApplicationID']?.toString() ?? '') ?? 0,
      programType: json['ProgramType'] is int
          ? json['ProgramType']
          : int.tryParse(json['ProgramType']?.toString() ?? '') ?? 0,
      programName: json['ProgramName']?.toString() ?? '',
      createdDate: json['CreatedDate']?.toString() ?? '',
      cityID: json['CityID'] is int ? json['CityID'] : int.tryParse(json['CityID']?.toString() ?? ''),
      gender: json['Gender'] is int ? json['Gender'] : int.tryParse(json['Gender']?.toString() ?? ''),
      workType: (json['WorkType'] as num?)?.toDouble(),
      employer: json['Employer']?.toString(),
      jobTitle: json['Job_title']?.toString(),
      monthlySalary: (json['monthly_salary'] as num?)?.toDouble(),
      customerName: json['CUSTOMER_NAME']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CustomerID': customerID,
      'IDNO': idNo,
      'CarID': carID,
      'CarName': carName,
      'Make_year': makeYear,
      'BankID': bankID,
      'OfferID': offerID,
      'CarPrice': carPrice,
      'DownPayment': downPayment,
      'lastPayment': lastPayment,
      'LoanAmount': loanAmount,
      'TermMonths': termMonths,
      'MonthlyInstallment': monthlyInstallment,
      'ApplicationStatus': applicationStatus,
      'ApplicationStatustxt': applicationStatusTxt,
      'Gendertxt': genderTxt,
      'ApplicationID': applicationID,
      'ProgramType': programType,
      'ProgramName': programName,
      'CreatedDate': createdDate,
      'CityID': cityID,
      'Gender': gender,
      'WorkType': workType,
      'Employer': employer,
      'Job_title': jobTitle,
      'monthly_salary': monthlySalary,
      'CUSTOMER_NAME': customerName,
    };
  }

  @override
  List<Object?> get props => [
        customerID,
        idNo,
        carID,
        carName,
        makeYear,
        bankID,
        offerID,
        carPrice,
        downPayment,
        lastPayment,
        loanAmount,
        termMonths,
        monthlyInstallment,
        applicationStatus,
        applicationStatusTxt,
        genderTxt,
        applicationID,
        programType,
        programName,
        createdDate,
        cityID,
        gender,
        workType,
        employer,
        jobTitle,
        monthlySalary,
        customerName,
      ];
}
