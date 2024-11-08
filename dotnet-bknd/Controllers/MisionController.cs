﻿using dotnet_bknd.Models;
using dotnet_bknd.Repositories.Abstract;
using Microsoft.AspNetCore.Mvc;

namespace dotnet_bknd.Controllers;

//Remember for requesting enponti is host://Route + ControllerName +(name)
//IMPORTANT ControllerName = first word of class name Example continue->>
//->> public class MisionController ->> (Mision)Controller ->> ; (mision) Lowercase
//and the end point will be : host:/api/mision/{id}

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
    
    [HttpPost("add")]
    public IActionResult AddMision([FromBody]Misiones mision)
    {
        var response = _misionService.AddMision(mision);
        if (response.Success)
        {   
            int id = response.Id;
            return Ok(id);
        }
            return BadRequest(new { message = response.Message });
    }

    [HttpDelete("{id}")]
    public IActionResult DeleteMision(int id)
    {
        var response = _misionService.DeleteMision(id);
        if (response.Success)
        {
            return Ok(new { message = response.Message });
        }
        return BadRequest(new { message = response.Message });
    }

    [HttpPatch("update")]
    public IActionResult EditMision([FromBody]Misiones mision)
    {

        var response = _misionService.EditMision(mision.Id,mision.Nombre!);
        if (response.Success)
        {
            return Ok(new { message = response.Message });
        }
        return BadRequest(new { message = response.Message });
    }
}
