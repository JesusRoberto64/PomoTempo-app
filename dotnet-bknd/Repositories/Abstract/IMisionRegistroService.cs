using dotnet_bknd.Models;

namespace dotnet_bknd.Repositories.Abstract;

public interface IMisionRegistroService
{
    public List<Mision_Registro> MisionRegistroList();
    public Mision_Registro GetMisionRegistroFromId(int id);
    IResponse AddMisionRegistro(Mision_Registro mision);
    IResponse DeleteMisionRegistro(int id);
    IResponse EditMisionRegistro(int id, string nombre, int pomomodors);
    IResponse AddPomodoros(int id);


}
