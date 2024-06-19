using dotnet_bknd.Models;
using dotnet_bknd.Repositories.Abstract;
using Microsoft.EntityFrameworkCore;

namespace dotnet_bknd.Repositories.Implementation;

public class MisionService : IMisionService
{
    private readonly AppPomoTempoContext _context;

    public MisionService(AppPomoTempoContext context)
    {
        _context = context;
    }

    public IResponse AddMision(Misiones mision)
    {
        if (string.IsNullOrEmpty(mision.Nombre))
        {
            return new IResponse { Success = false, Message ="Agrégale un nombre a la misión"};
        }

        try
        {
            _context.Misiones.Add(mision);
            _context.SaveChanges();
            return new IResponse { Success = true, Message = "Misión agregada exitosamente"};
        }
        catch (Exception)
        {
            return new IResponse{ Success = false, Message = "ERROR NO SE PUDO GUARDAR"};
        }
    }

    public IResponse DeleteMision(int id)
    {
        try
        {
            var mision = GetMisionFromId(id);
            if (mision == null)
            {
                return new IResponse { Success = false, Message ="Id incorrecto"};
            }
            _context.Misiones.Remove(mision);
            _context.SaveChanges();
            return new IResponse { Success = true, Message = "Misión borrada exitosamente"};

        }
        catch (Exception)
        {
            return new IResponse{ Success = false, Message = "ERROR NO SE PUDO BORRAR"};   
        }
    }

    public IResponse EditMision(int id, string nombre)
    {
        try
        {
            var curretMision = GetMisionFromId(id);
            if (curretMision == null)
            {
                return new IResponse { Success = false, Message ="Id incorrecto"};
            }
            //update 
            curretMision.Nombre = nombre;
            _context.SaveChanges();
            return new IResponse {Success =  true, Message = "Misión Actualizada"};
        }
        catch (Exception)
        {
            return new IResponse{ Success = false, Message = "ERROR NO SE PUDO ACTUALIZR"};               
        }
        
    }

    public Misiones GetMisionFromId(int id)
    {
        var mision = _context.Misiones.Find(id);
        if (mision == null)
        {
            return null!;
        }
        return mision;
    }

    public List<string> MisionList()
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
