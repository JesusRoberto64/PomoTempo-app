namespace dotnet_bknd.Models;

public class Misiones
{
    public int Id { get; set; }
    public string? Nombre { get; set; }

    //Relacion 1 a Muchos, donde 1 es Pomodoros y Muchos Misiones
    //public Pomodoros? Pomodoros { get; set; }
}
