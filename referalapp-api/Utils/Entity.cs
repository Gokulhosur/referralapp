namespace ReferalApp.Utils
{
    public class Entity
    {
        public class ResponseObj<T> where T : class
        {
            public int responseCode { get; set; }
            public bool isSuccess { get; set; }
            public object? data { get; set; }
            public string? message { get; set; }
        }
        public class RefererDetailsReq
        {
            public long Id { get; set; }
            public long? RefererId { get; set; }
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
            public string? ProfilePicUrl { get; set; }
            public string? NoteDetails { get; set; }
            public string? MobileNumber { get; set; }
            

        }
        public class RefereDocumetReq
        {
            public long Id { get; set; }
            public long? RefererDetailsId { get; set; }
            public long? DocumentTypeMasterId { get; set; }
            public string? DocumentUrl { get; set; }
        }
        public class EmployeeReq
        {
            public long Id { get; set; }
            public long DesignationMasterId { get; set; }
            public string? EmployeeNumber { get; set; }
            public string? EmployeeName { get; set; }
            public string? Status { get; set; }
        }
        public class LeadsDetailsReq
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
            public decimal? ExpectedLoanAmount { get; set; }
            public string? LoanPurpose { get; set; }
            public long? LeadsStatusMasterId { get; set; }
            public DateTime? LastUpdatedDate { get; set; }
            public long? LastUpdatedBy { get; set; }

        }

        //Update Assigned To User Details
        public class UserDetail
        {
            public List<UserDetailsList>? userDetailslis { get; set; }
        }
        public class UserDetailsList
        {
            public long? leadId { get; set; }
            public long? assignedTo { get; set; }
            public long? assignedBy { get; set; }
        }

        //Insert or Update Lead Payout Details
        public class LeadPayoutDetails
        {
            public long? id { get; set; }
            public long? leadId { get; set; }
            public decimal disbursedAmount { get; set; }
            public decimal commission { get; set; }
            public decimal transactionAmount { get; set; }
            public DateTime disbursedDate { get; set; }
            public string? invoiceUrl { get; set; }
            public string? signedInvoiceUrl { get; set; }
            public string? transactionRefDocumentUrl { get; set; }
            public long? statusId { get; set; }
            public long? userId { get; set; }
            public DateTime? transactionDate { get; set; }

        }

        //Insert or Update Referrer Payout Details
        public class ReferrerPayoutReq
        {
            public long? id { get; set;}
            public long? referrerDetailId { get; set;}
            public decimal? totalPayout { get; set;}
            public decimal? sanctionedPayout { get; set;}
            public decimal? balancePayout { get; set;}
            public long? payoutPercentageId { get; set;}
        }

        //Insert or Update Product

        public class Productdetails
        {
            public long id { get; set;}
            public long? loanTypeId { get; set;}
            public long? userId { get; set;}
            public decimal? amount { get; set;}
            public string? commissionType { get; set;}
            public decimal? commission { get; set;}
            public string? status { get; set;}
        }
    }

    public class Leadsparam
    {
        public long? leadId { get; set;}
    }
}
