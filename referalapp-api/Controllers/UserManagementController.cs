using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using ReferalApp.Models;
using ReferalApp.Services;
using ReferalApp.Utils;

namespace ReferalApp.Controllers
{
    [ApiController]
    public class UserManagementController : ControllerBase
    {

        private readonly IOptions<AppConfig> appSettings;
        LoanReferContext db;
        UserManagementService _userManagementServices;
        IWebHostEnvironment env;
        private IConfiguration _config;
        private readonly ILogger<UserManagementController> _logger;
        Common cmn;

        public UserManagementController(IOptions<AppConfig> appConfig, LoanReferContext dbContext, IWebHostEnvironment env, IConfiguration config, ILogger<UserManagementController> logger)
        {
            appSettings = appConfig;
            db = dbContext;
            _userManagementServices = new UserManagementService(dbContext, logger, appSettings);
            this.env = env;
            _config = config;
            _logger = logger;
            cmn = new Common(dbContext, appConfig);
        }

        [HttpGet]
        [Route("api/loanReferal/UserManagement/GetAllUserHistory")]
        public async Task<object> GetAllUserHistory()
        {
            try
            {
                var response = await Task.FromResult(_userManagementServices.GetAllUserHistory());
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
            catch(Exception ex)
            {
                return new
                {
                    status = appSettings.Value.ErrorMessage,
                    time = DateTime.Now,
                    data = ex.Message
                };
            }
        }


    }
}
