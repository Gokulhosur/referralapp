using Microsoft.Extensions.Options;
using ReferalApp.Models;
using System.Net.Mail;
using System.Text;

namespace ReferalApp.Utils
{
    public class Utilities
    {
        private readonly IOptions<AppConfig> appSettings;

        public Utilities(IOptions<AppConfig> appConfig)
        {
            appSettings = appConfig;
        }
    }
}
