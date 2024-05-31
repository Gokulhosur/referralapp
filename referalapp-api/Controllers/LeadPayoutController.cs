using FluentValidation;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using ReferalApp.Models;
using ReferalApp.Services;
using ReferalApp.Utils;
using ReferalApp.ValidationRules;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Model;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Controllers
{
    [ApiController]
    public class LeadPayoutController : ControllerBase
    {
        private readonly IOptions<AppConfig> appSettings;
        LoanReferContext db;
        LeadPayoutServices _leadPayoutServicesServices;
        IWebHostEnvironment env;
        private IConfiguration _config;
        private readonly ILogger<LeadPayoutController> _logger;
        Common cmn;

        public LeadPayoutController(IOptions<AppConfig> appConfig, LoanReferContext dbContext, IWebHostEnvironment env, IConfiguration config, ILogger<LeadPayoutController> logger)
        {
            appSettings = appConfig;
            db = dbContext;
            _leadPayoutServicesServices = new LeadPayoutServices(dbContext, logger, appSettings);
            this.env = env;
            _config = config;
            _logger = logger;
            cmn = new Common(dbContext, appConfig);
        }



        //Created by PraveenKumar on 01/04/2024
        //Insert or Update Lead Payout Details

        [HttpPost]
        [Route("api/loanReferal/LeadPayout/InsertorUpdateLeadPayoutDetails")]
        public async Task<object> InsertorUpdateLeadPayoutDetails([FromBody] LeadPayoutDetails request)
        {
            try
            {
                //Converting JSON Body into a String
                //cmn.LogToFile("API Name : api/loanReferal/LeadPayout/InsertorUpdateLeadPayoutDetails | " + "Request Data : " + request);

                var loanTypeDet = (from a in db.Leads
                                   join b in db.LoanTypeMasters on a.LoanTypeMasterId equals b.Id
                                   where a.Id == request.leadId
                                   select b.Id).FirstOrDefault();

                long loanTypeId = (long)loanTypeDet;

                var response = await Task.FromResult(_leadPayoutServicesServices.InsertorUpdateLeadPayoutDetails(request, loanTypeId));

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
                //cmn.LogToFile("API Name : api/loanReferal/LeadPayout/InsertorUpdateLeadPayoutDetails | " + "Message : " + ex.Message);

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
        //Get Lead Payout Details By Lead Id

        [HttpGet]
        [Route("api/loanReferal/LeadPayout/GetLeadPayoutDetailsByLeadId")]
        public async Task<object> GetLeadPayoutDetailsByLeadId(long leadId)
        {
            try
            {
                //cmn.LogToFile("API Name : api/loanReferal/LeadPayout/GetLeadPayoutDetailsByLeadId | " + "LeadId : " + leadId);

                //LeadsParamValidator validators = new LeadsParamValidator();
                //var validationResult = validators.Validate(leadId);

                //if (!validationResult.IsValid)
                //{
                //    cmn.LogToFile("API Name : api/Registration/InsertorUpdatePropertyOwnerRegistration | " + "Message : " + appSettings.Value.LeadIdInvalid);

                //    return new
                //    {
                //        status = appSettings.Value.ErrorMessage,
                //        statusCode = 400,
                //        time = DateTime.Now,
                //        data = validationResult.Errors[0].ErrorMessage
                //    };
                //}

                var response = await Task.FromResult(_leadPayoutServicesServices.GetLeadPayoutDetailsByLeadId(leadId));

                if (response.isSuccess == true)
                {
                    //cmn.LogToFile("API Name : api/loanReferal/LeadPayout/GetLeadPayoutDetailsByLeadId | " + "Message : Success");

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
                    //cmn.LogToFile("API Name : api/loanReferal/LeadPayout/GetLeadPayoutDetailsByLeadId | " + "Message : Error");

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
                //cmn.LogToFile("API Name : api/loanReferal/LeadPayout/GetAllLeadPayoutDetails | " + "Message : " + ex.Message);

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
