using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class RefererDocument
{
    public long Id { get; set; }

    public long? RefererDetailsId { get; set; }

    public long? DocumentTypeMasterId { get; set; }

    public string? DocumentUrl { get; set; }

    public virtual DocumentTypeMaster? DocumentTypeMaster { get; set; }

    public virtual RefererDetail? RefererDetails { get; set; }
}
