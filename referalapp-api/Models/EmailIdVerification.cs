using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class EmailIdVerification
{
    public long Id { get; set; }

    public string? EmailId { get; set; }

    public string? VerficationCode { get; set; }

    public DateTime? ExpiryDate { get; set; }
}
