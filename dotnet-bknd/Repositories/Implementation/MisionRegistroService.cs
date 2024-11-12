using dotnet_bknd.Models;
using dotnet_bknd.Repositories.Abstract;
using Microsoft.EntityFrameworkCore;

namespace dotnet_bknd.Repositories.Implementation;

public class MisionRegistroService : IMisionRegistroService
{
    private readonly AppPomoTempoContext _context;
    public MisionRegistroService(AppPomoTempoContext context)
    {
        _context = context;
    }

    public IResponse AddMisionRegistro(Mision_Registro mision)
    {
        if ( string.IsNullOrEmpty(mision.Nombre) )
        {
            return new IResponse { Success = false, Message = "Añade un nombre" };
        }
        try
        {
            _context.Mision_Registro.Add(mision);
            _context.SaveChanges();

            //Tomar la nueva ID del registro dela mision
            int newMisionRegistroId = mision.Id;

            return new IResponse { Success = true, Message = "Mision Registro agregada exitosamente", Id= newMisionRegistroId };
        }
        catch (Exception)
        {
            
            return new IResponse{ Success = false, Message = "ERROR NO SE PUDO REGISTRAR MISIÓN" };
        }
    }

    public IResponse AddPomodoros(int id)
    {
        try
        {
            var misionRegistro = GetMisionRegistroFromId(id);
            if ( misionRegistro == null )
            {
                return new IResponse { Success = false, Message = "Id incorrecto"};
            }
            misionRegistro.Pomodoro ++;
            _context.SaveChanges();
            return new IResponse { Success = true, Message = "Pomodoro añadido" };
        }
        catch (Exception)
        {
            return new IResponse{ Success = false, Message = "ERROR NO SE PUEDE AÑADIR POMODORO" };
        }
    }

    public IResponse DeleteMisionRegistro(int id)
    {
        try
        {
            var misionRegistro = GetMisionRegistroFromId(id);
            if ( misionRegistro == null )
            {
                return new IResponse { Success = false, Message = "Id Inconrrecto" };   
            }
            _context.Mision_Registro.Remove(misionRegistro);
            _context.SaveChanges();
            return new IResponse { Success = true, Message = "Misión Borrada exitosamente" };
        }
        catch (Exception)
        {
            return new IResponse{ Success = false, Message = "ERROR NO SE PUDO BORRAR" };
        }
    }

    public IResponse EditMisionRegistro(int id, string nombre, int pomomodoros)
    {
        
        try
        {
            var curretMisionRegistro = GetMisionRegistroFromId(id);
            if ( curretMisionRegistro == null )
            {
                return new IResponse { Success = false, Message ="Id incorrecto" };
            }
            //upadate
            curretMisionRegistro.Nombre = nombre;
            curretMisionRegistro.Pomodoro = pomomodoros;
            _context.SaveChanges();
            return new IResponse { Success=true, Message= "Misión Registro Actualizada" };
        }
        catch (Exception)
        {
            return new IResponse{ Success=false, Message="ERROR No se puede actualizar" };
        }
    }

    public Mision_Registro GetMisionRegistroFromId(int id)
    {
        var misionRegistro = _context.Mision_Registro.Find(id);
        if ( misionRegistro == null )
        {
            return null!;
        }
        return misionRegistro;
    }

    public List<Mision_Registro> MisionRegistroList()
    {
        List<Mision_Registro> misionRegistroLista = new List<Mision_Registro>();
        var misionesRegistros = _context.Mision_Registro.AsNoTracking();
        foreach (var misionRegistro in misionesRegistros)
        {   
            misionRegistroLista.Add(misionRegistro);
        }

        return misionRegistroLista;
    }
}
