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
    return services.FechasList();
});


/*
app.MapGet("/", () => {
    List<String> misionesLista = [];
    using (var db = new AppPomoTempoContext()){
        var misiones = db.Misiones.AsNoTracking();
        foreach (var mision in misiones)
        {
            misionesLista.Add(mision.Nombre!);
        }
    }
    return misionesLista;
});
*/
/*
using (var db = new AppPomoTempoContext())
{
    //para iterar todos los elementos.
    //Este es el IQeurable AsNoTraking sin trakear los cambios en la DB
    var misiones = db.Misiones.AsNoTracking(); 
    foreach (var mision in misiones)
    {
        Console.WriteLine(mision.Nombre);
    }

    var fechas = db.Fechas.AsNoTracking();
    foreach(var fecha in fechas)
    {
        Console.WriteLine(fecha.Fecha);
    }
}
*/
app.Run();
