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
        var misiones = _context.Fechas.AsNoTracking();
        foreach(var fecha in misiones)
        {
            fechasLista.Add(fecha.Fecha.ToString());
        }

        return fechasLista;
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
