package com.gffny.rgbycch.rest.controller;

import com.gffny.rgbycch.rest.model.SquadMember;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
@RestController
@RequestMapping("/squad")
public class SquadController {

    private static final Logger LOG = LoggerFactory.getLogger(SquadController.class);

    // TODO Create Squad through API

    // TODO Remove Squad through API

    // TODO Add Member to Squad through API

    // TODO Remove Member from Squad through API

    @RequestMapping(value = "/{squadId}", method = RequestMethod.GET)
    @ResponseBody
    List<SquadMember> getSquadById(@PathVariable  final String squadId) {
        LOG.debug("handling team request with id: {}", squadId);

        List<SquadMember> squadMemberList = new ArrayList<>();
        for(int i = 0; i < 15; i++) {
            squadMemberList.add(new SquadMember(""+i, "John"+i, "Gaffney"));
        }
        return squadMemberList;
    }

}
