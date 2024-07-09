using dotnet_bknd;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Http.HttpResults;
using dotnet_bknd.Repositories.Abstract;
using dotnet_bknd.Repositories.Implementation;
using dotnet_bknd.Models;
using dotnet_bknd.Models.DTO;

var builder = WebApplication.CreateBuilder(args);

var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");

builder.Services.AddDbContext<AppPomoTempoContext>( options =>
  options.UseSqlServer(connectionString));
//inyctar servicios
builder.Services.AddScoped<IDbServices, DbServices>();
builder.Services.AddScoped<IMisionService, MisionService>();

//añadir controladore
builder.Services.AddControllers();

var app = builder.Build();

app.MapControllers();

/*
app.MapGet("/",(IDbServices services) =>{
    return services.GetModelContext();
});
*/
/*
app.MapGet("/horas",(IDbServices services) =>{
    return services.HorasFromPomo();
});

app.MapGet("/fechas",(IDbServices services) =>{
    return services.FechasList();
});

//API MISIONES ROUTES
app.MapGet("/misiones",(IMisionService services) =>{
    return services.MisionList();
});

app.MapGet("/misiones/{id}", Results<Ok<Misiones>, NotFound> (int id, IMisionService services) =>{
    var misionName = services.GetMisionFromId(id);
    return misionName is null
        ? TypedResults.NotFound()
        : TypedResults.Ok(misionName);
});

//add new mision
app.MapPost("/misiones/add", (Misiones mision, IMisionService services) =>{
    var response = services.AddMision(mision);
    if (response.Success)
    {
        return Results.Created($"/misiones", response.Id);
    }
    else
    {
        return Results.BadRequest(response.Message);
    }
});

//edit mision
app.MapPatch("/misiones/update",(EditNombreRequest request, IMisionService service)=>{
    var response = service.EditMision(request.Id,request.Nombre!);
      if (response.Success)
    {
        return Results.Created($"/misiones", response.Message);
    }
    else
    {
        return Results.BadRequest(response.Message);
    }
});

app.MapDelete("/misiones/{id}", (int id, IMisionService service) =>{
    var response = service.DeleteMision(id);
    if (response.Success)
    {
        return Results.Created($"/misiones", response.Message);
    }
    else
    {
        return Results.BadRequest(response.Message);
    }
});
*/
app.Run();
