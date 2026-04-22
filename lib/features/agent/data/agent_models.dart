import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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

  Color getStatusColor(BuildContext context) {
    switch (status) {
      case LeadStatus.newLead:
        return AppColor.blueColor(context);
      case LeadStatus.inProgress:
        return AppColor.orangeColor(context);
      case LeadStatus.closed:
        return AppColor.greenColor(context);
      case LeadStatus.lost:
        return AppColor.redColor(context);
    }
  }

  String get statusLabel {
    switch (status) {
      case LeadStatus.newLead:
        return AppLocaleKey.agentNew.tr();
      case LeadStatus.inProgress:
        return AppLocaleKey.agentStatusInProgress.tr();
      case LeadStatus.closed:
        return AppLocaleKey.agentStatusClosed.tr();
      case LeadStatus.lost:
        return AppLocaleKey.agentStatusLost.tr();
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

  Color getAvailabilityColor(BuildContext context) {
    switch (availability) {
      case CarAvailability.available:
        return AppColor.greenColor(context);
      case CarAvailability.reserved:
        return AppColor.orangeColor(context);
      case CarAvailability.sold:
        return AppColor.redColor(context);
    }
  }

  String get availabilityLabel {
    switch (availability) {
      case CarAvailability.available:
        return AppLocaleKey.agentAvailable.tr();
      case CarAvailability.reserved:
        return AppLocaleKey.agentReserved.tr();
      case CarAvailability.sold:
        return AppLocaleKey.agentSold.tr();
    }
  }
}

// ── Mock Data ─────────────────────────────────────────────────────────────────
List<AgentKpi> getAgentKpis() => [
  AgentKpi(
    label: AppLocaleKey.adminCustomerInquiries.tr(),
    value: '14',
    subtitle: AppLocaleKey.agentTargetOutOfTotal.tr(namedArgs: {'total': '20'}),
    icon: Icons.phone_in_talk_rounded,
    color: const Color(0xFF3B82F6),
    change: 12.0,
  ),
  AgentKpi(
    label: AppLocaleKey.agentUpcomingAppointments.tr(),
    value: '3',
    subtitle: AppLocaleKey.agentForThisWeek.tr(),
    icon: Icons.calendar_today_rounded,
    color: const Color(0xFFF59E0B),
    change: -5.0,
  ),
  AgentKpi(
    label: AppLocaleKey.agentClosedDeals.tr(),
    value: '7',
    subtitle: AppLocaleKey.agentThisMonth.tr(),
    icon: Icons.handshake_rounded,
    color: const Color(0xFF10B981),
    change: 22.0,
  ),
  AgentKpi(
    label: AppLocaleKey.agentCommissionsSales.tr(),
    value: '312K',
    subtitle: '${AppLocaleKey.agentCurrencySar.tr()} ${AppLocaleKey.agentThisMonth.tr()}',
    icon: Icons.trending_up_rounded,
    color: const Color(0xFFFBBF24),
    change: 18.0,
  ),
];

List<AgentLead> getAgentLeads() => [
  AgentLead(
    id: '1',
    customerName: AppLocaleKey.agentSimName1.tr(),
    phoneNumber: '0501234567',
    carInterest: AppLocaleKey.agentSimCarCamry.tr() + " 2024",
    status: LeadStatus.newLead,
    lastContact: DateTime.now().subtract(const Duration(hours: 2)),
    budget: 95000,
  ),
  AgentLead(
    id: '2',
    customerName: AppLocaleKey.agentSimName2.tr(),
    phoneNumber: '0559876543',
    carInterest: AppLocaleKey.agentSimCarPatrol.tr() + " 2023",
    status: LeadStatus.inProgress,
    lastContact: DateTime.now().subtract(const Duration(days: 1)),
    budget: 185000,
  ),
  AgentLead(
    id: '3',
    customerName: AppLocaleKey.agentSimName3.tr(),
    phoneNumber: '0534567890',
    carInterest: AppLocaleKey.agentSimCarX5.tr() + " 2024",
    status: LeadStatus.closed,
    lastContact: DateTime.now().subtract(const Duration(days: 2)),
    budget: 285000,
  ),
  AgentLead(
    id: '4',
    customerName: AppLocaleKey.agentSimName4.tr(),
    phoneNumber: '0521112233',
    carInterest: AppLocaleKey.agentSimCarTucson.tr() + " 2024",
    status: LeadStatus.newLead,
    lastContact: DateTime.now().subtract(const Duration(hours: 5)),
    budget: 75000,
  ),
  AgentLead(
    id: '5',
    customerName: AppLocaleKey.agentSimName5.tr(),
    phoneNumber: '0567891234',
    carInterest: AppLocaleKey.agentSimCarLX600.tr() + " 2023",
    status: LeadStatus.lost,
    lastContact: DateTime.now().subtract(const Duration(days: 5)),
    budget: 350000,
  ),
];

List<AgentAppointment> getAgentAppointments() => [
  AgentAppointment(
    id: '1',
    customerName: AppLocaleKey.agentSimName1.tr(),
    carModel: AppLocaleKey.agentSimCarCamry.tr() + " 2024",
    dateTime: DateTime.now().add(const Duration(hours: 2)),
    location: AppLocaleKey.agentSimLocationRiyadh.tr(),
    status: AppointmentStatus.upcoming,
  ),
  AgentAppointment(
    id: '2',
    customerName: AppLocaleKey.agentSimName2.tr(),
    carModel: AppLocaleKey.agentSimCarPatrol.tr() + " 2023",
    dateTime: DateTime.now().add(const Duration(hours: 5)),
    location: AppLocaleKey.agentSimLocationJeddah.tr(),
    status: AppointmentStatus.upcoming,
  ),
  AgentAppointment(
    id: '3',
    customerName: AppLocaleKey.agentSimName3.tr(),
    carModel: AppLocaleKey.agentSimCarX5.tr() + " 2024",
    dateTime: DateTime.now().subtract(const Duration(hours: 3)),
    location: AppLocaleKey.agentSimLocationKhobar.tr(),
    status: AppointmentStatus.done,
  ),
];

List<AgentCar> getAgentCars() => [
  AgentCar(
    id: '1',
    name: AppLocaleKey.agentSimCarCamry.tr() + " 2024",
    brand: 'تويوتا',
    price: 95000,
    imageUrl: '',
    availability: CarAvailability.available,
    year: '2024',
    mileage: '0',
    color: 'أبيض',
  ),
  AgentCar(
    id: '2',
    name: AppLocaleKey.agentSimCarPatrol.tr() + " 2024",
    brand: 'نيسان',
    price: 185000,
    imageUrl: '',
    availability: CarAvailability.reserved,
    year: '2023',
    mileage: '12,000',
    color: 'فضي',
  ),
  AgentCar(
    id: '3',
    name: AppLocaleKey.agentSimCarX5.tr() + " 2024",
    brand: 'BMW',
    price: 285000,
    imageUrl: '',
    availability: CarAvailability.sold,
    year: '2024',
    mileage: '0',
    color: 'أسود',
  ),
  AgentCar(
    id: '4',
    name: AppLocaleKey.agentSimCarTucson.tr() + " 2024",
    brand: 'هيونداي',
    price: 75000,
    imageUrl: '',
    availability: CarAvailability.available,
    year: '2024',
    mileage: '0',
    color: 'أزرق',
  ),
  AgentCar(
    id: '5',
    name: AppLocaleKey.agentSimCarLX600.tr() + " 2023",
    brand: 'لكزس',
    price: 490000,
    imageUrl: '',
    availability: CarAvailability.available,
    year: '2023',
    mileage: '5,000',
    color: 'أبيض',
  ),
];
