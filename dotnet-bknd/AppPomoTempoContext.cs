using Microsoft.EntityFrameworkCore;

namespace dotnet_bknd;

public class AppPomoTempoContext : DbContext
{
    public AppPomoTempoContext(DbContextOptions<AppPomoTempoContext> options)
     :base(options)
    {

    }
    
    public DbSet<Misiones> Misiones {get; set;}
    public DbSet<Pomodoros> Pomodoros { get; set; }
    public DbSet<Fechas> Fechas { get; set; }
}
