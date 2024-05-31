using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using ReferalApp.Controllers;
using ReferalApp.Models;
using ReferalApp.Utils;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Services
{
    public class ProductsService
    {

        LoanReferContext db;
        ILogger<ProductsController> logger;
        private readonly IOptions<AppConfig> appSettings;
        Utilities _Utils;

        public ProductsService(LoanReferContext _db, ILogger<ProductsController> _logger, IOptions<AppConfig> appConfig)
        {
            db = _db;
            logger = _logger;
            appSettings = appConfig;
            _Utils = new Utilities(appConfig);
        }


        //Created by PraveenKumar
        //Insert or Update Product Details
        public ResponseObj<object> InsertorUpdateProductDetails([FromBody] Productdetails request)
        {
            var responseObj = new ResponseObj<object>();
            try
            {

                if (request.id == 0)
                {
                    LoanCommissionMaster loandet = new LoanCommissionMaster();

                    loandet.LoanTypeMasterId = request.loanTypeId;
                    loandet.Amount = request.amount;
                    loandet.Commission = request.commission;
                    loandet.CommissionType = request.commissionType;
                    loandet.Status = request.status;
                    loandet.InsertedBy = request.userId;
                    loandet.InsertedDate = DateTime.Now;

                    db.LoanCommissionMasters.Add(loandet);
                    db.SaveChanges();

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = appSettings.Value.SuccessMessage;
                    responseObj.message = appSettings.Value.ProductInsertSuccess;
                    return responseObj;

                }

                else if (request.id > 0)
                {

                    var exist = db.LoanCommissionMasters.Where(x => x.Id == request.id).FirstOrDefault();

                    if (exist != null)
                    {
                        exist.LoanTypeMasterId = request.loanTypeId;
                        exist.Amount = request.amount;
                        exist.Commission = request.commission;
                        exist.CommissionType = request.commissionType;
                        exist.Status = request.status;
                        exist.LastUpdatedBy = request.userId;
                        exist.LastUpdatedDate = DateTime.Now;

                        db.LoanCommissionMasters.Update(exist);
                        db.SaveChanges();
                    }

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = appSettings.Value.SuccessMessage;
                    responseObj.message = appSettings.Value.ProductUpdateSuccess;
                    return responseObj;
                }

                else
                {

                    responseObj.responseCode = 200;
                    responseObj.isSuccess = true;
                    responseObj.data = appSettings.Value.SuccessMessage;
                    responseObj.message = appSettings.Value.ProductIdInvalid;
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

        //Created by PraveenKumar
        //Edit Product Details By Product Id
        public ResponseObj<object> EditProductDetailsById(long productId)
        {
            var responseObj = new ResponseObj<object>();
            try
            {

                var productDetails = (from a in db.LoanCommissionMasters
                                      where a.Id == productId
                                      select new
                                      {
                                          a.Id,
                                          a.LoanTypeMasterId,
                                          a.Amount,
                                          a.Commission,
                                          a.CommissionType,
                                          a.Status

                                      }).ToList();


                responseObj.responseCode = 200;
                responseObj.isSuccess = true;
                responseObj.data = productDetails;
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

        //Created by PraveenKumar on 02/04/2024
        //Get Product Details For Grid Bind
        public ResponseObj<object> GetProductDetailsGridBind()
        {
            var responseObj = new ResponseObj<object>();
            try
            {

                var productDetails = (from a in db.LoanCommissionMasters
                                   
                                      select new
                                      {
                                          a.Id,
                                          LoanTypeMasterId = db.LoanTypeMasters.Where(x => x.Id == a.LoanTypeMasterId).Select(c => c.LoanType).FirstOrDefault(),
                                          a.Amount,
                                          a.Commission,
                                          a.CommissionType,
                                          a.Status

                                      }).ToList();


                responseObj.responseCode = 200;
                responseObj.isSuccess = true;
                responseObj.data = productDetails;
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
