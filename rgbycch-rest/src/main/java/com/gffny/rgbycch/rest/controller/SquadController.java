package com.gffny.rgbycch.rest.controller;

import com.gffny.rgbycch.rest.model.SquadMember;
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

    @RequestMapping(value = "/{squadId}", method = RequestMethod.GET)
    @ResponseBody
    List<SquadMember> getSquadById(@PathVariable  final String squadId) {
        List<SquadMember> squadMemberList = new ArrayList<>();
        for(int i = 0; i < 15; i++) {
            squadMemberList.add(new SquadMember(""+i, "John"+i, "Gaffney"));
        }
        return squadMemberList;
    }

}
