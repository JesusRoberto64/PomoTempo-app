using dotnet_bknd;
// Dependencies Entity Core, Core.Design, Core SQL server Nuget de Microsoft
using Microsoft.EntityFrameworkCore;
//The interfaces uses for the injection
using dotnet_bknd.Repositories.Abstract;
//The implementation of the interfases
using dotnet_bknd.Repositories.Implementation;

//Basic app builder
var builder = WebApplication.CreateBuilder(args);
//The deafult is set on the appsettings.json on connection srting
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");

//The contex that points to the specific database on server 
builder.Services.AddDbContext<AppPomoTempoContext>( options =>
  options.UseSqlServer(connectionString));
//inyectar servicios
builder.Services.AddScoped<IDbServices, DbServices>();
builder.Services.AddScoped<IMisionService, MisionService>();

//add controllers clases, those are declared on clases as an implementation (herency)
builder.Services.AddControllers();

var app = builder.Build();

app.MapControllers();

app.Run();
