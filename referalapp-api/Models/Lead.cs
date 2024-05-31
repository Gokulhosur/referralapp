using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class Lead
{
    public long Id { get; set; }

    public long? RefererDetailsId { get; set; }

    public string? ApplicantFirstName { get; set; }

    public string? ApplicantLastName { get; set; }

    public string? MobileNumber { get; set; }

    public string? EmailId { get; set; }

    public DateTime? DateOfBirth { get; set; }

    public string? MaritalStatus { get; set; }

    public string? Gender { get; set; }

    public string? ResidentialType { get; set; }

    public string? Address { get; set; }

    public string? CountryCode { get; set; }

    public string? CountryName { get; set; }

    public string? StateCode { get; set; }

    public string? StateName { get; set; }

    public string? CityCode { get; set; }

    public string? CityName { get; set; }

    public string? Pincode { get; set; }

    public string? OrganizationType { get; set; }

    public string? OrganizationName { get; set; }

    public decimal? AnnualIncome { get; set; }

    public string? PanNumber { get; set; }

    public long? LoanTypeMasterId { get; set; }

    public string? LeadNumber { get; set; }

    public decimal? ExpectedLoanAmount { get; set; }

    public string? LoanPurpose { get; set; }

    public long? LeadsStatusMasterId { get; set; }

    public DateTime? LeadCreatedDate { get; set; }

    public DateTime? LastUpdatedDate { get; set; }

    public long? LastUpdatedBy { get; set; }

    public virtual ICollection<LeadAssignment> LeadAssignments { get; set; } = new List<LeadAssignment>();

    public virtual ICollection<LeadPayout> LeadPayouts { get; set; } = new List<LeadPayout>();

    public virtual LoanTypeMaster? LoanTypeMaster { get; set; }

    public virtual RefererDetail? RefererDetails { get; set; }
}
