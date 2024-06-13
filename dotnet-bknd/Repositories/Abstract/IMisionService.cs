using dotnet_bknd.Models;

namespace dotnet_bknd.Repositories.Abstract;

public interface IMisionService
{
    public List<String> MisionList();
    public Misiones GetMisionFromId(int id);
    public IResponse AddMision(Misiones mision);
    public IResponse DeleteMision(int id);
    public IResponse EditMision();

    //Patch
    //Put
}
