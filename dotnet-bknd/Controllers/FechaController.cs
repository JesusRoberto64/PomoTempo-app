using System;
using dotnet_bknd.Models;
using dotnet_bknd.Repositories.Abstract;
using Microsoft.AspNetCore.Mvc;

namespace dotnet_bknd.Controllers;

[ApiController]
[Route("api/[controller]")]
public class FechaController : ControllerBase
{
    private readonly IFechasService _fechasService;

    public FechaController(IFechasService fechasService)
    {
        _fechasService = fechasService;
    }

    [HttpGet]
    public IActionResult GetFechas()
    {
        var fechas = _fechasService.FechasList();
        return Ok(fechas);
    }

    [HttpGet("{id}")]
    public IActionResult GetFecha(int id)
    {
        var fecha = _fechasService.GetFechasFromId(id);
        if ( fecha == null )
        {
            return NotFound();
        }
        return Ok(fecha);
    }

    [HttpPost("add")]
    public IActionResult AddFecha([FromBody]Fechas fecha)
    {
        var response = _fechasService.AddFecha(fecha);
        if ( response.Success )
        {
            int id = response.Id;
            return Ok(new { message = response.Message, id = response.Id});
        }
        return BadRequest(new { message = response.Message });
    }

    [HttpDelete("{id}")]
    public IActionResult DeleteFecha(int id)
    {
        var response = _fechasService.DeleteFecha(id);
        if ( response.Success )
        {
            return Ok(new { message = response.Message });
        }
        return BadRequest(new { message = response.Message });
    }

    //Continue
    [HttpPatch]
    public IActionResult EditFecha([FromBody]Fechas fechas)
    {
        var response = _fechasService.EditFecha(fechas.Id, fechas.Fecha, fechas.Pomodoros);
        if ( response.Success )
        {
            return Ok(new { message = response.Message });
        }
        return BadRequest( new { message = response.Message });
    }

}
