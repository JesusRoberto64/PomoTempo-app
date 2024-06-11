namespace dotnet_bknd.Models;

public class Response
{
    public bool Success { get; set; }
    public string? Message { get; set; }
    public Misiones? Mision { get; set; }
}
