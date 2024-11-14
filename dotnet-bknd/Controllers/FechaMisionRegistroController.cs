using dotnet_bknd.Models;
using dotnet_bknd.Repositories.Abstract;
using Microsoft.AspNetCore.Mvc;

namespace dotnet_bknd.Controllers;

[ApiController]
[Route("api/[controller]")]
public class FechaMisionRegistroController : ControllerBase
{
    private readonly IFechaMisionRegistroService _fechaMisionRegistroService;

    public FechaMisionRegistroController(IFechaMisionRegistroService fechaMisionRegistroService)
    {
        _fechaMisionRegistroService = fechaMisionRegistroService;
    }

    [HttpGet]
    public IActionResult GetFechasMisionRegistros()
    {
        var registros = _fechaMisionRegistroService.FechaMisionRegistroList();
        return Ok(registros);
    }

    // endpint Route will be api/controller/{fechId}/{misionId} 
    // example /api/fechamisionregistro/1/2 where fechaid = 1 misionId = 2
    [HttpGet("{fechaId}/{misionId}")]
    public IActionResult GetFechaMisionRegistro(int fechaId, int misionId )
    {
        var registro = _fechaMisionRegistroService.GetFechaMisionRegistroFromIds(fechaId, misionId);
        if ( registro == null )
        {
            return NotFound();
        }
        return Ok(registro);
    }

    [HttpPost("add")]
    public IActionResult AddFechaMisionRegistro([FromBody]Fecha_Mision_Registro fechaMisionRegistro)
    {
        var response = _fechaMisionRegistroService.AddFechaMisionRegistro(fechaMisionRegistro);
        if ( response.Success )
        {
            string misionId = response.Message!;
            return Ok(misionId);
        }
        return BadRequest(new { message = response.Message } );
    }

    [HttpDelete("{fechaId}/{misionId}")]
    public IActionResult DeleteFechaMisionRegistro(int fechaId, int misionId)
    {
        var response = _fechaMisionRegistroService.DeleteFechaMisionRegistro(fechaId, misionId);
        if ( response.Success )
        {
            return Ok(new { message = response.Message });
        }
        return BadRequest(new { message = response.Message});
    }

    [HttpPatch("Update")]
    public IActionResult EditFechaMisionRegistro([FromBody]Fecha_Mision_Registro fechaMisionRegistro)
    {
        var response = _fechaMisionRegistroService.EditFechaMisionRegistro(fechaMisionRegistro.Fecha_id, fechaMisionRegistro.Mision_id, fechaMisionRegistro.Pomodoros);
        if ( response.Success )
        {
            return Ok(new { message = response.Message });
        }
        return BadRequest(new { message = response.Message });
    }
}
