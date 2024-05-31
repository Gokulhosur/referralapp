using Microsoft.Extensions.Options;
using ReferalApp.Controllers;
using ReferalApp.Models;
using ReferalApp.Utils;
using System.Diagnostics.Eventing.Reader;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Services
{
    public class RegistrationServices
    {
        LoanReferContext db;
        ILogger<RegistrationController> logger;
        private readonly IOptions<AppConfig> appSettings;
        Utilities _Utils;
        Common cmn;

        public RegistrationServices(LoanReferContext _db, ILogger<RegistrationController> _logger, IOptions<AppConfig> appConfig)
        {
            db = _db;
            logger = _logger;
            appSettings = appConfig;
            _Utils = new Utilities(appConfig);
            cmn = new Common(_db, appConfig);
        }

        public ResponseObj<object> InsertOrUpdateRefererDetails(RefererDetailsReq request)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                if (request.Id == 0)
                {
                    var emailExist = db.RefererDetails.Where(x => x.EmailId == request.EmailId);
                    if (emailExist.Any())
                    {
                        responseObj.responseCode = 400;
                        responseObj.isSuccess = false;
                        responseObj.data = "Email exist";
                        responseObj.message = "Error";
                        return responseObj;
                    }
                    string strpassword = "";

                    if (request.Password != null)
                    {
                        strpassword = cmn.EncryptPassword(request.Password);
                    }

                    var activitylog = db.RefererDetails.OrderBy(t => t.Id).LastOrDefault();

                    var count = "";

                    if (activitylog == null)
                    {
                        int transactNo = 0;
                        transactNo++;
                        count = transactNo.ToString("D4");
                    }
                    else
                    {
                        string numericPart = activitylog.RefererId;

                        if (int.TryParse(numericPart, out int transactNo))
                        {
                            transactNo++;
                            count = transactNo.ToString("D4");
                        }
                    }

                    RefererDetail refererDetail = new RefererDetail();
                    refererDetail.EmailId = request.EmailId;
                    refererDetail.RefererId = count;
                    refererDetail.AccountNumber = request.AccountNumber;
                    refererDetail.AccountHolderName = request.AccountHolderName;
                    refererDetail.FirstName = request.FirstName;
                    refererDetail.LastName = request.LastName;
                    refererDetail.PanNumber = request.PanNumber;
                    refererDetail.DateOfBirth = request.DateOfBirth;
                    refererDetail.IfscCode = request.IfscCode;
                    refererDetail.Password = strpassword;
                    refererDetail.BankName = request.BankName;
                    refererDetail.ProfilePicUrl = request.ProfilePicUrl;
                    refererDetail.MobileNumber = request.MobileNumber;

                    db.RefererDetails.Add(refererDetail);
                    db.SaveChanges();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = refererDetail;
                    responseObj.message = "User registration successful";
                    return responseObj;
                }
                else
                {
                    var exist = db.RefererDetails.Where(x => x.Id == request.Id).FirstOrDefault();
                    if (exist != null)
                    {
                        // exist.EmailId = request.EmailId;
                        // exist.RefererId = request.RefererId;
                        exist.AccountNumber = request.AccountNumber;
                        exist.AccountHolderName = request.AccountHolderName;
                        exist.FirstName = request.FirstName;
                        exist.LastName = request.LastName;
                        exist.PanNumber = request.PanNumber;
                        exist.DateOfBirth = request.DateOfBirth;
                        exist.IfscCode = request.IfscCode;
                        exist.BankName = request.BankName;
                        exist.ProfilePicUrl = request.ProfilePicUrl;
                        exist.MobileNumber = request.MobileNumber;

                        db.RefererDetails.Update(exist);
                        db.SaveChanges();

                        responseObj.responseCode = 200;
                        responseObj.isSuccess = true;
                        responseObj.data = exist;
                        responseObj.message = "User updated successfully";
                        return responseObj;
                    }
                    else
                    {
                        responseObj.responseCode = 400;
                        responseObj.isSuccess = false;
                        responseObj.data = "Refere not found";
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
                return responseObj;
            }
        }

        public ResponseObj<object> FogotPassword(string email, string password)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                var exist = db.RefererDetails.Where(x => x.EmailId == email).FirstOrDefault();
                if (exist != null)
                {
                    string strpassword = cmn.EncryptPassword(password);

                    exist.Password = strpassword;

                    db.RefererDetails.Update(exist);
                    db.SaveChanges();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = exist.Id;
                    responseObj.message = "Password updated successfully";
                    return responseObj;
                }
                else
                {
                    responseObj.responseCode = 400;
                    responseObj.isSuccess = false;
                    responseObj.data = "User not found";
                    responseObj.message = "failed";
                    return responseObj;
                }
            }
            catch (Exception ex)
            {
                responseObj.responseCode = 500;
                responseObj.isSuccess = false;
                responseObj.data = ex.Message;
                responseObj.message = "failed";
                return responseObj;

            }
        }

        public ResponseObj<object> InsertOrUpdateDocuments(List<RefereDocumetReq> request)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                if (request.Count > 0)
                {
                    foreach (var item in request)
                    {
                        if (item.Id == 0)
                        {
                            RefererDocument refererDocument = new RefererDocument();

                            refererDocument.RefererDetailsId = item.RefererDetailsId;
                            refererDocument.DocumentTypeMasterId = item.DocumentTypeMasterId;
                            refererDocument.DocumentUrl = item.DocumentUrl;

                            db.RefererDocuments.Add(refererDocument);
                            db.SaveChanges();
                        }
                        else
                        {
                            var referDocExist = db.RefererDocuments.Where(n => n.Id == item.Id).FirstOrDefault();
                            if (referDocExist != null)
                            {
                                referDocExist.RefererDetailsId = item.RefererDetailsId;
                                referDocExist.DocumentTypeMasterId = item.DocumentTypeMasterId;
                                referDocExist.DocumentUrl = item.DocumentUrl;

                                db.RefererDocuments.Update(referDocExist);
                                db.SaveChanges();
                            }
                        }
                    }
                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = request[0].RefererDetailsId;
                    responseObj.message = "Upload success";
                    return responseObj;
                }
                else
                {
                    responseObj.responseCode = 400;
                    responseObj.isSuccess = false;
                    responseObj.data = "Empty request";
                    responseObj.message = "Error";
                    return responseObj;
                }

            }
            catch (Exception ex)
            {
                responseObj.responseCode = 500;
                responseObj.isSuccess = false;
                responseObj.data = ex.Message;
                return responseObj;
            }
        }

        public ResponseObj<object> Login(string email, string password)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                string strpassword = cmn.EncryptPassword(password);

                var referer = db.RefererDetails.Where(x => x.EmailId == email && x.Password == strpassword).FirstOrDefault();
                if (referer != null)
                {
                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = referer;
                    responseObj.message = "Login Successfull..!";
                    return responseObj;
                }
                else
                {
                    responseObj.responseCode = 400;
                    responseObj.isSuccess = false;
                    responseObj.data = "";
                    responseObj.message = "Login failed..!";
                    return responseObj;
                }
            }
            catch (Exception ex)
            {
                responseObj.responseCode = 500;
                responseObj.isSuccess = false;
                responseObj.data = ex.Message;
                return responseObj;
            }
        }


        public ResponseObj<object> GetReferalDetailsForAdmin(long refererDetailsId, long leadStatusId)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                if (refererDetailsId == 0 && leadStatusId == 0)
                {
                    var res = (from x in db.RefererDetails
                               select new
                               {
                                   x.Id,
                                   x.FirstName,
                                   x.LastName,
                                   x.RefererId,
                                   x.LastUpdatedAt,
                                   leadsShared = db.Leads.Where(n => n.RefererDetailsId == x.Id).Count(),
                               }).ToList();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = res;
                    responseObj.message = "Success";
                    return responseObj;
                }
                else if (refererDetailsId == 0 && leadStatusId > 0)
                {

                    var res = (from x in db.RefererDetails
                               select new
                               {
                                   x.Id,
                                   x.FirstName,
                                   x.LastName,
                                   x.RefererId,
                                   x.LastUpdatedAt,
                                   leadsShared = leadStatusId > 0 ? db.Leads.Where(n => n.RefererDetailsId == x.Id && n.LeadsStatusMasterId == leadStatusId).Count() : db.Leads.Where(n => n.RefererDetailsId == x.Id).Count(),

                               }).ToList();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = res;
                    responseObj.message = "Success";
                    return responseObj;
                }
                responseObj.responseCode = 400;
                responseObj.isSuccess = false;
                responseObj.data = "Not Found";
                responseObj.message = "Error";
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

        public ResponseObj<object> GetReferalDetails(long refererDetailsId)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                var res = (from x in db.RefererDetails
                           where x.Id == refererDetailsId
                           select new
                           {
                               x.Id,
                               x.AccountNumber,
                               x.PanNumber,
                               x.EmailId,
                               x.AccountHolderName,
                               x.FirstName,
                               x.LastName,
                               x.DateOfBirth,
                               x.RefererId,
                               x.BankName,
                               x.ProfilePicUrl,
                               x.IfscCode,
                               documents = (from y in db.RefererDocuments
                                            where y.RefererDetailsId == x.Id
                                            orderby x.Id
                                            select new
                                            {
                                                y.Id,
                                                y.RefererDetailsId,
                                                y.DocumentUrl,
                                                y.DocumentTypeMasterId
                                            }).ToList(),

                           }).ToList();

                responseObj.responseCode = 200;
                responseObj.isSuccess = true;
                responseObj.data = res;
                responseObj.message = "Success";
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
