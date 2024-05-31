using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class DocumentTypeMaster
{
    public long Id { get; set; }

    public string? DocumentType { get; set; }

    public string? Status { get; set; }

    public virtual ICollection<RefererDocument> RefererDocuments { get; set; } = new List<RefererDocument>();
}
