package com.gffny.rgbycch.rest.controller;

import com.gffny.rgbycch.rest.model.incident.Incident;
import com.gffny.rgbycch.rest.model.incident.PlayerIncident;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

/**
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
@RestController
@RequestMapping("/incident")
public class IncidentController {

    private static final Logger LOG = LoggerFactory.getLogger(IncidentController.class);

    // TODO Create Squad through API

    // TODO Remove Squad through API

    // TODO Add Member to Squad through API

    // TODO Remove Member from Squad through API

    @RequestMapping(value = "/{incidentId}", method = RequestMethod.GET)
    @ResponseBody
    Incident getIncidentById(@PathVariable  final String incidentId) {
        LOG.debug("handling team request with id: {}", incidentId);

        return new PlayerIncident();
    }

}
