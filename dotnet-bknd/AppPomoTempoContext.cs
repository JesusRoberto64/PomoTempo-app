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
    
    //Set with no key
    public DbSet<Fecha_Mision_Registro> Fecha_Mision_Registro {get; set;}
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        //modelBuilder.Entity<Mision_Registro>().ToTable("Mision_Registro");
        modelBuilder.Entity<Fecha_Mision_Registro>().HasNoKey();
        base.OnModelCreating(modelBuilder);
    }

    //Wrap the fields of the Db
    
    public DbSet<Fechas> Fechas { get; set; }
    public DbSet<Misiones> Misiones {get; set;}
    public DbSet<Mision_Registro> Mision_Registro {get; set;}
    

}
