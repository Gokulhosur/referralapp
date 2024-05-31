using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using ReferalApp.Controllers;
using ReferalApp.Models;
using ReferalApp.Utils;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Services
{
    public class AssighToUsersService
    {
        LoanReferContext db;
        ILogger<AssignToUsersController> logger;
        private readonly IOptions<AppConfig> appSettings;
        Utilities _Utils;
        Common cmn;

        public AssighToUsersService(LoanReferContext _db, ILogger<AssignToUsersController> _logger, IOptions<AppConfig> appConfig)
        {
            db = _db;
            logger = _logger;
            appSettings = appConfig;
            _Utils = new Utilities(appConfig);
        }

        //Created by PraveenKumar on 01/04/2024
        //Get Asign To User Account Page Grid Bind
        public ResponseObj<object> GetUserAccountGridBind()
        {
            var responseObj = new ResponseObj<object>();
            try
            {

                var userAccountDetails = (from a in db.Leads
                                          join b in db.RefererDetails on a.RefererDetailsId equals b.Id
                                          join c in db.LoanTypeMasters on a.LoanTypeMasterId equals c.Id
                                          where a.LeadsStatusMasterId == 1
                                          select new
                                          {
                                              LeadId = a.Id,
                                              ApplicantName = a.ApplicantFirstName + a.ApplicantLastName,
                                              a.MobileNumber,
                                              a.LeadNumber,
                                              a.LeadCreatedDate,
                                              b.RefererId,
                                              c.LoanType

                                          }).ToList();


                responseObj.responseCode = 200;
                responseObj.isSuccess = true;
                responseObj.data = userAccountDetails;
                responseObj.message = appSettings.Value.SuccessMessage;
                return responseObj;

            }
            catch (Exception ex)
            {
                responseObj.responseCode = 500;
                responseObj.isSuccess = false;
                responseObj.data = ex.Message;
                responseObj.message = appSettings.Value.ErrorMessage;
                return responseObj;
            }

        }

        //Created by PraveenKumar on 01/04/2024
        //Get Employee Details for Dropdown for Assigned To Value
        public ResponseObj<object> GetEmployeeDropdown()
        {
            var responseObj = new ResponseObj<object>();
            try
            {

                var employeeDetails = (from a in db.EmployeeDetails
                                       where a.Status == "Active"
                                       select new
                                       {
                                           a.Id,
                                           a.EmployeeName
                                       }).ToList();


                responseObj.responseCode = 200;
                responseObj.isSuccess = true;
                responseObj.data = employeeDetails;
                responseObj.message = appSettings.Value.SuccessMessage;
                return responseObj;

            }
            catch (Exception ex)
            {
                responseObj.responseCode = 500;
                responseObj.isSuccess = false;
                responseObj.data = ex.Message;
                responseObj.message = appSettings.Value.ErrorMessage;
                return responseObj;
            }

        }

        //Created by PraveenKumar
        //Update Assigned To User Details
        public ResponseObj<object> UpdateAssignedToUserDetails([FromBody] UserDetail request)
        {
            var responseObj = new ResponseObj<object>();
            try
            {

                if (request.userDetailslis != null)
                {
                    foreach (var item in request.userDetailslis)
                    {
                        LeadAssignment leadassign = new LeadAssignment();

                        leadassign.LeadId = item.leadId;
                        leadassign.AssignedTo = item.assignedTo;
                        leadassign.AssignedBy = item.assignedBy;
                        leadassign.AssignedDate = DateTime.Now;

                        db.LeadAssignments.Add(leadassign);
                        db.SaveChanges();
                    }
                }


                responseObj.responseCode = 200;
                responseObj.isSuccess = true;
                responseObj.data = appSettings.Value.SuccessMessage;
                responseObj.message = appSettings.Value.AssignedUpdateSuccess;
                return responseObj;
            }
            catch (Exception ex)
            {
                responseObj.responseCode = 500;
                responseObj.isSuccess = false;
                responseObj.data = ex.Message;
                return responseObj;
            }
        }

    }
}
