# Project State - Invoice Manager

## Model Refactoring Complete

### Model Changes (Completed)

1. **Contractor** - Simplified:
   - Removed: address, email, phone, bankAccount, bankName, bankSwift
   - Added: contractorInfo (markdown multiline)
   - Kept: id, name, fullName, paymentInfo, signature

2. **Company** - Simplified:
   - Removed: address, email, phone, contactPerson
   - Added: companyInfo (markdown multiline)
   - Kept: id, name, abbr, paymentWeeks, currencyPrefix

3. **Contract** - New entity:
   - Links Contractor and Company
   - Fields: id, contractorId, companyId, date, fixed, defaultPrice, showPeriod, qtyLabel
   - fixed: if true, invoice shows Amount directly; if false, shows Qty × Price
   - defaultPrice: default price for invoice items when fixed=false
   - showPeriod: whether to show period column in invoice
   - qtyLabel: customizable label for quantity (e.g., "Hours", "Qty")

4. **Invoice** - Restructured:
   - Removed: contractor, company direct references
   - Added: contractId (reference to Contract)
   - Added: displayId (computed from date)
   - ID format: timestamp-based ID, display shows "INV-YYYYMMDD"

5. **InvoiceItem** - Extended:
   - Added: amount (optional, for fixed price mode)
   - totalAmount: uses amount if present, otherwise qty × price

### UI Components (Completed)

- ✅ contractors_management_modal.dart - Updated for new model
- ✅ companies_management_modal.dart - Updated for new model
- ✅ contract_management_modal.dart - Created for Contract management
- ✅ invoice_form_modal.dart - Rewritten for Contract-based workflow
  - Contract selection instead of Contractor/Company
  - Dynamic table columns based on contract.fixed and contract.showPeriod
  - Support for fixed mode with Amount field
- ✅ invoice_list_item.dart - Updated with async contract loading
- ✅ invoice_list_panel.dart - Updated to show contract info
- ✅ invoice_details_panel.dart - Rewritten for new models
  - Async loading of Contract, Contractor, Company
  - Markdown display for contractorInfo and companyInfo
  - Dynamic table based on contract settings
- ✅ invoice_pdf_service.dart - Rewritten for new models
  - Accepts AppRepository for async data loading
  - Dynamic layout based on contract settings

### Repository Changes

- ✅ AppRepository - Added contracts repository
- ✅ seed_data_repository.dart - Added sample Contract creation
- ✅ EntityRepository - Extends ChangeNotifier for reactive updates

### Architecture

- Repositories extend ChangeNotifier and call notifyListeners() on save/delete
- EntityListBuilder/EntityOneBuilder widgets for reactive updates
- Contract provides link between Contractor and Company
- Async loading pattern for invoice-related data

### Testing

- ✅ All tests passing (13 tests)
- ✅ widget_test.dart updated for new model structure

### Current Status

- ✅ Flutter analyze: 0 errors
- ✅ All tests passing
- ✅ Seed data includes sample Contract
- ✅ Full Contract-based workflow implemented

### Usage Flow

1. Create Contractor
2. Create Company
3. Create Contract linking them with pricing rules
4. Create Invoice selecting Contract
5. Invoice items adapt based on Contract.fixed and Contract.showPeriod
6. PDF export respects Contract settings
