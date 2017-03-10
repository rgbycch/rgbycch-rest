package com.gffny.rgbycch.rest.controller;

import com.gffny.rgbycch.rest.model.incident.Incident;
import com.gffny.rgbycch.rest.model.incident.PlayerIncident;
import org.springframework.web.bind.annotation.*;

/**
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
@RestController
@RequestMapping("/incident")
public class IncidentController {

    // TODO Create Squad through API

    // TODO Remove Squad through API

    // TODO Add Member to Squad through API

    // TODO Remove Member from Squad through API

    @RequestMapping(value = "/{incidentId}", method = RequestMethod.GET)
    @ResponseBody
    Incident getIncidentById(@PathVariable  final String incidentId) {
        return new PlayerIncident();
    }

}
