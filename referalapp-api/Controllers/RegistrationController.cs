using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using ReferalApp.Models;
using ReferalApp.Services;
using ReferalApp.Utils;
using System.Net.Mail;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Controllers
{

    [ApiController]
    public class RegistrationController : ControllerBase
    {
        private readonly IOptions<AppConfig> appSettings;
        LoanReferContext db;
        RegistrationServices _registrationServices;
        IWebHostEnvironment env;
        private IConfiguration _config;
        private readonly ILogger<RegistrationController> _logger;
        Common cmn;

        public RegistrationController(IOptions<AppConfig> appConfig, LoanReferContext dbContext, IWebHostEnvironment env, IConfiguration config, ILogger<RegistrationController> logger)
        {
            appSettings = appConfig;
            db = dbContext;
            _registrationServices = new RegistrationServices(dbContext, logger, appSettings);
            this.env = env;
            _config = config;
            _logger = logger;
            cmn = new Common(dbContext, appConfig);
        }

        [HttpGet]
        [Route("api/loanReferal/Registration/Test")]
        public object Test()
        {
            return "Test";
        }

        [HttpGet]
        [Route("api/loanReferal/Registration/getEmailOtp")]
        public async Task<object> GetOtp(string emailId)
        {
            try
            {
                var response = await Task.FromResult(cmn.SendEmailOTP(emailId));
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

        [HttpGet]
        [Route("api/loanReferal/Registration/forgotEmailOtp")]
        public async Task<object> forgotEmailOtp(string emailId)
        {
            try
            {
                var response = await Task.FromResult(cmn.ForgotEmailOTP(emailId));
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

        [HttpGet]
        [Route("api/loanReferal/Registration/ChangePassword")]
        public async Task<object> ChangePassword(string emailId, string password)
        {
            try
            {
                var response = await Task.FromResult(_registrationServices.FogotPassword(emailId, password));
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



        [HttpGet]
        [Route("api/loanReferal/Registration/getReferalDetails")]
        public async Task<object> getReferalDetails(long refererDetailsId, long leadStatusId)
        {
            try
            {
                var response = await Task.FromResult(_registrationServices.GetReferalDetailsForAdmin(refererDetailsId, leadStatusId));
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

        [HttpGet]
        [Route("api/loanReferal/Registration/getReferalDetailsById")]
        public async Task<object> getReferalDetailsById(long refererDetailsId)
        {
            try
            {
                var response = await Task.FromResult(_registrationServices.GetReferalDetails(refererDetailsId));
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
        [Route("api/loanReferal/Registration/Login")]
        public async Task<object> getReferalDetails(string email, string password)
        {
            try
            {
                var response = await Task.FromResult(_registrationServices.Login(email, password));
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
        [Route("api/loanReferal/Registration/InsertOrUpdateReferelDet")]
        public async Task<object> InsertOrUpdateRefere([FromBody] RefererDetailsReq request)
        {
            try
            {
                var response = await Task.FromResult(_registrationServices.InsertOrUpdateRefererDetails(request));
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
        [Route("api/loanReferal/Registration/VerifyEmailOtp")]
        public async Task<object> VerifyEmailOtp(string email, string otp)
        {
            try
            {
                var response = await Task.FromResult(cmn.VerifyEmailOTP(email,otp));
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
        [Route("api/loanReferal/Registration/fileupload")]
        public object fileUpload()
        {
            try
            {
                var files = Request.Form.Files;

                var file = files[0];
                string physicalPath = "";
                string FileName = "";
                try
                {
                    Guid gid = Guid.NewGuid();


                    FileName = gid.ToString() + "_" + file.FileName;

                    physicalPath = Path.Combine(Directory.GetCurrentDirectory(), "Uploads", FileName);

                    if (file.Length > 0)
                    {
                        using (var stream = new FileStream(physicalPath, FileMode.Create))
                        {
                            file.CopyTo(stream);
                        }

                    }

                }
                catch (Exception ex)
                {
                    return new { status = appSettings.Value.ErrorMessage, time = DateTime.Now, data = appSettings.Value.FileUploadException + ex.Message };

                }
                var path = "http://referalappapi.sysmedac.com/Uploads/" + FileName;

                var fileDetails = new
                {
                    FileName = FileName,
                    Path = path,
                };

                return new { status = appSettings.Value.SuccessMessage, time = DateTime.Now, fileDetails = fileDetails };


            }
            catch (Exception ex)
            {
                Response.StatusCode = 500;
                return new
                {
                    status = appSettings.Value.ErrorMessage,
                    time = DateTime.Now,
                    data = ex.Message
                };
            }
        }

        [HttpPost]
        [Route("api/loanReferal/Registration/InsertOrUpdateDocuments")]
        public async Task<object> InsertOrUpdateDocuments(List<RefereDocumetReq> request)
        {
            try
            {
                var response = await Task.FromResult(_registrationServices.InsertOrUpdateDocuments(request));
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
    }
}

