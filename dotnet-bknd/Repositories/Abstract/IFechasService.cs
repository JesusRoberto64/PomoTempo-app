using System;
using dotnet_bknd.Models;

namespace dotnet_bknd.Repositories.Abstract;

public interface IFechasService
{
    public List<Fechas> FechasList();
    public Fechas GetFechasFromId(int id);
    IResponse AddFecha(Fechas fechas);
    IResponse DeleteFecha(int id);
    IResponse EditFecha(int id, DateOnly date, int pomodoros );
    IResponse AddPomodoros(int id);

}
