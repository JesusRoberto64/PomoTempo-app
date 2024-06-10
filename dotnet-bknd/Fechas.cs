//Se crea el homologo de la base de datos que se quiera hacer
//con las mismos tipos y nombres
//tambien procuro que el nombre de la tabla sea el mismo.
namespace dotnet_bknd;

public class Fechas
{
    public int Id { get; set; }
    public DateOnly Fecha { get; set; }
    public int Pomodoros { get; set; }

    //Esta es la realcion 1 a Muchos, donde Fechas es 1 y Pomodoros Muchos
    public ICollection<Pomodoros>? PomodorosList { get; set; }
}
