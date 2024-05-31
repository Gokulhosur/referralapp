using static Microsoft.EntityFrameworkCore.DbLoggerCategory;
using System.Collections.Generic;

namespace ReferalApp.Utils
{
    public class AppConfig
    {
        public string? SuccessMessage { get; set; }
        public string? ErrorMessage { get; set; }

        //Update Assigned To User Details
        public string? AssignedUpdateSuccess { get; set; }

        //Insert or Update Lead Payout Details
        public string? LeadPayoutInsertSuccess { get; set; }
        public string? LeadPayoutUpdateSuccess { get; set; }
        public string? LeadIdInvalid { get; set; }

        //Get Lead Payout Details By Lead Id
        public string? LeadIdMandatory { get; set; }

        //Insert or Update Referrer Payout Details
        public string? ReferrerPayoutInsertSuccess { get; set; }
        public string? ReferrerPayoutUpdateSuccess { get; set; }

        //File Upload
        public string? FileUploadException { get; set; }

        //Insert or Update Product Details
        public string? ProductInsertSuccess { get; set; }
        public string? ProductUpdateSuccess { get; set; }
        public string? ProductIdInvalid { get; set; }

    }
}
