using System;
using dotnet_bknd.Models;
using dotnet_bknd.Repositories.Abstract;
using Microsoft.AspNetCore.Mvc;

namespace dotnet_bknd.Controllers;

[ApiController]
[Route("api/[controller]")]
public class MisionRegistroController : ControllerBase
{
    private readonly IMisionRegistroService _misionRegistroService;
    public MisionRegistroController(IMisionRegistroService misionRegistroService)
    {
        _misionRegistroService = misionRegistroService;
    }

    [HttpGet]
    public IActionResult GetMisionesRegistos()
    {
        var misionesRegistros = _misionRegistroService.MisionRegistroList();
        return Ok(misionesRegistros);
    }

    [HttpGet("{id}")]
    public IActionResult GetMisionRegistro(int id)
    {
        var misionRegistro = _misionRegistroService.GetMisionRegistroFromId(id);
        if ( misionRegistro == null )
        {
            return NotFound();
        }
        return Ok(misionRegistro);
    }

    [HttpPost("add")]
    public IActionResult AddMisionRegistro([FromBody]Mision_Registro mision_Registro)
    {
        var response = _misionRegistroService.AddMisionRegistro(mision_Registro);
        if (response.Success)
        {
            int id = response.Id;
            return Ok(id);
        }
        return BadRequest(new { message = response.Message });
    }

    [HttpDelete("{id}")]
    public IActionResult DeleteMisionRegistro(int id)
    {
        var response = _misionRegistroService.DeleteMisionRegistro(id);
        if ( response.Success )
        {
            return Ok(new { message = response.Message });
        }
        return BadRequest(new { message = response.Message });
    }

    [HttpPatch("Update")]
    public IActionResult EditMisionRegistro([FromBody]Mision_Registro mision_Registro)
    {
        var response = _misionRegistroService.EditMisionRegistro(mision_Registro.Id, mision_Registro.Nombre!, mision_Registro.Pomodoro);
        if (response.Success)
        {
            return Ok(new { message = response.Message });
        }
        return BadRequest(new { message = response.Message });
    }
}
