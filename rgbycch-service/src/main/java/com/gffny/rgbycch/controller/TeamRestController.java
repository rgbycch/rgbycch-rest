/**
 * 
 */
package com.gffny.rgbycch.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.apache.commons.lang.NotImplementedException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.gffny.rgbycch.model.Team;
import com.gffny.rgbycch.service.TeamService;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Controller
public class TeamRestController extends V1RestController {

    @Autowired
    private TeamService teamService;

    public static final String[] ALLOWED_FIELDS;

    static {
	List<String> allowedFields = new ArrayList<String>();
	allowedFields.addAll(Arrays.asList(new String[] { "name",
		"teamMemberList" }));
	ALLOWED_FIELDS = allowedFields
		.toArray(new String[allowedFields.size()]);
    }

    /**
     * 
     * @param id
     * @return
     */
    @RequestMapping(value = "/team/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Team getPlayer(@PathVariable Integer id) {
	LOG.debug("get team with id {}", id);
	Team team = teamService.findById(id);
	return team;
    }

    /**
     * 
     * @param id
     * @param player
     * @return
     */
    @RequestMapping(value = "/team/{id}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Team setPlayer(@PathVariable Integer id, @RequestBody Team team) {
	LOG.debug("update team with id {}, name {}", id, team.name());
	throw new NotImplementedException();
    }
}
