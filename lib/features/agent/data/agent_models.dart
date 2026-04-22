import 'package:flutter/material.dart';

// ── Theme Colors ──────────────────────────────────────────────────────────────
class AgentTheme {
  static const navy     = Color(0xFF080F1E);
  static const navy2    = Color(0xFF0D1A2D);
  static const surface  = Color(0xFF121C2E);
  static const card     = Color(0xFF172035);
  static const card2    = Color(0xFF1C2840);
  static const blue     = Color(0xFF0057FF);
  static const blue2    = Color(0xFF0047D4);
  static const gold     = Color(0xFFF5A623);
  static const green    = Color(0xFF00C06B);
  static const red      = Color(0xFFFF3B3B);
  static const orange   = Color(0xFFFF8C00);
  static const text1    = Color(0xFFF0F4FF);
  static const text2    = Color(0xFF8899BB);
  static const text3    = Color(0xFF4A5870);
  static const border   = Color(0x10FFFFFF);
}

// ── KPI ──────────────────────────────────────────────────────────────────────
class AgentKpi {
  final String label;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color color;
  final double? change;

  const AgentKpi({
    required this.label,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.change,
  });
}

// ── Lead ─────────────────────────────────────────────────────────────────────
enum LeadStatus { newLead, inProgress, closed, lost }

class AgentLead {
  final String id;
  final String customerName;
  final String phoneNumber;
  final String carInterest;
  final LeadStatus status;
  final DateTime lastContact;
  final String? note;
  final double budget;

  const AgentLead({
    required this.id,
    required this.customerName,
    required this.phoneNumber,
    required this.carInterest,
    required this.status,
    required this.lastContact,
    this.note,
    required this.budget,
  });

  Color get statusColor {
    switch (status) {
      case LeadStatus.newLead:   return AgentTheme.blue;
      case LeadStatus.inProgress:return AgentTheme.orange;
      case LeadStatus.closed:    return AgentTheme.green;
      case LeadStatus.lost:      return AgentTheme.red;
    }
  }

  String get statusLabel {
    switch (status) {
      case LeadStatus.newLead:   return 'جديد';
      case LeadStatus.inProgress:return 'جاري';
      case LeadStatus.closed:    return 'مغلق';
      case LeadStatus.lost:      return 'مفقود';
    }
  }
}

// ── Appointment ───────────────────────────────────────────────────────────────
enum AppointmentStatus { upcoming, checkedIn, done, cancelled }

class AgentAppointment {
  final String id;
  final String customerName;
  final String carModel;
  final DateTime dateTime;
  final String location;
  AppointmentStatus status;

  AgentAppointment({
    required this.id,
    required this.customerName,
    required this.carModel,
    required this.dateTime,
    required this.location,
    this.status = AppointmentStatus.upcoming,
  });
}

// ── Car ───────────────────────────────────────────────────────────────────────
enum CarAvailability { available, reserved, sold }

class AgentCar {
  final String id;
  final String name;
  final String brand;
  final double price;
  final String imageUrl;
  final CarAvailability availability;
  final String year;
  final String mileage;
  final String color;

  const AgentCar({
    required this.id,
    required this.name,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.availability,
    required this.year,
    required this.mileage,
    required this.color,
  });

  Color get availabilityColor {
    switch (availability) {
      case CarAvailability.available: return AgentTheme.green;
      case CarAvailability.reserved:  return AgentTheme.orange;
      case CarAvailability.sold:      return AgentTheme.red;
    }
  }

  String get availabilityLabel {
    switch (availability) {
      case CarAvailability.available: return 'متاحة';
      case CarAvailability.reserved:  return 'محجوزة';
      case CarAvailability.sold:      return 'مباعة';
    }
  }
}

// ── Mock Data ─────────────────────────────────────────────────────────────────
final kAgentKpis = [
  const AgentKpi(
    label: 'مكالمات اليوم',
    value: '14',
    subtitle: 'من أصل 20 هدف',
    icon: Icons.phone_in_talk_rounded,
    color: AgentTheme.blue,
    change: 12.0,
  ),
  const AgentKpi(
    label: 'مواعيد معلقة',
    value: '3',
    subtitle: 'لهذا الأسبوع',
    icon: Icons.calendar_today_rounded,
    color: AgentTheme.orange,
    change: -5.0,
  ),
  const AgentKpi(
    label: 'صفقات مغلقة',
    value: '7',
    subtitle: 'هذا الشهر',
    icon: Icons.handshake_rounded,
    color: AgentTheme.green,
    change: 22.0,
  ),
  const AgentKpi(
    label: 'الإيرادات',
    value: '312K',
    subtitle: 'ر.س هذا الشهر',
    icon: Icons.trending_up_rounded,
    color: AgentTheme.gold,
    change: 18.0,
  ),
];

final kAgentLeads = [
  AgentLead(
    id: '1',
    customerName: 'محمد العمري',
    phoneNumber: '0501234567',
    carInterest: 'تويوتا كامري 2024',
    status: LeadStatus.newLead,
    lastContact: DateTime.now().subtract(const Duration(hours: 2)),
    note: 'مهتم جداً، يريد التجربة',
    budget: 95000,
  ),
  AgentLead(
    id: '2',
    customerName: 'سارة الخالدي',
    phoneNumber: '0559876543',
    carInterest: 'نيسان باترول 2023',
    status: LeadStatus.inProgress,
    lastContact: DateTime.now().subtract(const Duration(days: 1)),
    note: 'تنتظر موافقة التمويل',
    budget: 185000,
  ),
  AgentLead(
    id: '3',
    customerName: 'فيصل الدوسري',
    phoneNumber: '0534567890',
    carInterest: 'BMW X5 2024',
    status: LeadStatus.closed,
    lastContact: DateTime.now().subtract(const Duration(days: 2)),
    budget: 285000,
  ),
  AgentLead(
    id: '4',
    customerName: 'لمياء الشهراني',
    phoneNumber: '0521112233',
    carInterest: 'هيونداي توسان 2024',
    status: LeadStatus.newLead,
    lastContact: DateTime.now().subtract(const Duration(hours: 5)),
    budget: 75000,
  ),
  AgentLead(
    id: '5',
    customerName: 'خالد المطيري',
    phoneNumber: '0567891234',
    carInterest: 'لكزس LX 2023',
    status: LeadStatus.lost,
    lastContact: DateTime.now().subtract(const Duration(days: 5)),
    note: 'ذهب للمنافس',
    budget: 350000,
  ),
];

final kAgentAppointments = [
  AgentAppointment(
    id: '1',
    customerName: 'محمد العمري',
    carModel: 'تويوتا كامري 2024',
    dateTime: DateTime.now().add(const Duration(hours: 2)),
    location: 'صالة العرض - الرياض',
    status: AppointmentStatus.upcoming,
  ),
  AgentAppointment(
    id: '2',
    customerName: 'سارة الخالدي',
    carModel: 'نيسان باترول 2023',
    dateTime: DateTime.now().add(const Duration(hours: 5)),
    location: 'مكتب العميل - جدة',
    status: AppointmentStatus.upcoming,
  ),
  AgentAppointment(
    id: '3',
    customerName: 'فيصل الدوسري',
    carModel: 'BMW X5 2024',
    dateTime: DateTime.now().subtract(const Duration(hours: 3)),
    location: 'صالة العرض - الخبر',
    status: AppointmentStatus.done,
  ),
];

final kAgentCars = [
  const AgentCar(
    id: '1',
    name: 'كامري 2024',
    brand: 'تويوتا',
    price: 95000,
    imageUrl: '',
    availability: CarAvailability.available,
    year: '2024',
    mileage: '0',
    color: 'أبيض',
  ),
  const AgentCar(
    id: '2',
    name: 'باترول 2023',
    brand: 'نيسان',
    price: 185000,
    imageUrl: '',
    availability: CarAvailability.reserved,
    year: '2023',
    mileage: '12,000',
    color: 'فضي',
  ),
  const AgentCar(
    id: '3',
    name: 'X5 2024',
    brand: 'BMW',
    price: 285000,
    imageUrl: '',
    availability: CarAvailability.sold,
    year: '2024',
    mileage: '0',
    color: 'أسود',
  ),
  const AgentCar(
    id: '4',
    name: 'توسان 2024',
    brand: 'هيونداي',
    price: 75000,
    imageUrl: '',
    availability: CarAvailability.available,
    year: '2024',
    mileage: '0',
    color: 'أزرق',
  ),
  const AgentCar(
    id: '5',
    name: 'LX 600 2023',
    brand: 'لكزس',
    price: 490000,
    imageUrl: '',
    availability: CarAvailability.available,
    year: '2023',
    mileage: '5,000',
    color: 'أبيض',
  ),
];
