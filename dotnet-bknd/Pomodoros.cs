namespace dotnet_bknd;

public class Pomodoros
{
    public int Id { get; set; }
    public int MisionId { get; set; }
    public DateTime Hora { get; set; }
    public int FechaId { get; set; }

    //Ancla de 1 a Muchos, donde 1 es Fecha y Muchos Pomodoros
    public Fechas? Fechas { get; set; }

    //Relacion 1 a Muchos, donde 1 es Pomodoros y Muchos Misiones
    public ICollection<Misiones>? MisionesList { get; set; }
}
