using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using ReferalApp.Models;
using ReferalApp.Services;
using ReferalApp.Utils;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Controllers
{
    [ApiController]
    public class AdminController : ControllerBase
    {
        private readonly IOptions<AppConfig> appSettings;
        LoanReferContext db;
        AdminServices _adminServices;
        IWebHostEnvironment env;
        private IConfiguration _config;
        private readonly ILogger<AdminController> _logger;
        Common cmn;

        public AdminController(IOptions<AppConfig> appConfig, LoanReferContext dbContext, IWebHostEnvironment env, IConfiguration config, ILogger<AdminController> logger)
        {
            appSettings = appConfig;
            db = dbContext;
            _adminServices = new AdminServices(dbContext, logger, appSettings);
            this.env = env;
            _config = config;
            _logger = logger;
            cmn = new Common(dbContext, appConfig);
        }

        [HttpGet]
        [Route("api/loanReferal/Admin/AdminLogin")]
        public async Task<object> AdminLogin(string userName, string password)
        {
            try
            {
                var response = await Task.FromResult(_adminServices.AdminLogin(userName, password));
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
                return new
                {
                    status = appSettings.Value.ErrorMessage,
                    time = DateTime.Now,
                    data = ex.Message
                };
            }
        }

        [HttpPost]
        [Route("api/loanReferal/Admin/InsrtOrUpdateEmployee")]
        public async Task<object> InsrtOrUpdateEmployee([FromBody] EmployeeReq request)
        {
            try
            {
                var response = await Task.FromResult(_adminServices.InsertOrUpdateEmployee(request));
                if (response.isSuccess == true)
                {
                    return new
                    {
                        status = "Success",
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
                        status = "Error",
                        data = response.data,
                        statusCode = response.responseCode,
                        message = response.message,
                        time = DateTime.Now
                    };
                }
            }
            catch (Exception ex)
            {
                return new
                {
                    status = "Error",
                    time = DateTime.Now,
                    data = ex.Message
                };
            }
        }

        [HttpGet]
        [Route("api/loanReferal/Admin/GetEmployeeDet")]
        public async Task<object> GetEmployee(long empId)
        {
            try
            {
                var response = await Task.FromResult(_adminServices.GetAllEmployees(empId));
                if (response.isSuccess == true)
                {
                    return new
                    {
                        status = "Success",
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
                        status = "Error",
                        data = response.data,
                        statusCode = response.responseCode,
                        message = response.message,
                        time = DateTime.Now
                    };
                }
            }
            catch (Exception ex)
            {
                return new
                {
                    status = "Error",
                    time = DateTime.Now,
                    data = ex.Message
                };
            }
        }
    }
}
