using dotnet_bknd.Repositories.Abstract;
using Microsoft.AspNetCore.Mvc;

namespace dotnet_bknd.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ServicessController : ControllerBase
{
    private readonly IDbServices _dbServices;

    public ServicessController(IDbServices dbServices)
    {
        _dbServices = dbServices;
    }

    [HttpGet]
    public IActionResult GetModel()
    {
        var modelContex = _dbServices.GetModelContext();
        return Ok(modelContex); 
    }
}
