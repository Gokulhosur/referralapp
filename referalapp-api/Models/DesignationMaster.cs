using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class DesignationMaster
{
    public long Id { get; set; }

    public string? Designation { get; set; }

    public string? Status { get; set; }

    public virtual ICollection<EmployeeDetail> EmployeeDetails { get; set; } = new List<EmployeeDetail>();
}
