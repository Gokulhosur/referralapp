using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using ReferalApp.Models;
using ReferalApp.Services;
using ReferalApp.Utils;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Controllers
{
    [ApiController]
    public class LeadsController : ControllerBase
    {
        LoanReferContext db;
        LeadsServices _leadsServices;
        public LeadsController(LoanReferContext _db)
        {
            db = _db;
            _leadsServices = new LeadsServices(_db);
        }

        [HttpPost]
        [Route("api/loanReferal/Leads/InsrtOrUpdateLeadsServices")]
        public async Task<object> InsrtOrUpdateLeadsServices(LeadsDetailsReq request)
        {
            try
            {
                var response = await Task.FromResult(_leadsServices.InsertOrUpdateLeadsDetails(request));

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
        [Route("api/loanReferal/Leads/LeadsDetailsByrefereId")]
        public async Task<object> LeadsDetailsByrefereId(long leadsRefererId, long LeadsStatusMasterId)
        {
            try
            {
                var response = await Task.FromResult(_leadsServices.GetLeadsByRefererId(leadsRefererId, LeadsStatusMasterId));
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
        [Route("api/loanReferal/Leads/LeadsCountByStatus")]
        public async Task<object> LeadsCountByStatus(long refereId)
        {
            try
            {
                var response = await Task.FromResult(_leadsServices.GetAllLeadsCountByStatus(refereId));
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
        [Route("api/loanReferal/Leads/LeadsDetailsByLeadsId")]
        public async Task<object> LeadsDetailsByLeadsId(long LeadsId, long? LeadsStatusId)
        {
            try
            {
                var response = await Task.FromResult(_leadsServices.GetLeadsByLeadId(LeadsId, LeadsStatusId));
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
        [Route("api/loanReferal/Leads/GetAllMasterDetails")]
        public async Task<object> GetAllMasterDetails()
        {
            try
            {
                var response = await Task.FromResult(_leadsServices.GetMasterDetails());
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


        //Created by NiyasAhmed on 01/04/2024
        //Get Asign To Referrer Page Grid Bind
        [HttpGet]
        [Route("api/loanReferal/Leads/GetAllReferrerDetails")]
        public async Task<object> GetAllReferrerDetails()
        {
            try
            {
                var response = await Task.FromResult(_leadsServices.GetAllReferrerDetails());
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

        //Created by NiyasAhmed on 01/04/2024
        //Get Person To Referrer Page Grid Bind
        [HttpGet]
        [Route("api/loanReferal/Leads/GetAllPersonalGridBind")]
        public async Task<object> GetAllPersonalGridBind(long personId)
        {
            try
            {
                var response = await Task.FromResult(_leadsServices.GetAllPersonalGridBind(personId));
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

        [HttpPost]
        [Route("api/loanReferal/Leads/UpdatePersonStatus")]
        public async Task<object> UpdatePersonStatus(long personId, string? status, string? noteDetails)
        {
            try
            {
                var response = await Task.FromResult(_leadsServices.UpdatePersonStatus(personId, status, noteDetails));
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
