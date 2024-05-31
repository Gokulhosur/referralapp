using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class EmployeeActiveLog
{
    public long Id { get; set; }

    public long? EmployeeDetailsId { get; set; }

    public DateTime? LoginDate { get; set; }

    public DateTime? LogoutDate { get; set; }

    public virtual EmployeeDetail? EmployeeDetails { get; set; }
}
