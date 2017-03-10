package com.gffny.rgbycch.rest.controller;

import com.gffny.rgbycch.rest.model.Match;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

/**
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
@RestController
@RequestMapping("/match")
public class MatchController {

    private static final Logger LOG = LoggerFactory.getLogger(MatchController.class);

    // TODO Create Team through API

    // TODO Remove Team through API

    // TODO Add Member to Team through API

    // TODO Remove Member from Team through API

    @RequestMapping(value = "/{matchId}", method = RequestMethod.GET)
    @ResponseBody
    Match getMatchById(@PathVariable  final String matchId) {
        LOG.debug("handling match request with id: {}", matchId);

        return null;
    }


}
