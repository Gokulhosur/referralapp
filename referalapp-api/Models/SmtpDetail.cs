using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class SmtpDetail
{
    public long Id { get; set; }

    public long? SmtpDetailId { get; set; }

    public string? SmtpDomainName { get; set; }

    public long? Smtpport { get; set; }

    public string? Smtpuseremail { get; set; }

    public string? Smtppassword { get; set; }
}
