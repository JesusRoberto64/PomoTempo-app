using dotnet_bknd.Models;

namespace dotnet_bknd.Repositories.Abstract;

public interface IDbServices
{
    public List<String> MisionesList();
    public List<String> FechasList();
    public string? GetModelContext();
    public IResponse AddMision(Misiones mision);



}
