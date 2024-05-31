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
    public class ProductsController : ControllerBase
    {

        private readonly IOptions<AppConfig> appSettings;
        LoanReferContext db;
        ProductsService _productService;
        IWebHostEnvironment env;
        private IConfiguration _config;
        private readonly ILogger<ProductsController> _logger;
        Common cmn;

        public ProductsController(IOptions<AppConfig> appConfig, LoanReferContext dbContext, IWebHostEnvironment env, IConfiguration config, ILogger<ProductsController> logger)
        {
            appSettings = appConfig;
            db = dbContext;
            _productService = new ProductsService(dbContext, logger, appSettings);
            this.env = env;
            _config = config;
            _logger = logger;
            cmn = new Common(dbContext, appConfig);
        }


        //Created by PraveenKumar
        //Insert or Update Product Details

        [HttpPost]
        [Route("api/loanReferal/Product/InsertorUpdateProductDetails")]
        public async Task<object> InsertorUpdateProductDetails([FromBody] Productdetails request)
        {
            try
            {
                //Converting JSON Body into a String
                //cmn.LogToFile("API Name : api/loanReferal/Product/InsertorUpdateProductDetails | " + "Request Data : " + request);

                var response = await Task.FromResult(_productService.InsertorUpdateProductDetails(request));

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
                //cmn.LogToFile("API Name : api/loanReferal/Product/InsertorUpdateProductDetails | " + "Message : " + ex.Message);

                return new
                {
                    status = appSettings.Value.ErrorMessage,
                    time = DateTime.Now,
                    data = ex.Message,
                    data2 = ex.StackTrace
                };
            }
        }

        //Created by PraveenKumar
        //Edit Product Details By Product Id

        [HttpGet]
        [Route("api/loanReferal/Product/EditProductDetailsById")]
        public async Task<object> GetLeadPayoutDetailsByLeadId(long productId)
        {
            try
            {
                //cmn.LogToFile("API Name : api/loanReferal/Product/EditProductDetailsById | " + "Product Id : " + productId);


                var response = await Task.FromResult(_productService.EditProductDetailsById(productId));

                if (response.isSuccess == true)
                {
                    //cmn.LogToFile("API Name : api/loanReferal/Product/EditProductDetailsById | " + "Message : Success");

                    return new
                    {
                        status = appSettings.Value.SuccessMessage,
                        statusCode = response.responseCode,
                        message = response.message,
                        time = DateTime.Now,
                        data = response.data,
                    };
                }
                else
                {
                    //cmn.LogToFile("API Name : api/loanReferal/Product/EditProductDetailsById | " + "Message : Error");

                    return new
                    {
                        status = appSettings.Value.ErrorMessage,
                        statusCode = response.responseCode,
                        message = response.message,
                        time = DateTime.Now,
                        data = response.data,
                    };
                }
            }
            catch (Exception ex)
            {
                //cmn.LogToFile("API Name : api/loanReferal/Product/EditProductDetailsById | " + "Message : " + ex.Message);

                return new
                {
                    status = appSettings.Value.ErrorMessage,
                    time = DateTime.Now,
                    data = ex.Message,
                    data2 = ex.StackTrace
                };
            }
        }

        //Created by PraveenKumar
        //Get Product Details For Grid Bind

        [HttpGet]
        [Route("api/loanReferal/Product/GetProductDetailsGridBind")]
        public async Task<object> GetProductDetailsGridBind()
        {
            try
            {
                //cmn.LogToFile("API Name : api/loanReferal/Product/EditProductDetailsById | " + "Product Id : " + productId);


                var response = await Task.FromResult(_productService.GetProductDetailsGridBind());

                if (response.isSuccess == true)
                {
                    //cmn.LogToFile("API Name : api/loanReferal/Product/GetProductDetailsGridBind | " + "Message : Success");

                    return new
                    {
                        status = appSettings.Value.SuccessMessage,
                        statusCode = response.responseCode,
                        message = response.message,
                        time = DateTime.Now,
                        data = response.data,
                    };
                }
                else
                {
                    //cmn.LogToFile("API Name : api/loanReferal/Product/GetProductDetailsGridBind | " + "Message : Error");

                    return new
                    {
                        status = appSettings.Value.ErrorMessage,
                        statusCode = response.responseCode,
                        message = response.message,
                        time = DateTime.Now,
                        data = response.data,
                    };
                }
            }
            catch (Exception ex)
            {
                //cmn.LogToFile("API Name : api/loanReferal/Product/GetProductDetailsGridBind | " + "Message : " + ex.Message);

                return new
                {
                    status = appSettings.Value.ErrorMessage,
                    time = DateTime.Now,
                    data = ex.Message,
                    data2 = ex.StackTrace
                };
            }
        }
    }
}
