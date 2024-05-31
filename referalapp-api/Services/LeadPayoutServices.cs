using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using ReferalApp.Controllers;
using ReferalApp.Models;
using ReferalApp.Utils;
using static ReferalApp.Utils.Entity;


namespace ReferalApp.Services
{
    public class LeadPayoutServices
    {
        LoanReferContext db;
        ILogger<LeadPayoutController> logger;
        private readonly IOptions<AppConfig> appSettings;
        Utilities _Utils;
        Common cmn;

        public LeadPayoutServices(LoanReferContext _db, ILogger<LeadPayoutController> _logger, IOptions<AppConfig> appConfig)
        {
            db = _db;
            logger = _logger;
            appSettings = appConfig;
            _Utils = new Utilities(appConfig);
            cmn = new Common(_db, appConfig);
        }


        //Created by PraveenKumar
        //Insert or Update Lead Payout Details
        public ResponseObj<object> InsertorUpdateLeadPayoutDetails([FromBody] LeadPayoutDetails request, long loanTypeId)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                if (request.id == 0)
                {
                    LeadPayout leaddet = new LeadPayout();

                    leaddet.LeadId = request.leadId;
                    leaddet.DisbursedAmount = request.disbursedAmount;
                    leaddet.DisbursedDate = request.disbursedDate;
                    leaddet.InvoiceUrl = request.invoiceUrl;
                    leaddet.SignedInvoiceUrl = request.signedInvoiceUrl;
                    leaddet.Commission = request.commission;
                    leaddet.TransactionDate = request.transactionDate;
                    leaddet.TransactionAmount = request.transactionAmount;
                    leaddet.TransactionRefDocumentUrl = request.transactionRefDocumentUrl;
                    leaddet.LeadStatusMasterId = request.statusId;
                    leaddet.LoanTypeMasterId = loanTypeId;
                    leaddet.InsertedBy = request.userId;
                    leaddet.InsertedDate = DateTime.Now;

                    db.LeadPayouts.Add(leaddet);
                    db.SaveChanges();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = appSettings.Value.SuccessMessage;
                    responseObj.message = appSettings.Value.LeadPayoutInsertSuccess;
                    return responseObj;

                }

                else if (request.id > 0)
                {

                    var exist = db.LeadPayouts.Where(x => x.Id == request.id).FirstOrDefault();

                    if (exist != null)
                    {
                        exist.LeadId = request.leadId;
                        exist.DisbursedAmount = request.disbursedAmount;
                        exist.DisbursedDate = request.disbursedDate;
                        exist.InvoiceUrl = request.invoiceUrl;
                        exist.SignedInvoiceUrl = request.signedInvoiceUrl;
                        exist.Commission = request.commission;
                        exist.TransactionDate = request.transactionDate;
                        exist.TransactionAmount = request.transactionAmount;
                        exist.TransactionRefDocumentUrl = request.transactionRefDocumentUrl;
                        exist.LeadStatusMasterId = request.statusId;
                        exist.LoanTypeMasterId = loanTypeId;
                        exist.LastUpdatedBy = request.userId;
                        exist.LastUpdatedDate = DateTime.Now;

                        db.LeadPayouts.Update(exist);
                        db.SaveChanges();
                    }

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = appSettings.Value.SuccessMessage;
                    responseObj.message = appSettings.Value.LeadPayoutUpdateSuccess;
                    return responseObj;
                }

                else
                {

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = appSettings.Value.SuccessMessage;
                    responseObj.message = appSettings.Value.LeadIdInvalid;
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

        //Created by PraveenKumar on 02/04/2024
        //Get Lead Payout Details By Lead Id
        public ResponseObj<object> GetLeadPayoutDetailsByLeadId(long leadId)
        {
            var responseObj = new ResponseObj<object>();
            try
            {

                var leadPayoutDetails = (from a in db.LeadPayouts
                                         join b in db.LeadsStatusMasters on a.LeadStatusMasterId equals b.Id
                                         where a.LeadId == leadId
                                         select new
                                         {
                                             a.Id,
                                             a.DisbursedAmount,
                                             a.Commission,
                                             a.TransactionDate,

                                         }).ToList();


                responseObj.responseCode = 200;
                responseObj.isSuccess = true;
                responseObj.data = leadPayoutDetails;
                responseObj.message = appSettings.Value.SuccessMessage;
                return responseObj;

            }
            catch (Exception ex)
            {
                responseObj.responseCode = 500;
                responseObj.isSuccess = false;
                responseObj.data = ex.Message;
                responseObj.message = appSettings.Value.ErrorMessage;
                return responseObj;
            }

        }

    }
}
