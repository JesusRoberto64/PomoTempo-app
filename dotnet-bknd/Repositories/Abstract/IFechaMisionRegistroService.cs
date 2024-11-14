using System;
using dotnet_bknd.Models;

namespace dotnet_bknd.Repositories.Abstract;

public interface IFechaMisionRegistroService
{
    public List<Fecha_Mision_Registro> FechaMisionRegistroList();
    public Fecha_Mision_Registro GetFechaMisionRegistroFromIds(int fechaId, int misionId);
    IResponse AddFechaMisionRegistro(Fecha_Mision_Registro fechaMision);
    IResponse DeleteFechaMisionRegistro(int fechaId, int misionId);
    IResponse EditFechaMisionRegistro(int fechaId, int misionId, int pomodoros);
    IResponse AddPomodoro(int fechaId, int misionId);
    
}
