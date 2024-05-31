using FluentValidation;
using Microsoft.Extensions.Options;
using ReferalApp.Models;
using ReferalApp.Utils;
using static ReferalApp.Utils.Entity;

namespace ReferalApp.ValidationRules
{
    public class LeadsParamValidator : AbstractValidator<long>
    {
        //private readonly IOptions<AppConfig> appSettings;
        //public LeadsParamValidator()
        //{

        //    Lead_Validation();
        //}

        //private void Lead_Validation()
        //{

        //    RuleFor(x=>x).not().WithMessage(appSettings.Value.LeadIdMandatory);

        //    //   rulefor(x => x.first_name)
        //    //.cascade(cascademode.stoponfirstfailure)
        //    //.notempty().withmessage("first_name is empty")
        //    //.length(1, 200).withmessage("length of first_name invalid")
        //    //.matches("[a-z]");

        //    //RuleFor(x => x.Last_name).NotEmpty().WithMessage("Last_name is Empty")
        //    //.MaximumLength(200).WithMessage("Length of Last_name Invalid")
        //    //.Matches("[A-Z]");

        //    //RuleFor(x => x.Nickname)
        //    //.MaximumLength(200).WithMessage("Length Nickname Invalid");

        //    //RuleFor(x => x.Source_ID).NotEmpty()
        //    //.MaximumLength(100)
        //    //.WithMessage("Length of Source_ID Invalid");

        //    //RuleFor(x => x.Email).NotEmpty().WithMessage("Email is Empty")
        //    //.EmailAddress()
        //    //.WithMessage(@"Please provide a valid eMail address.");

        //    //RuleFor(x => x.Mobile_number).NotEmpty().WithMessage("Mobile_number is Empty")
        //    //.Length(12, 12)
        //    //.WithMessage("Phone number must be in the form of &#8220;123-456-7890&#8221;")
        //    //.Matches(@"^\d{3}-\d{3}-\d{4}$")
        //    //.WithMessage("Phone number must be a valid 10-digit phone number with dashes, in the form of &#8220;123-456-7890&#8221;");

        //    //RuleFor(x => x.Date_of_birth).NotEmpty().WithMessage("Date_of_birth is Empty")
        //    //    .When(x => DateTime.Now.Year == DateTime.Now.Year - 16)
        //    //    .LessThan(x => DateTime.Now);

        //    //RuleFor(x => x.Time_zone != default(TimeZoneInfo));
        //}
    }
}
