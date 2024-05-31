using Microsoft.Extensions.Options;
using ReferalApp.Controllers;
using ReferalApp.Models;
using ReferalApp.Utils;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Services
{
    public class AdminServices
    {
        LoanReferContext db;
        ILogger<AdminController> logger;
        private readonly IOptions<AppConfig> appSettings;
        Utilities _Utils;
        Common cmn;

        public AdminServices(LoanReferContext _db, ILogger<AdminController> _logger, IOptions<AppConfig> appConfig)
        {
            db = _db;
            logger = _logger;
            appSettings = appConfig;
            _Utils = new Utilities(appConfig);
        }
        public ResponseObj<object> AdminLogin(string userName, string password)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                 
                var admin = db.EmployeeDetails.Where(x => x.UserName == userName && x.Password == password).FirstOrDefault();
                if(admin != null)
                {
                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = admin;
                    responseObj.message = "Login successfully..!";
                    return responseObj;

                }
                else
                {
                    responseObj.responseCode = 400;
                    responseObj.isSuccess = false;
                    responseObj.data = "Login failed..!";
                    responseObj.message = "Error";
                    return responseObj;

                }
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

        public ResponseObj<object> InsertOrUpdateEmployee(EmployeeReq request)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                if (request.Id == 0)
                {
                    var empExist = db.EmployeeDetails.Where(x => x.EmployeeNumber == request.EmployeeNumber);
                    if (empExist.Any())
                    {
                        responseObj.responseCode = 400;
                        responseObj.isSuccess = false;
                        responseObj.data = "Employee number exist";
                        responseObj.message = "Error";
                        return responseObj;
                    }

                    var empNameExist = db.EmployeeDetails.Where(x => x.EmployeeName == request.EmployeeName);
                    if (empNameExist.Any())
                    {
                        responseObj.responseCode = 400;
                        responseObj.isSuccess = false;
                        responseObj.data = "Employee Name exist";
                        responseObj.message = "Error";
                        return responseObj;
                    }

                    string password = cmn.GenerateRandomString(8);
                    string strpassword = cmn.EncryptPassword(password);

                    EmployeeDetail emp = new EmployeeDetail();

                    emp.DesignationMasterId = request.DesignationMasterId;
                    emp.EmployeeNumber = request.EmployeeNumber;
                    emp.EmployeeName = request.EmployeeName;
                    emp.UserName = request.EmployeeName;
                    emp.Status = request.Status;
                    emp.Password = strpassword;
                    emp.LastUpdatedAt = DateTime.Now;

                    db.EmployeeDetails.Add(emp);
                    db.SaveChanges();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = emp;
                    responseObj.message = "Employee added successfully..!";
                    return responseObj;

                }
                else
                {

                    var exist = db.EmployeeDetails.Where(x => x.Id == request.Id).FirstOrDefault();
                    if (exist != null)
                    {
                        exist.DesignationMasterId = request.DesignationMasterId;
                        exist.Status = request.Status;
                        exist.LastUpdatedAt = DateTime.Now;

                        db.EmployeeDetails.Update(exist);
                        db.SaveChanges();

                        responseObj.responseCode = 200;
                        responseObj.isSuccess = true;
                        responseObj.data = exist;
                        responseObj.message = "Updated successfully..!";
                        return responseObj;
                    }
                    else
                    {
                        responseObj.responseCode = 400;
                        responseObj.isSuccess = false;
                        responseObj.data = "User not found..!";
                        responseObj.message = "Error";
                        return responseObj;
                    }

                }

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

        public ResponseObj<object> GetAllEmployees(long empId)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                if(empId == 0)
                {
                    var res = (from x in db.EmployeeDetails
                               select new
                               {
                                   x.EmployeeName,
                                   x.Id,
                                   x.EmployeeNumber,
                                   x.Status,
                                   x.LastUpdatedAt,
                                   x.DesignationMasterId,
                                   designation = db.DesignationMasters.Where(n => n.Id == x.DesignationMasterId).Select(t => t.Designation).FirstOrDefault(),

                               }).ToList();

                        responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = res;
                    responseObj.message = "Success";
                    return responseObj;
                }
                else
                {
                    var res = (from x in db.EmployeeDetails
                               where x.Id == empId
                               select new
                               {
                                   x.EmployeeName,
                                   x.Id,
                                   x.EmployeeNumber,
                                   x.Status,
                                   x.LastUpdatedAt,
                                   x.DesignationMasterId,
                                   designation = db.DesignationMasters.Where(n => n.Id == x.DesignationMasterId).Select(t => t.Designation).FirstOrDefault(),
                               }).ToList();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = res;
                    responseObj.message = "Success";
                    return responseObj;
                }
                 
                   
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
