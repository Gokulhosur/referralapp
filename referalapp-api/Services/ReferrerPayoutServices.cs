using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using ReferalApp.Controllers;
using ReferalApp.Models;
using ReferalApp.Utils;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Services
{
    public class ReferrerPayoutServices
    {
        LoanReferContext db;
        ILogger<ReferrerPayoutController> logger;
        private readonly IOptions<AppConfig> appSettings;
        Utilities _Utils;
        Common cmn;

        public ReferrerPayoutServices(LoanReferContext _db, ILogger<ReferrerPayoutController> _logger, IOptions<AppConfig> appConfig)
        {
            db = _db;
            logger = _logger;
            appSettings = appConfig;
            _Utils = new Utilities(appConfig);
            cmn = new Common(_db, appConfig);
        }

        //Created by PraveenKumar
        //Insert or Update Referrer Payout Details
        public ResponseObj<object> InsertorUpdateReferrerPayoutDetails([FromBody] ReferrerPayoutReq request)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                if (request.id == 0)
                {
                    RefererPayout referrerdet = new RefererPayout();

                    referrerdet.RefererDetailsId = request.referrerDetailId;
                    referrerdet.TotalPayout = request.totalPayout;
                    referrerdet.SanctionedPayout = request.sanctionedPayout;
                    referrerdet.PayoutPercentageMaster = request.payoutPercentageId;
                    referrerdet.BalancePayout = request.balancePayout;

                    db.RefererPayouts.Add(referrerdet);
                    db.SaveChanges();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = appSettings.Value.SuccessMessage;
                    responseObj.message = appSettings.Value.ReferrerPayoutInsertSuccess;
                    return responseObj;

                }

                else if (request.id > 0)
                {

                    var exist = db.RefererPayouts.Where(x => x.Id == request.id).FirstOrDefault();

                    if (exist != null)
                    {
                        exist.RefererDetailsId = request.referrerDetailId;
                        exist.TotalPayout = request.totalPayout;
                        exist.SanctionedPayout = request.sanctionedPayout;
                        exist.PayoutPercentageMaster = request.payoutPercentageId;
                        exist.BalancePayout = request.balancePayout;

                        db.RefererPayouts.Update(exist);
                        db.SaveChanges();
                    }

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = appSettings.Value.SuccessMessage;
                    responseObj.message = appSettings.Value.ReferrerPayoutUpdateSuccess;
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


    }
}
