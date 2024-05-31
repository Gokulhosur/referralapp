using ReferalApp.Models;
using ReferalApp.Utils;
using static System.Runtime.InteropServices.JavaScript.JSType;
using System;
using System.Diagnostics;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Services
{
    public class LeadsServices
    {
        LoanReferContext db;
        public LeadsServices(LoanReferContext _db)
        {
            db = _db;
        }

        public ResponseObj<object> InsertOrUpdateLeadsDetails(LeadsDetailsReq request)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                if (request.Id == 0)
                {

                    var emailExist = db.Leads.Where(x => x.EmailId == request.EmailId);

                    if (emailExist.Any())
                    {
                        responseObj.responseCode = 400;
                        responseObj.isSuccess = false;
                        responseObj.data = "Email exist";
                        responseObj.message = "Error";
                        return responseObj;
                    }

                    //Modified By Praveen Kumar 

                    #region Lead Number Generation

                    long counter;
                    string FourDigitsString = "";
                    var formattedNumber = "";
                    var leadNumberCheck = db.Leads.OrderByDescending(x => x.Id).FirstOrDefault();

                    if (leadNumberCheck.LeadNumber == null)
                    {
                        counter = 00000;
                        counter++;
                        formattedNumber = counter.ToString("D5");
                    }
                    else
                    {

                        counter = Convert.ToInt64(leadNumberCheck.LeadNumber);
                        counter++;
                        formattedNumber = counter.ToString("D5");

                    }

                    #endregion

                    Lead lead = new Lead();

                    lead.RefererDetailsId = request.RefererDetailsId;
                    lead.ApplicantLastName = request.ApplicantLastName;
                    lead.ApplicantFirstName = request.ApplicantFirstName;
                    lead.Address = request.Address;
                    lead.StateName = request.StateName;
                    lead.PanNumber = request.PanNumber;
                    lead.AnnualIncome = request.AnnualIncome;
                    lead.OrganizationName = request.OrganizationName;
                    lead.CityCode = request.CityCode;
                    lead.CityName = request.CityName;
                    lead.CountryCode = request.CountryCode;
                    lead.CountryName = request.CountryName;
                    lead.StateCode = request.StateCode;
                    lead.DateOfBirth = request.DateOfBirth;
                    lead.ExpectedLoanAmount = request.ExpectedLoanAmount;
                    lead.Gender = request.Gender;
                    lead.MobileNumber = request.MobileNumber;
                    lead.ResidentialType = request.ResidentialType;
                    lead.EmailId = request.EmailId;
                    lead.Pincode = request.Pincode;
                    lead.LoanPurpose = request.LoanPurpose;
                    lead.LoanTypeMasterId = request.LoanTypeMasterId;
                    lead.OrganizationType = request.OrganizationType;
                    lead.MaritalStatus = request.MaritalStatus;
                    lead.LeadsStatusMasterId = request.LeadsStatusMasterId;
                    lead.LeadNumber = formattedNumber;
                    lead.LeadCreatedDate = DateTime.Now;
                    lead.LastUpdatedBy = request.LastUpdatedBy;
                    lead.LastUpdatedDate = DateTime.Now;

                    db.Leads.Add(lead);
                    db.SaveChanges();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = lead.Id;
                    responseObj.message = "User registration successful";
                    return responseObj;

                }
                else
                {

                    var exist = db.Leads.Where(x => x.Id == request.Id).FirstOrDefault();
                    if (exist != null)
                    {
                        exist.RefererDetailsId = request.RefererDetailsId;
                        exist.ApplicantLastName = request.ApplicantLastName;
                        exist.ApplicantFirstName = request.ApplicantFirstName;
                        exist.Address = request.Address;
                        exist.StateName = request.StateName;
                        exist.PanNumber = request.PanNumber;
                        exist.AnnualIncome = request.AnnualIncome;
                        exist.OrganizationName = request.OrganizationName;
                        exist.CityCode = request.CityCode;
                        exist.CityName = request.CityName;
                        exist.CountryCode = request.CountryCode;
                        exist.CountryName = request.CountryName;
                        exist.StateCode = request.StateCode;
                        exist.DateOfBirth = request.DateOfBirth;
                        exist.ExpectedLoanAmount = request.ExpectedLoanAmount;
                        exist.Gender = request.Gender;
                        exist.LoanPurpose = request.LoanPurpose;
                        exist.MobileNumber = request.MobileNumber;
                        exist.ResidentialType = request.ResidentialType;
                        exist.EmailId = request.EmailId;
                        exist.Pincode = request.Pincode;
                        exist.LoanTypeMasterId = request.LoanTypeMasterId;
                        exist.OrganizationType = request.OrganizationType;
                        exist.MaritalStatus = request.MaritalStatus;
                        exist.LastUpdatedBy = request.LastUpdatedBy;
                        exist.LastUpdatedDate = DateTime.Now;
                        exist.LeadsStatusMasterId = request.LeadsStatusMasterId;

                        db.Leads.Update(exist);
                        db.SaveChanges();

                        responseObj.responseCode = 200;
                        responseObj.isSuccess = true;
                        responseObj.data = exist.Id;
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

        public ResponseObj<object> GetLeadsByLeadId(long LeadsId, long? LeadsStatusId)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                if (LeadsId == 0)
                {
                    if (LeadsStatusId == 0)
                    {
                        var res = (from x in db.Leads
                                   select new
                                   {
                                       x.Id,
                                       x.RefererDetailsId,
                                       x.ApplicantLastName,
                                       x.ApplicantFirstName,
                                       x.Address,
                                       x.PanNumber,
                                       x.AnnualIncome,
                                       x.OrganizationName,
                                       x.CityCode,
                                       x.CityName,
                                       x.StateName,
                                       x.CountryCode,
                                       x.CountryName,
                                       x.StateCode,
                                       x.DateOfBirth,
                                       x.ExpectedLoanAmount,
                                       x.Gender,
                                       x.LoanPurpose,
                                       x.LoanTypeMasterId,
                                       loanType = db.LoanTypeMasters.Where(c => c.Id == x.LoanTypeMasterId).Select(o => o.LoanType).FirstOrDefault(),
                                       x.OrganizationType,
                                       x.MaritalStatus,
                                       x.LeadsStatusMasterId,
                                       leadStatus = db.LeadsStatusMasters.Where(v => v.Id == x.LeadsStatusMasterId).Select(o => o.StatusType).FirstOrDefault(),
                                       x.LastUpdatedBy,
                                       x.LastUpdatedDate,
                                       x.MobileNumber,
                                       refereDet = (from y in db.RefererDetails
                                                    where y.Id == x.RefererDetailsId
                                                    select new
                                                    {
                                                        y.FirstName,
                                                        y.LastName,
                                                        y.RefererId
                                                    }).FirstOrDefault(),
                                   }).ToList();

                        responseObj.responseCode = 200;
                        responseObj.isSuccess = true;
                        responseObj.data = res;
                        responseObj.message = "Success";
                        return responseObj;
                    }
                    else
                    {
                        var res = (from x in db.Leads
                                   where x.LeadsStatusMasterId == LeadsStatusId
                                   select new
                                   {
                                       x.Id,
                                       x.RefererDetailsId,
                                       x.ApplicantLastName,
                                       x.ApplicantFirstName,
                                       x.Address,
                                       x.PanNumber,
                                       x.AnnualIncome,
                                       x.OrganizationName,
                                       x.CityCode,
                                       x.CityName,
                                       x.StateName,
                                       x.CountryCode,
                                       x.CountryName,
                                       x.StateCode,
                                       x.DateOfBirth,
                                       x.ExpectedLoanAmount,
                                       x.Gender,
                                       x.LoanPurpose,
                                       x.LoanTypeMasterId,
                                       loanType = db.LoanTypeMasters.Where(c => c.Id == x.LoanTypeMasterId).Select(o => o.LoanType).FirstOrDefault(),
                                       x.OrganizationType,
                                       x.MaritalStatus,
                                       x.LeadsStatusMasterId,
                                       leadStatus = db.LeadsStatusMasters.Where(v => v.Id == x.LeadsStatusMasterId).Select(o => o.StatusType).FirstOrDefault(),
                                       x.LastUpdatedBy,
                                       x.LastUpdatedDate,
                                       refereDet = (from y in db.RefererDetails
                                                    where y.Id == x.RefererDetailsId
                                                    select new
                                                    {
                                                        y.FirstName,
                                                        y.LastName,
                                                        y.RefererId
                                                    }).FirstOrDefault(),
                                   }).ToList();

                        responseObj.responseCode = 200;
                        responseObj.isSuccess = true;
                        responseObj.data = res;
                        responseObj.message = "Success";
                        return responseObj;
                    }

                }
                else
                {
                    var res = (from x in db.Leads
                               join y in db.LeadAssignments on x.Id equals y.LeadId
                               join z in db.EmployeeDetails on y.AssignedTo equals z.Id
                               where x.Id == LeadsId
                               select new
                               {

                                   x.RefererDetailsId,
                                   x.MobileNumber,
                                   x.ResidentialType,
                                   x.EmailId,
                                   x.ApplicantLastName,
                                   x.ApplicantFirstName,
                                   x.Address,
                                   x.PanNumber,
                                   AssignedTo = z.EmployeeName,
                                   x.AnnualIncome,
                                   x.OrganizationName,
                                   x.CityCode,
                                   x.CityName,
                                   x.StateName,
                                   x.CountryCode,
                                   x.CountryName,
                                   x.StateCode,
                                   x.Pincode,
                                   x.DateOfBirth,
                                   x.ExpectedLoanAmount,
                                   x.Gender,
                                   x.LoanPurpose,
                                   x.LoanTypeMasterId,
                                   loanType = db.LoanTypeMasters.Where(c => c.Id == x.LoanTypeMasterId).Select(o => o.LoanType).FirstOrDefault(),
                                   x.OrganizationType,
                                   x.MaritalStatus,
                                   x.LeadsStatusMasterId,
                                   leadStatus = db.LeadsStatusMasters.Where(v => v.Id == x.LeadsStatusMasterId).Select(o => o.StatusType).FirstOrDefault(),
                                   x.LastUpdatedBy,
                                   x.LastUpdatedDate,
                                   refereDet = (from y in db.RefererDetails
                                                where y.Id == x.RefererDetailsId
                                                select new
                                                {
                                                    y.FirstName,
                                                    y.LastName,
                                                    y.RefererId,
                                                    y.MobileNumber
                                                }).FirstOrDefault(),
                               }).FirstOrDefault();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = res;
                    responseObj.message = "Success";
                    return responseObj;



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


        public ResponseObj<object> GetLeadsByRefererId(long refererDetailsId, long LeadsStatusMasterId)
        {
            var responseObj = new ResponseObj<object>();
            try
            {

                if (LeadsStatusMasterId == 0)
                {
                    var res = (from x in db.Leads
                               where x.RefererDetailsId == refererDetailsId
                               select new
                               {
                                   x.RefererDetailsId,
                                   x.ApplicantFirstName,
                                   x.ApplicantLastName,
                                   x.LeadsStatusMasterId,
                                   leadsStatus = db.LeadsStatusMasters.Where(n => n.Id == x.LeadsStatusMasterId).Select(c => c.StatusType).FirstOrDefault(),
                                   x.ExpectedLoanAmount,
                                   x.LastUpdatedBy,
                                   x.LastUpdatedDate,
                                   x.AnnualIncome,
                                   x.MobileNumber
                               }).ToList();



                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = res;
                    responseObj.message = "Success";
                    return responseObj;
                }
                else
                {
                    var res = (from x in db.Leads
                               where x.RefererDetailsId == refererDetailsId && x.LeadsStatusMasterId == LeadsStatusMasterId
                               select new
                               {
                                   x.RefererDetailsId,
                                   x.ApplicantFirstName,
                                   x.ApplicantLastName,
                                   x.LeadsStatusMasterId,
                                   leadsStatus = db.LeadsStatusMasters.Where(n => n.Id == x.LeadsStatusMasterId).Select(c => c.StatusType).FirstOrDefault(),
                                   x.ExpectedLoanAmount,
                                   x.LastUpdatedBy,
                                   x.LastUpdatedDate,
                                   x.AnnualIncome
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

        public ResponseObj<object> GetMasterDetails()
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                var docType = (from x in db.DocumentTypeMasters
                               where x.Status == "Active"
                               select new
                               {
                                   x.DocumentType,
                                   x.Id,
                                   x.Status
                               }).ToList();


                var loanType = (from x in db.LoanTypeMasters
                                where x.Status == "Active"
                                select new
                                {
                                    x.Id,
                                    x.Status,
                                    x.LoanType
                                }).ToList();

                var leadsStatus = (from x in db.LeadsStatusMasters
                                   where x.Status == "Active"
                                   select new
                                   {
                                       x.Id,
                                       x.Status,
                                       x.StatusType
                                   }).ToList();

                var designation = (from x in db.DesignationMasters
                                   where x.Status == "Active"
                                   select new
                                   {
                                       x.Id,
                                       x.Status,
                                       x.Designation
                                   }).ToList();


                responseObj.responseCode = 200;
                responseObj.isSuccess = true;
                responseObj.data = new
                {
                    DocType = docType,
                    LoanType = loanType,
                    LeadsStatus = leadsStatus,
                    designationStatus = designation
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

        public ResponseObj<object> GetAllLeadsCountByStatus(long refereId)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                if (refereId == 0)
                {
                    var responce1 = db.Leads.Count();
                    var responce2 = db.Leads.Where(x => x.LeadsStatusMasterId == 1).Count();
                    var responce3 = db.Leads.Where(x => x.LeadsStatusMasterId == 2).Count();
                    var responce4 = db.Leads.Where(x => x.LeadsStatusMasterId == 3).Count();
                    var responce5 = db.Leads.Where(x => x.LeadsStatusMasterId == 4).Count();
                    var responce6 = db.Leads.Where(x => x.LeadsStatusMasterId == 5).Count();
                    var responce7 = db.Leads.Where(x => x.LeadsStatusMasterId == 6).Count();
                    var responce8 = db.Leads.Where(x => x.LeadsStatusMasterId == 7).Count();
                    var responce9 = db.Leads.Where(x => x.LeadsStatusMasterId == 8).Count();


                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = new
                    {
                        TotalCount = responce1,
                        Submitted = responce2,
                        NotSubmitted = responce3,
                        InProcess = responce4,
                        Approved = responce5,
                        Sanctioned = responce6,
                        Disbursed = responce7,
                        ReadyForPayout = responce8,
                        payout = responce9

                    };
                    responseObj.message = "Success";
                    return responseObj;
                }
                else
                {
                    var responce1 = db.Leads.Where(x => x.RefererDetailsId == refereId).Count();
                    var responce2 = db.Leads.Where(x => x.LeadsStatusMasterId == 1 && x.RefererDetailsId == refereId).Count();
                    var responce3 = db.Leads.Where(x => x.LeadsStatusMasterId == 2 && x.RefererDetailsId == refereId).Count();
                    var responce4 = db.Leads.Where(x => x.LeadsStatusMasterId == 3 && x.RefererDetailsId == refereId).Count();
                    var responce5 = db.Leads.Where(x => x.LeadsStatusMasterId == 4 && x.RefererDetailsId == refereId).Count();
                    var responce6 = db.Leads.Where(x => x.LeadsStatusMasterId == 5 && x.RefererDetailsId == refereId).Count();
                    var responce7 = db.Leads.Where(x => x.LeadsStatusMasterId == 6 && x.RefererDetailsId == refereId).Count();
                    var responce8 = db.Leads.Where(x => x.LeadsStatusMasterId == 7 && x.RefererDetailsId == refereId).Count();
                    var responce9 = db.Leads.Where(x => x.LeadsStatusMasterId == 8 && x.RefererDetailsId == refereId).Count();


                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = new
                    {
                        TotalCount = responce1,
                        Submitted = responce2,
                        NotSubmitted = responce3,
                        InProcess = responce4,
                        Approved = responce5,
                        Sanctioned = responce6,
                        Disbursed = responce7,
                        ReadyForPayout = responce8,
                        payout = responce9
                    };
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

        //Created by NiyasAhmed on 01/04/2024
        //Get Asign To Referrer Page Grid Bind
        public ResponseObj<object> GetAllReferrerDetails()
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                var refereral = (from x in db.RefererDetails
                                 select new
                                 {
                                     x.RefererId,
                                     x.Id,
                                     x.SignupDate,
                                     x.FirstName,
                                     x.Status,
                                     noLeadGenerated = db.Leads.Where(c => c.RefererDetailsId == x.Id).Count(),

                                 }).ToList();

                responseObj.responseCode = 200;
                responseObj.isSuccess = true;
                responseObj.data = new
                {
                    refereral = refereral
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

        //Created by NiyasAhmed on 01/04/2024
        //Get Asign To Referrer Page Grid Bind
        public ResponseObj<object> GetAllPersonalGridBind(long personId)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                var personDetails = (from x in db.RefererDetails
                                     where x.Id == personId
                                     select new
                                     {
                                         x.FirstName,
                                         x.LastName,
                                         x.MobileNumber,
                                         x.EmailId,
                                         x.DateOfBirth,
                                         x.PanNumber,
                                         x.IfscCode,
                                         x.BankName,
                                         x.AccountNumber,
                                         x.AccountHolderName,
                                         x.ProfilePicUrl,
                                         x.Status,
                                         x.NoteDetails,
                                         DocumentTypes = (from a in db.RefererDocuments
                                                          join y in db.DocumentTypeMasters on a.DocumentTypeMasterId equals y.Id
                                                          where a.RefererDetailsId == x.Id
                                                          select new
                                                          {
                                                              a.DocumentUrl,
                                                              y.DocumentType,
                                                          }).ToList(),
                                         LeadDetails = (from y in db.Leads
                                                        where y.RefererDetailsId == x.Id
                                                        select new
                                                        {
                                                            y.Id,
                                                            y.Address,
                                                            y.CountryName,
                                                            y.StateName,
                                                            y.CityName,
                                                            y.Pincode,
                                                            Product = db.LoanTypeMasters.Where(z => z.Id == y.LoanTypeMasterId).Select(s => s.LoanType).FirstOrDefault(),
                                                            Status = db.LeadsStatusMasters.Where(a => a.Id == y.LeadsStatusMasterId).Select(s => s.StatusType).FirstOrDefault(),
                                                            DisbursedAmount = db.LeadPayouts.Where(z => z.LeadId == y.Id).Select(s => s.DisbursedAmount).ToList(),
                                                            TransactionAmount = db.LeadPayouts.Where(z => z.LeadId == y.Id).Select(s => s.TransactionAmount).ToList(),
                                                            Commission = db.LeadPayouts.Where(z => z.LeadId == y.Id).Select(s => s.Commission).ToList(),
                                                        }).AsEnumerable() // Switch to LINQ to Objects
                         .Select(lead => new
                         {
                             lead.Id,
                             lead.Address,
                             lead.CountryName,
                             lead.StateName,
                             lead.CityName,
                             lead.Pincode,
                             lead.Product,
                             lead.Status,
                             DisbursedAmount = lead.DisbursedAmount.Sum(),
                             TransactionAmount = lead.TransactionAmount.Sum(),
                             Commission = lead.Commission.Sum(),
                         }).FirstOrDefault(),

                                     }).ToList();

                responseObj.responseCode = 200;
                responseObj.isSuccess = true;
                responseObj.data = new
                {
                    personDetails = personDetails
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

        //Created by NiyasAhmed on 01/04/2024
        //Get Asign To Referrer Page Grid Bind
        public ResponseObj<object> UpdatePersonStatus(long personId, string? status, string? noteDetails)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                var exist = db.RefererDetails.Where(x => x.Id == personId).FirstOrDefault();
                if (exist != null)
                {
                    exist.LastUpdatedAt = DateTime.Now;
                    exist.Status = status;
                    exist.NoteDetails = noteDetails;

                    db.RefererDetails.Update(exist);
                    db.SaveChanges();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = exist.Id;
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
