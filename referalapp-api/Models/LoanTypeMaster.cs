using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class LoanTypeMaster
{
    public long Id { get; set; }

    public string? LoanType { get; set; }

    public string? Status { get; set; }

    public virtual ICollection<LeadPayout> LeadPayouts { get; set; } = new List<LeadPayout>();

    public virtual ICollection<Lead> Leads { get; set; } = new List<Lead>();

    public virtual ICollection<LoanCommissionMaster> LoanCommissionMasters { get; set; } = new List<LoanCommissionMaster>();
}
