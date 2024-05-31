using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class LoanCommissionMaster
{
    public long Id { get; set; }

    public long? LoanTypeMasterId { get; set; }

    public decimal? Amount { get; set; }

    public decimal? Commission { get; set; }

    public string? CommissionType { get; set; }

    public string? Status { get; set; }

    public long? InsertedBy { get; set; }

    public DateTime? InsertedDate { get; set; }

    public DateTime? LastUpdatedDate { get; set; }

    public long? LastUpdatedBy { get; set; }

    public virtual LoanTypeMaster? LoanTypeMaster { get; set; }
}
