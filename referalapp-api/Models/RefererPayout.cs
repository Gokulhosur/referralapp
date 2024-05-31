using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class RefererPayout
{
    public long Id { get; set; }

    public long? RefererDetailsId { get; set; }

    public decimal? TotalPayout { get; set; }

    public decimal? SanctionedPayout { get; set; }

    public decimal? BalancePayout { get; set; }

    public string? TransactionNumber { get; set; }

    public string? TransactionDocumentUrl { get; set; }

    public long? PayoutPercentageMaster { get; set; }

    public DateTime? TransactionDate { get; set; }

    public long? CreatedBy { get; set; }

    public DateTime? CreatedDate { get; set; }

    public long? UpdatedBy { get; set; }

    public DateTime? UpdatedDate { get; set; }

    public virtual PayoutPercentageMaster? PayoutPercentageMasterNavigation { get; set; }

    public virtual RefererDetail? RefererDetails { get; set; }
}
