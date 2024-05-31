using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class RefererDetail
{
    public long Id { get; set; }

    public string? RefererId { get; set; }

    public string? FirstName { get; set; }

    public string? LastName { get; set; }

    public string? EmailId { get; set; }

    public DateTime? DateOfBirth { get; set; }

    public string? PanNumber { get; set; }

    public string? Password { get; set; }

    public string? BankName { get; set; }

    public string? AccountHolderName { get; set; }

    public string? AccountNumber { get; set; }

    public string? IfscCode { get; set; }

    public DateTime? LastUpdatedAt { get; set; }

    public string? ProfilePicUrl { get; set; }

    public DateTime? SignupDate { get; set; }

    public string? Status { get; set; }

    public string? MobileNumber { get; set; }

    public string? NoteDetails { get; set; }

    public virtual ICollection<Lead> Leads { get; set; } = new List<Lead>();

    public virtual ICollection<RefererDocument> RefererDocuments { get; set; } = new List<RefererDocument>();

    public virtual ICollection<RefererPayout> RefererPayouts { get; set; } = new List<RefererPayout>();
}
