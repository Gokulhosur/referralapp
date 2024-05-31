using ReferalApp.Models;
using Microsoft.Extensions.Options;
using System.Net.Mail;
using System.Text;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.Utils
{
    public class Common
    {
        LoanReferContext db;
        private readonly IOptions<AppConfig> appSettings;

        public Common(LoanReferContext _db, IOptions<AppConfig> appConfig)
        {
            db = _db;
            appSettings = appConfig;
        }
        private readonly Random _random = new Random();

        public string GenerateRandomString(int length)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            return new string(Enumerable.Repeat(chars, length)
              .Select(s => s[_random.Next(s.Length)]).ToArray());
        }

        public string EncryptPassword(string password)
        {
            return Convert.ToBase64String(System.Security.Cryptography.SHA256.Create().ComputeHash(Encoding.UTF8.GetBytes(password)));
        }

        public string GenerateVerificationCode(int length)
        {
            const string validChars = "1234567890";
            var random = new Random();
            var buffer = new char[length];

            for (int i = 0; i < length; i++)
            {
                buffer[i] = validChars[random.Next(validChars.Length)];
            }

            return new string(buffer);
        }


        public ResponseObj<object> SendEmailOTP(string EmailId)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                if (EmailId == null || EmailId == "")
                {
                    responseObj.responseCode = 400;
                    responseObj.isSuccess = false;
                    responseObj.data = "Email required";
                    responseObj.message = "Error";
                    return responseObj;
                }

                var verificationCode = GenerateVerificationCode(4);
                List<SmtpDetail> vsmtpdetail = GetSmtpDetails();

                if (vsmtpdetail[0].Smtpuseremail != null)
                {
                    MailMessage mailMsg = new MailMessage();
                    MailAddress mailAddress = new MailAddress(vsmtpdetail[0].Smtpuseremail, "LoanReferal");
                    mailMsg.From = mailAddress;
                    mailMsg.Subject = "LoanReferal Verification Code";
                    string messegeitem = string.Empty;
                    messegeitem += @"<html> 
<head> 
<meta http-equiv=""Content-Type""  content=""text/html charset=UTF-8"" />

<title>LoanReferal Verification Code</title>
<style>
.heading{text-align: center;color:#009994}
.logo{border: 1px solid #ffcc00;
		margin-right:390px;
		margin-left:410px;
		}
.bg-img{text-align: center;
		margin-bottom:24pxpx;
		}
.content{nmargin-left: 9px;}
.content1{font-style: italic;}
</style>
</head>
<body style = ""padding:0px;margin:0px"" >
<div class=""container"" style=""text-align: left"">
<div class=""mailhead""></div>
<div class=""body"" style =""padding: 1em 0em 1em 0em"">
<div style=""padding-bottom: 2em"" >
<div class=""heading"">
<h1>Welcome to LoanReferal App</h1>
</div>
<div class=""row"">
<p>Dear ,</p>
<p>Greetings from LoanReferal !</p>
<p>Your Verification Code is :  " + verificationCode + @"</p>
</div>
<div class=""row"">Thanks,</div>
<div class=""row"" style=""Padding-bottom: 2em"">LoanReferal </div>

<p style = ""text-align:left;font-family:Arial,sans-serif;color:grey"" >
<small>CONFIDENTIALITY NOTICE:<br> Proprietary / Confidential information belonging to LoanReferal be contained in this message.If you are not a recipient indicated or intended in this message(or responsible for delivery of this message to such person), or you think for any reason that this message may have been addressed to you in error, you may not use or copy or deliver this message to anyone else.In such case, you should destroy this message and are asked to notify the sender by reply email.</small></p> <p style=""text-align: center"">© Copyright-2023. All Rights Reserved.</p></div> </body></html>";


                    mailMsg.Body = messegeitem;
                    mailMsg.To.Add(EmailId);
                    mailMsg.IsBodyHtml = true;

                    SmtpClient emailClient = new SmtpClient(vsmtpdetail[0].SmtpDomainName, Convert.ToInt32(vsmtpdetail[0].Smtpport));
                    System.Net.NetworkCredential credentials = new System.Net.NetworkCredential(vsmtpdetail[0].Smtpuseremail, vsmtpdetail[0].Smtppassword);
                    emailClient.Credentials = credentials;
                    var exist = db.RefererDetails.Where(x => x.EmailId == EmailId).FirstOrDefault();
                    if (exist != null)
                    {
                        responseObj.responseCode = 400;
                        responseObj.isSuccess = false;
                        responseObj.data = "Email exist";
                        responseObj.message = "Error";
                        return responseObj;
                    }
                    else
                    {
                        emailClient.Send(mailMsg);

                        EmailIdVerification emailidVerify = new EmailIdVerification();
                        emailidVerify.EmailId = EmailId;
                        emailidVerify.VerficationCode = verificationCode;
                        emailidVerify.ExpiryDate = DateTime.Now.AddMinutes(5);
                        db.EmailIdVerifications.Add(emailidVerify);
                        db.SaveChanges();

                        responseObj.responseCode = 200;
                        responseObj.isSuccess = true;
                        responseObj.data = "Success";
                        return responseObj;
                    }
                }
                else
                {
                    responseObj.isSuccess = false;
                    responseObj.responseCode = 400;
                    responseObj.data = "Empty smtp credentials";
                    responseObj.message = "Error";
                    return responseObj;
                }
            }
            catch (Exception ex)
            {
                responseObj.responseCode = 500; responseObj.isSuccess = false; responseObj.data = ex.Message;
                return responseObj;
            }
        }


        public ResponseObj<object> VerifyEmailOTP(string EmailId, string verificationCode)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                var exist = db.EmailIdVerifications.Where(x => x.EmailId == EmailId && x.VerficationCode == verificationCode).FirstOrDefault();
                if (exist != null)
                {
                    var existMember = db.RefererDetails.Where(x => x.EmailId == EmailId).FirstOrDefault();
                    if (existMember != null)
                    {
                        exist.VerficationCode = "";
                        db.EmailIdVerifications.Update(exist);
                        db.SaveChanges();

                        responseObj.responseCode = 200;
                        responseObj.isSuccess = true;
                        responseObj.data = "Verification successful..!";
                        responseObj.message = "Success";
                        return responseObj;

                    }
                    responseObj.responseCode = 400;
                    responseObj.isSuccess = false;
                    responseObj.data = "User not found";
                    return responseObj;

                }
                else
                {
                    responseObj.responseCode = 400;
                    responseObj.isSuccess = false;
                    responseObj.data = "verification failed";
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


        public ResponseObj<object> ForgotEmailOTP(string EmailId)
        {
            var responseObj = new ResponseObj<object>();
            try
            {
                if (EmailId == null || EmailId == "")
                {
                    responseObj.responseCode = 400;
                    responseObj.isSuccess = false;
                    responseObj.data = "Email required";
                    responseObj.message = "Error";
                    return responseObj;
                }

                var verificationCode = GenerateVerificationCode(4);
                List<SmtpDetail> vsmtpdetail = GetSmtpDetails();

                if (vsmtpdetail[0].Smtpuseremail != null)
                {
                    MailMessage mailMsg = new MailMessage();
                    MailAddress mailAddress = new MailAddress(vsmtpdetail[0].Smtpuseremail, "LoanReferal");
                    mailMsg.From = mailAddress;
                    mailMsg.Subject = "LoanReferal Verification Code";
                    string messegeitem = string.Empty;
                    messegeitem += @"<html> 
<head> 
<meta http-equiv=""Content-Type""  content=""text/html charset=UTF-8"" />

<title>LoanReferal Verification Code</title>
<style>
.heading{text-align: center;color:#009994}
.logo{border: 1px solid #ffcc00;
		margin-right:390px;
		margin-left:410px;
		}
.bg-img{text-align: center;
		margin-bottom:24pxpx;
		}
.content{nmargin-left: 9px;}
.content1{font-style: italic;}
</style>
</head>
<body style = ""padding:0px;margin:0px"" >
<div class=""container"" style=""text-align: left"">
<div class=""mailhead""></div>
<div class=""body"" style =""padding: 1em 0em 1em 0em"">
<div style=""padding-bottom: 2em"" >
<div class=""heading"">
<h1>Welcome to LoanReferal App</h1>
</div>
<div class=""row"">
<p>Dear ,</p>
<p>Greetings from LoanReferal !</p>
<p>Your Verification Code is :  " + verificationCode + @"</p>
</div>
<div class=""row"">Thanks,</div>
<div class=""row"" style=""Padding-bottom: 2em"">LoanReferal </div>

<p style = ""text-align:left;font-family:Arial,sans-serif;color:grey"" >
<small>CONFIDENTIALITY NOTICE:<br> Proprietary / Confidential information belonging to LoanReferal be contained in this message.If you are not a recipient indicated or intended in this message(or responsible for delivery of this message to such person), or you think for any reason that this message may have been addressed to you in error, you may not use or copy or deliver this message to anyone else.In such case, you should destroy this message and are asked to notify the sender by reply email.</small></p> <p style=""text-align: center"">© Copyright-2023. All Rights Reserved.</p></div> </body></html>";


                    mailMsg.Body = messegeitem;
                    mailMsg.To.Add(EmailId);
                    mailMsg.IsBodyHtml = true;

                    SmtpClient emailClient = new SmtpClient(vsmtpdetail[0].SmtpDomainName, Convert.ToInt32(vsmtpdetail[0].Smtpport));
                    System.Net.NetworkCredential credentials = new System.Net.NetworkCredential(vsmtpdetail[0].Smtpuseremail, vsmtpdetail[0].Smtppassword);
                    emailClient.Credentials = credentials;
                    var exist = db.RefererDetails.Where(x => x.EmailId == EmailId).FirstOrDefault();
                    if (exist != null)
                    {
                        emailClient.Send(mailMsg);

                        EmailIdVerification emailidVerify = new EmailIdVerification();
                        emailidVerify.EmailId = EmailId;
                        emailidVerify.VerficationCode = verificationCode;
                        emailidVerify.ExpiryDate = DateTime.Now.AddMinutes(5);
                        db.EmailIdVerifications.Add(emailidVerify);
                        db.SaveChanges();

                        responseObj.responseCode = 200;
                        responseObj.isSuccess = true;
                        responseObj.data = "Success";
                        return responseObj;
                    }
                    else
                    {
                        responseObj.responseCode = 400;
                        responseObj.isSuccess = false;
                        responseObj.data = "User not found";
                        responseObj.message = "Error";
                        return responseObj;
                    }
                }
                else
                {
                    responseObj.isSuccess = false;
                    responseObj.responseCode = 400;
                    responseObj.data = "Empty smtp credentials";
                    responseObj.message = "Error";
                    return responseObj;
                }
            }
            catch (Exception ex)
            {
                responseObj.responseCode = 500; responseObj.isSuccess = false; responseObj.data = ex.Message;
                return responseObj;
            }
        }

        //Genertate Log Function
        public void LogToFile(string message)
        {
            string formattedDate = DateTime.Now.ToString("dd_MM_yyyy");
            string filePath = $"{formattedDate}_log_file.txt";
            string fullFilePath = Path.Combine(Environment.CurrentDirectory, "Logs", filePath);
            string logMessage = $"{message}\n{DateTime.Now}";

            if (File.Exists(fullFilePath))
            {
                using (StreamWriter writer = new StreamWriter(fullFilePath, true))
                {
                    writer.WriteLine(logMessage);
                }
            }
            else
            {
                using (StreamWriter writer = new StreamWriter(fullFilePath))
                {
                    writer.WriteLine(logMessage);
                }
            }
        }

        public List<SmtpDetail> GetSmtpDetails()
        {
            try
            {
                var a = (from p in db.SmtpDetails.AsEnumerable()
                         select new SmtpDetail
                         {
                             SmtpDetailId = p.SmtpDetailId,
                             Smtpport = p.Smtpport,
                             SmtpDomainName = p.SmtpDomainName,
                             Smtpuseremail = p.Smtpuseremail,
                             Smtppassword = p.Smtppassword

                         });
                return a.ToList();
            }
            catch
            {
                return null;
            }
        }

    }
}
