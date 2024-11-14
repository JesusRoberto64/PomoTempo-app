using System;
using dotnet_bknd.Models;
using dotnet_bknd.Repositories.Abstract;
using Microsoft.EntityFrameworkCore;

namespace dotnet_bknd.Repositories.Implementation;

public class FechaMisionRegistroService : IFechaMisionRegistroService
{
    private readonly AppPomoTempoContext _context;

    public FechaMisionRegistroService(AppPomoTempoContext contex)
    {
        _context = contex;
    }

    public IResponse AddFechaMisionRegistro(Fecha_Mision_Registro fechaMision)
    {
        try
        {
            _context.Fecha_Mision_Registro.Add(fechaMision);
            _context.SaveChanges();

            return new IResponse { Success = true, Message = "Fecha misión registro añadido exitosamente" };
        }
        catch (System.Exception)
        {
            
            return new IResponse { Success = false, Message = "ERROR NO SE PUDO AÑADIR FECHA MISION REGISTRO" };
        }
    }

    public IResponse AddPomodoro(int fechaId, int misionId)
    {
        try
        {
            var registro = GetFechaMisionRegistroFromIds(fechaId, misionId);
            if ( registro == null )
            {
                return new IResponse { Success = false, Message ="Ids incorrectos" };
            }
            registro.Pomodoros ++;
            _context.SaveChanges();
            return new IResponse { Success = true, Message = "Pomodoro añadido exitosamente" };
        }
        catch (Exception)
        {
            return new IResponse{ Success = false, Message = "ERROR NO SE PUDE AÑADOR POMODORO" };
        }
    }

    public IResponse DeleteFechaMisionRegistro(int fechaId, int misionId)
    {
        try
        {
            var registro = GetFechaMisionRegistroFromIds(fechaId, misionId);
            if ( registro == null ){
                return new IResponse { Success = false, Message = "Ids incorrectos" };
            }
            _context.Fecha_Mision_Registro.Remove(registro);
            _context.SaveChanges();
            return new IResponse { Success= true, Message = "Fecha Mision registro borrrado"};
        }
        catch (Exception)
        {
            
            return new IResponse { Success = false, Message = "ERROR NO SE PUDO BORRAR" };
        }
    }

    public IResponse EditFechaMisionRegistro(int fechaId, int misionId, int pomodoros)
    {
        try
        {
            var currentRegistro = GetFechaMisionRegistroFromIds(fechaId, misionId);
            if ( currentRegistro == null )
            {
                return new IResponse { Success = false, Message = "Id fecha y mision incorrecta"};
            }
            currentRegistro.Pomodoros = pomodoros;
            _context.SaveChanges();
            return new IResponse { Success = true, Message = "Se modifico registro exitosamente" };
        }
        catch (Exception)
        {
            return new IResponse { Success = false, Message = "ERROR no se puede actualizar" };
        }
    }

    public List<Fecha_Mision_Registro> FechaMisionRegistroList()
    {
        
        List<Fecha_Mision_Registro> registrosLista = new List<Fecha_Mision_Registro>();
        var registros = _context.Fecha_Mision_Registro.AsNoTracking();
        foreach (var registro in registros)
        {
            registrosLista.Add(registro);
        }

        return registrosLista;
    }

    public Fecha_Mision_Registro GetFechaMisionRegistroFromIds(int fechaId, int misionId)
    {
        var registro = _context.Fecha_Mision_Registro.Where(r => r.Fecha_id == fechaId && r.Mision_id == misionId).FirstOrDefault();
        if ( registro == null )
        {
            return null!;
        }
        return registro;
    }
}
