using dotnet_bknd.Repositories.Abstract;
using Microsoft.EntityFrameworkCore;

namespace dotnet_bknd.Repositories.Implementation;

public class DbServices : IDbServices
{
    
    private readonly AppPomoTempoContext _context;

    public DbServices(AppPomoTempoContext context)
    {
        _context = context;
    }

    public List<string> FechasList()
    {
        List<string> fechasLista = new List<string>();
        var fechas = _context.Fechas.AsNoTracking();
        foreach(var fecha in fechas)
        {
            fechasLista.Add(fecha.Fecha.ToString());
        }

        return fechasLista;
    }

    public string? GetModelContext()
    {
        return _context.Model.ToDebugString();
    }

    public List<string> HorasFromPomo()
    {
        List<string> horasLista = new List<string>();
        var horas = _context.Pomodoros.AsNoTracking();
        foreach(var hora in horas)
        {
           horasLista.Add(hora.Hora.ToString());
        }

        return horasLista; 
    }

    public List<string> misionesList()
    {
        List<string> misionesLista = new List<string>();
        var misiones = _context.Misiones.AsNoTracking();
        foreach(var mision in misiones)
        {
            misionesLista.Add(mision.Nombre!);
        }

        return misionesLista;
    }
}
