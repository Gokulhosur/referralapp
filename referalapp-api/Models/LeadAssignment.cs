using System;
using System.Collections.Generic;

namespace ReferalApp.Models;

public partial class LeadAssignment
{
    public long Id { get; set; }

    public long? LeadId { get; set; }

    public long? AssignedTo { get; set; }

    public long? AssignedBy { get; set; }

    public DateTime? AssignedDate { get; set; }

    public virtual EmployeeDetail? AssignedToNavigation { get; set; }

    public virtual Lead? Lead { get; set; }
}
