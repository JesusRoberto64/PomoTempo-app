namespace dotnet_bknd.Models;

public class IResponse
{
    public bool Success { get; set; }
    public string? Message { get; set; }
    public Misiones? Mision { get; set; }
    public int Id { get; set; }
}
