using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using ReferalApp.Models;
using ReferalApp.Services;
using ReferalApp.Utils;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Controllers
{
    [ApiController]
    public class ReferrerPayoutController : ControllerBase
    {
        private readonly IOptions<AppConfig> appSettings;
        LoanReferContext db;
        ReferrerPayoutServices _referrerPayoutServices;
        IWebHostEnvironment env;
        private IConfiguration _config;
        Common cmn;

        public ReferrerPayoutController(IOptions<AppConfig> appConfig, LoanReferContext dbContext, IWebHostEnvironment env, IConfiguration config, ILogger<ReferrerPayoutController> logger)
        {
            appSettings = appConfig;
            db = dbContext;
            _referrerPayoutServices = new ReferrerPayoutServices(dbContext, logger, appSettings);
            this.env = env;
            _config = config;
            cmn = new Common(dbContext, appConfig);
        }


        //Created by PraveenKumar on 02/04/2024
        //Insert or Update Referrer Payout Details


        [HttpPost]
        [Route("api/loanReferal/ReferrerPayout/InsertorUpdateReferrerPayoutDetails")]
        public async Task<object> InsertorUpdateReferrerPayoutDetails([FromBody] ReferrerPayoutReq request)
        {
            try
            {
                //Converting JSON Body into a String
                //cmn.LogToFile("API Name : api/loanReferal/ReferrerPayout/InsertorUpdateReferrerPayoutDetails | " + "Request Data : " + request);

                var response = await Task.FromResult(_referrerPayoutServices.InsertorUpdateReferrerPayoutDetails(request));

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
                //cmn.LogToFile("API Name : api/loanReferal/ReferrerPayout/InsertorUpdateReferrerPayoutDetails | " + "Message : " + ex.Message);

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
