using dotnet_bknd.Models;
using dotnet_bknd.Repositories.Abstract;
using Microsoft.EntityFrameworkCore;

namespace dotnet_bknd.Repositories.Implementation;

public class FechasService : IFechasService
{
    private readonly AppPomoTempoContext _context;

    public FechasService(AppPomoTempoContext context)
    {
        _context = context;
    }

    public IResponse AddFecha(Fechas fechas)
    {
        
        DateOnly? fecha = null;
        if (fechas.Fecha == fecha)
        {
            return new IResponse {Success = false, Message = "Fecha no válida"};
        }
        try
        {
            var nuevaFecha = new Fechas{
                Fecha = fechas.Fecha,
                Pomodoros = fechas.Pomodoros
            };
            _context.Fechas.Add(nuevaFecha);
            _context.SaveChanges();

            int idFecha = GetIdFromFecha(fechas.Fecha);
            //int idFecha = _context.Fechas.FirstOrDefault(f => f.Fecha == fechas.Fecha)?.Id ?? -1;
            return new IResponse { Success = true, Message = "Fecha añadida", Id = idFecha};
        }
        catch (Exception err)
        {
            Console.WriteLine(err);
            return new IResponse { Success = false, Message = "ERROR NO SE PUEDE REGISTRAR FECHA" };
        }
    }

    public IResponse AddPomodoros(int id)
    {
        try
        {
            var fecha = GetFechasFromId(id);
            if ( fecha == null )
            {
                return new IResponse { Success = false, Message = "Id incorrecta" };
            }
            fecha.Pomodoros ++;
            _context.SaveChanges();
            return new IResponse { Success = true, Message = "Pomodoro Añadido" };
        }
        catch (Exception)
        {
            return new IResponse { Success = false, Message = "ERROR NO SE PUEDE AÑADIR POMODORO" };
        }  
        
    }

    public IResponse DeleteFecha(int id)
    {
        try
        {
            var fecha = GetFechasFromId(id);
            if ( fecha == null )
            {
                return new IResponse {Success= false, Message = "Id incorrecto"};
            }
            _context.Fechas.Remove(fecha);
            _context.SaveChanges();
            return new IResponse { Success = true, Message = "Fecha borrada exitosamente" };
        }
        catch (Exception)
        {
            
            return new IResponse { Success = false, Message = "ERROR NO SE PUEDE BORRAR"};
        }
    }

    public IResponse EditFecha(int id, DateOnly date, int pomodoros)
    {
        try
        {
            var fecha = GetFechasFromId(id);
            if ( fecha == null )
            {
                return new IResponse { Success = false, Message = "Id incorrecto" };
            }
            fecha.Fecha = date;
            fecha.Pomodoros = pomodoros;
            _context.SaveChanges();
            return new IResponse { Success= true, Message= "Fecha actualizada" };   
        }
        catch (Exception)
        {
            return new IResponse { Success= false, Message = "ERROR no se puede acutalizar" };
        }
    }

    public List<Fechas> FechasList()
    {
        List<Fechas> fechasLista = new List<Fechas>();
        var fechas = _context.Fechas.AsNoTracking();
        foreach (var fecha in fechas)
        {
            fechasLista.Add(fecha);
        }
        return fechasLista;
    }

    public Fechas GetFechasFromId(int id)
    {
        var fecha = _context.Fechas.Find(id);
        if ( fecha == null )
        {
            return null!;
        }
        return fecha;
    }

    public int GetIdFromFecha(DateOnly date)
    { 
        var fecha = _context.Fechas.FirstOrDefault(f => f.Fecha == date);
        if ( fecha == null)
        {
            return -1;
        }
        return fecha.Id;
    }
}
