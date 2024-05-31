using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class EmployeeDetail
{
    public long Id { get; set; }

    public long DesignationMasterId { get; set; }

    public string? EmployeeNumber { get; set; }

    public string? EmployeeName { get; set; }

    public string? Status { get; set; }

    public string? Password { get; set; }

    public string? UserName { get; set; }

    public DateTime? LastUpdatedAt { get; set; }

    public virtual DesignationMaster DesignationMaster { get; set; } = null!;

    public virtual ICollection<EmployeeActiveLog> EmployeeActiveLogs { get; set; } = new List<EmployeeActiveLog>();

    public virtual ICollection<LeadAssignment> LeadAssignments { get; set; } = new List<LeadAssignment>();
}
