using ReferalApp.Middleware;
using ReferalApp.Models;
using ReferalApp.Utils;
using Serilog;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
builder.Logging.AddSerilog(SerilogConfig.AddSerilogConfiguration());
builder.Services.Configure<AppConfig>(builder.Configuration.GetSection("CustomKeysAndValues"));
builder.Services.Configure<AppConfig>(builder.Configuration.GetSection("AppSettings"));
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddDbContext<LoanReferContext>();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseCors(builder => builder.AllowAnyHeader().AllowAnyMethod().SetIsOriginAllowed((host) => true).AllowCredentials());

app.UseAuthorization();

app.MapControllers();

app.Run();
