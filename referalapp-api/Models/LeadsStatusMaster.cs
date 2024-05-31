using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class LeadsStatusMaster
{
    public long Id { get; set; }

    public string? StatusType { get; set; }

    public string? Status { get; set; }

    public string? Type { get; set; }

    public virtual ICollection<LeadPayout> LeadPayouts { get; set; } = new List<LeadPayout>();
}
