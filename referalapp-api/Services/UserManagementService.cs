using Microsoft.Extensions.Options;
using ReferalApp.Controllers;
using ReferalApp.Models;
using ReferalApp.Utils;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Services
{
    public class UserManagementService
    {
        LoanReferContext db;
        ILogger<UserManagementController> logger;
        private readonly IOptions<AppConfig> appSettings;
        Utilities _Utils;
        Common cmn;

        public UserManagementService(LoanReferContext _db, ILogger<UserManagementController> _logger, IOptions<AppConfig> appConfig)
        {
            db = _db;
            logger = _logger;
            appSettings = appConfig;
            _Utils = new Utilities(appConfig);
        }

        public ResponseObj<object> GetAllUserHistory()
        {
            var responseObj = new ResponseObj<object>();
            try
            {                         
                    var _userDetails = (from x in db.EmployeeDetails
                                     select new
                                     {
                                         x.Id,
                                         x.EmployeeNumber,
                                         x.EmployeeName,
                                         x.LastUpdatedAt,
                                         x.Status,
                                         Deparment = db.DesignationMasters.Where(c => c.Id == x.DesignationMasterId).Select(x => x.Designation).FirstOrDefault()
                                     }).ToList();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = new
                    {
                        _userDetails = _userDetails
                    };
                    responseObj.message = "Success";
                    return responseObj;

                }
            catch (Exception ex)
            {
                responseObj.responseCode = 500;
                responseObj.isSuccess = false;
                responseObj.data = ex.Message;
                responseObj.message = "Error";
                return responseObj;
            }

        }

    }
}
