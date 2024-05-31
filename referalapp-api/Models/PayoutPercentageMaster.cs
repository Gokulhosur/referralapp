using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class PayoutPercentageMaster
{
    public long Id { get; set; }

    public decimal? Percentage { get; set; }

    public string? Status { get; set; }

    public virtual ICollection<RefererPayout> RefererPayouts { get; set; } = new List<RefererPayout>();
}
