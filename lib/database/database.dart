import 'package:drift/drift.dart';

class DbContractors extends Table {
  TextColumn get id => text()();
  TextColumn get abbr => text()();
  TextColumn get fullName => text()();
  TextColumn get paymentInfo => text().nullable()();
  TextColumn get contractorInfo => text().nullable()();
  BlobColumn get signature => blob().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class DbCompanies extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get abbr => text()();
  IntColumn get paymentWeeks => integer().withDefault(const Constant(3))();
  TextColumn get currencyPrefix => text().nullable()();
  TextColumn get companyInfo => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class DbContracts extends Table {
  TextColumn get id => text()();
  TextColumn get contractorId => text()();
  TextColumn get companyId => text()();
  DateTimeColumn get date => dateTime()();
  BoolColumn get fixed => boolean().withDefault(const Constant(false))();
  RealColumn get defaultPrice => real().nullable()();
  BoolColumn get showPeriod => boolean().withDefault(const Constant(true))();
  TextColumn get qtyLabel => text().nullable()();
  TextColumn get priceLabel => text().nullable()();
  TextColumn get descriptionLabel => text().nullable()();
  TextColumn get amountLabel => text().nullable()();
  TextColumn get periodLabel => text().nullable()();
  TextColumn get totalLabel => text().nullable()();
  TextColumn get dueDateLabel => text().nullable()();
  TextColumn get dateLabel => text().nullable()();
  TextColumn get invoiceIdLbl => text().nullable()();
  TextColumn get invoiceTitle => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get contractorRoleSublabel => text().nullable()();
  TextColumn get footnote => text().nullable()();
  TextColumn get contractorAgreementLabel => text().nullable()();
  TextColumn get locale => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class DbInvoices extends Table {
  TextColumn get id => text()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
  IntColumn get status => integer().withDefault(const Constant(0))();
  TextColumn get contractSnapshot => text()();
  TextColumn get contractorSnapshot => text()();
  TextColumn get companySnapshot => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class DbInvoiceItems extends Table {
  TextColumn get id => text()();
  TextColumn get invoiceId => text()();
  TextColumn get description => text()();
  TextColumn get period => text().nullable()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  RealColumn get price => real().withDefault(const Constant(0.0))();
  RealColumn get amount => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
