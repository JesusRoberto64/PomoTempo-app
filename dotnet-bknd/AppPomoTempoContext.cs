using dotnet_bknd.Models;
using Microsoft.EntityFrameworkCore;


namespace dotnet_bknd;

public class AppPomoTempoContext : DbContext
{
    public AppPomoTempoContext(DbContextOptions<AppPomoTempoContext> options)
     :base(options)
    {
        //Console.WriteLine(context.Model.ToDebugString());
    }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        //base.OnModelCreating(modelBuilder);

    }

    //Wrap the fields of the Db
    public DbSet<Misiones> Misiones {get; set;}
    public DbSet<Pomodoros> Pomodoros { get; set; }
    public DbSet<Fechas> Fechas { get; set; }
}
