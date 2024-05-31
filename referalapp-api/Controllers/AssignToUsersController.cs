using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using ReferalApp.Models;
using ReferalApp.Services;
using ReferalApp.Utils;
using ReferalApp.ValidationRules;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Controllers
{   
    [ApiController]
    public class AssignToUsersController : ControllerBase
    {
        private readonly IOptions<AppConfig> appSettings;
        LoanReferContext db;
        AssighToUsersService _assignToUserServices;
        IWebHostEnvironment env;
        private IConfiguration _config;
        private readonly ILogger<AssignToUsersController> _logger;
        Common cmn;

        public AssignToUsersController(IOptions<AppConfig> appConfig, LoanReferContext dbContext, IWebHostEnvironment env, IConfiguration config, ILogger<AssignToUsersController> logger)
        {
            appSettings = appConfig;
            db = dbContext;
            _assignToUserServices = new AssighToUsersService(dbContext, logger, appSettings);
            this.env = env;
            _config = config;
            _logger = logger;
            cmn = new Common(dbContext, appConfig);
        }


        //Created by PraveenKumar on 01/04/2024
        //Get Asign To User Account Page Grid Bind

        [HttpGet]
        [Route("api/loanReferal/AssignToUser/GetUserAccountGridBind")]
        public async Task<object> GetUserAccountGridBind()
        {
            try
            {
                //cmn.LogToFile("API Name : api/loanReferal/AssignToUser/GetUserAccountGridBind | " + "Request : None ");

                var response = await Task.FromResult(_assignToUserServices.GetUserAccountGridBind());

                if (response.isSuccess == true)
                {
                    //cmn.LogToFile("API Name : api/loanReferal/AssignToUser/GetUserAccountGridBind | " + "Message : Success");

                    return new
                    {
                        status = appSettings.Value.SuccessMessage,
                        statusCode = response.responseCode,
                        message = response.message,
                        time = DateTime.Now,
                        data = response.data,
                    };
                }
                else
                {
                    //cmn.LogToFile("API Name : api/loanReferal/AssignToUser/GetUserAccountGridBind | " + "Message : Error");

                    return new
                    {
                        status = appSettings.Value.ErrorMessage,
                        statusCode = response.responseCode,
                        message = response.message,
                        time = DateTime.Now,
                        data = response.data,
                    };
                }
            }
            catch (Exception ex)
            {
                //cmn.LogToFile("API Name : api/loanReferal/AssignToUser/GetUserAccountGridBind | " + "Message : " + ex.Message);

                return new
                {
                    status = appSettings.Value.ErrorMessage,
                    time = DateTime.Now,
                    data = ex.Message,
                    data2 = ex.StackTrace
                };
            }
        }


        //Created by PraveenKumar on 01/04/2024
        //Get Employee Details for Dropdown for Assigned To Value

        [HttpGet]
        [Route("api/loanReferal/AssignToUser/GetEmployeeDropdown")]
        public async Task<object> GetEmployeeDropdown()
        {
            try
            {
                //cmn.LogToFile("API Name : api/loanReferal/AssignToUser/GetEmployeeDropdown | " + "Request : None ");

                var response = await Task.FromResult(_assignToUserServices.GetEmployeeDropdown());

                if (response.isSuccess == true)
                {
                   // cmn.LogToFile("API Name : api/loanReferal/AssignToUser/GetEmployeeDropdown | " + "Message : Success");

                    return new
                    {
                        status = appSettings.Value.SuccessMessage,
                        statusCode = response.responseCode,
                        message = response.message,
                        time = DateTime.Now,
                        data = response.data,
                    };
                }
                else
                {
                    //cmn.LogToFile("API Name : api/loanReferal/AssignToUser/GetEmployeeDropdown | " + "Message : Error");

                    return new
                    {
                        status = appSettings.Value.ErrorMessage,
                        statusCode = response.responseCode,
                        message = response.message,
                        time = DateTime.Now,
                        data = response.data,
                    };
                }
            }
            catch (Exception ex)
            {
                //cmn.LogToFile("API Name : api/loanReferal/AssignToUser/GetEmployeeDropdown | " + "Message : " + ex.Message);

                return new
                {
                    status = appSettings.Value.ErrorMessage,
                    time = DateTime.Now,
                    data = ex.Message,
                    data2 = ex.StackTrace
                };
            }
        }

        //Created by PraveenKumar
        //Update Assigned To User Details

        [HttpPost]
        [Route("api/loanReferal/AssignToUser/UpdateAssignedToUserDetails")]
        public async Task<object> UpdateAssignedToUserDetails([FromBody] UserDetail request)
        {
            try
            {
                //Converting JSON Body into a String
                //cmn.LogToFile("API Name : api/loanReferal/AssignToUser/UpdateAssignedToUserDetails | " + "Request Data : " + request);

                var response = await Task.FromResult(_assignToUserServices.UpdateAssignedToUserDetails(request));

                if (response.isSuccess == true)
                {
                    return new
                    {
                        status = appSettings.Value.SuccessMessage,
                        data = response.data,
                        statusCode = response.responseCode,
                        message = response.message,
                        time = DateTime.Now
                    };
                }
                else
                {
                    return new
                    {
                        status = appSettings.Value.ErrorMessage,
                        data = response.data,
                        statusCode = response.responseCode,
                        message = response.message,
                        time = DateTime.Now
                    };
                }
            }

            catch (Exception ex)
            {
                //cmn.LogToFile("API Name : api/loanReferal/AssignToUser/GetEmployeeDropdown | " + "Message : " + ex.Message);

                return new
                {
                    status = appSettings.Value.ErrorMessage,
                    time = DateTime.Now,
                    data = ex.Message,
                    data2 = ex.StackTrace
                };
            }
        }

    }
}
