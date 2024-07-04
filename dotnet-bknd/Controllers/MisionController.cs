using dotnet_bknd.Repositories.Abstract;
using Microsoft.AspNetCore.Mvc;

namespace dotnet_bknd.Controllers;

[ApiController]
[Route("api/[controller]")]
public class MisionController : ControllerBase
{
    private readonly IMisionService _misionService;

    public MisionController(IMisionService misionService)
    {
        _misionService = misionService;
    }

    [HttpGet]
    public IActionResult GetMisiones()
    {
        var misiones = _misionService.MisionList();
        return Ok(misiones);
    }

    [HttpGet("{id}")]
        public IActionResult GetMision(int id)
        {
            var mision = _misionService.GetMisionFromId(id);
            if (mision == null)
            {
                return NotFound();
            }
            return Ok(mision);
        }
}
