using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class LeadPayout
{
    public long Id { get; set; }

    public long? LeadId { get; set; }

    public decimal? DisbursedAmount { get; set; }

    public DateTime? DisbursedDate { get; set; }

    public string? InvoiceUrl { get; set; }

    public string? SignedInvoiceUrl { get; set; }

    public decimal? Commission { get; set; }

    public string? CommissionType { get; set; }

    public long? LoanTypeMasterId { get; set; }

    public DateTime? TransactionDate { get; set; }

    public decimal? TransactionAmount { get; set; }

    public string? TransactionRefDocumentUrl { get; set; }

    public long? LeadStatusMasterId { get; set; }

    public long? InsertedBy { get; set; }

    public DateTime? InsertedDate { get; set; }

    public DateTime? LastUpdatedDate { get; set; }

    public long? LastUpdatedBy { get; set; }

    public virtual Lead? Lead { get; set; }

    public virtual LeadsStatusMaster? LeadStatusMaster { get; set; }

    public virtual LoanTypeMaster? LoanTypeMaster { get; set; }
}
