using Microsoft.EntityFrameworkCore;

namespace dotnet_bknd;

public class AppPomoTempoContext : DbContext
{
    //private const string connectionString = 
    //@"Data Source=DESKTOP-4VPN43T\sqlexpress; Initial Catalog=PomoTempo; Integrated Security=True; TrustServerCertificate=True";
    //TrustServerCertificate=True solo para desarrollo y pruebas

    public AppPomoTempoContext(DbContextOptions<AppPomoTempoContext> options)
     :base(options)
    {

    }
    
    /*
    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlServer(connectionString);
    }
    */
    
    public DbSet<Misiones> Misiones {get; set;}
    public DbSet<Pomodoros> Pomodoros { get; set; }
    public DbSet<Fechas> Fechas { get; set; }
}
