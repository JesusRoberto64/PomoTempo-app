using dotnet_bknd.Models;

namespace dotnet_bknd.Repositories.Abstract;

public interface IDbServices
{
    public List<String> misionesList();
    public List<String> FechasList();
    public List<String> HorasFromPomo();
    public string? GetModelContext();
    public Response AddMision(Misiones mision);



}
