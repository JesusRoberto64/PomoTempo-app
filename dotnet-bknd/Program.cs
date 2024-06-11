using dotnet_bknd;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http.HttpResults;
using dotnet_bknd.Repositories.Abstract;
using dotnet_bknd.Repositories.Implementation;

var builder = WebApplication.CreateBuilder(args);
//Servicions inyectados

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");

builder.Services.AddDbContext<AppPomoTempoContext>( options =>
  options.UseSqlServer(connectionString));
builder.Services.AddScoped<IDbServices, DbServices>();

var app = builder.Build();

app.MapGet("/",(IDbServices services) =>{
    return services.GetModelContext();
});


app.MapGet("/misiones",(IDbServices services) =>{
    return services.misionesList();
});

app.MapGet("/horas",(IDbServices services) =>{
    return services.HorasFromPomo();
});

app.MapGet("/fechas",(IDbServices services) =>{
    return services.FechasList();
});

app.Run();
