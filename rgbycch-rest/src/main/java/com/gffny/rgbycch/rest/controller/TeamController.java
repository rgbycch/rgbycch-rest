package com.gffny.rgbycch.rest.controller;

import com.gffny.rgbycch.rest.model.Team;
import com.gffny.rgbycch.rest.model.TeamMember;
import org.springframework.web.bind.annotation.*;

/**
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
@RestController
@RequestMapping("/team")
public class TeamController {

    // TODO Create Team through API

    // TODO Remove Team through API

    // TODO Add Member to Team through API

    // TODO Remove Member from Team through API

    @RequestMapping(value = "/{teamId}", method = RequestMethod.GET)
    @ResponseBody
    Team getTeamById(@PathVariable  final String teamId) {

        TeamMember johnGaffney = new TeamMember("1", "John", "Gaffney");
        Team sampleTeam = new Team();
        sampleTeam.setFullback(johnGaffney);
        sampleTeam.setRightWing(johnGaffney);
        sampleTeam.setSecondCentre(johnGaffney);
        sampleTeam.setFirstCentre(johnGaffney);
        sampleTeam.setLeftWing(johnGaffney);
        sampleTeam.setFlyHalf(johnGaffney);
        sampleTeam.setScrumHalf(johnGaffney);
        sampleTeam.setLooseHeadProp(johnGaffney);
        sampleTeam.setHooker(johnGaffney);
        sampleTeam.setTightHeadProp(johnGaffney);
        sampleTeam.setLooseHeadSecondRow(johnGaffney);
        sampleTeam.setTightHeadSecondRow(johnGaffney);
        sampleTeam.setBlindSideFlanker(johnGaffney);
        sampleTeam.setOpensideFlanker(johnGaffney);
        sampleTeam.setNumberEight(johnGaffney);
        return sampleTeam;
    }



}
