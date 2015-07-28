/**
 * 
 */
package com.gffny.rgbycch.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

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

import com.gffny.rgbycch.model.Match;
import com.gffny.rgbycch.service.MatchService;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Controller
@Api(value = "Match Rest Controller", tags = { "getBy", "setBy" })
public class MatchRestController extends V1RestController {

    @Autowired
    private MatchService matchService;

    /**
     * 
     * @param id
     * @return
     */
    @ApiOperation(value = "get match by id", notes = "get a team by id", httpMethod = "GET", response = Match.class)
    @RequestMapping(value = "/match/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(value = HttpStatus.OK)
    public @ResponseBody Match getMatch(@PathVariable Integer id) {
	LOG.debug("get club with id {}", id);
	return matchService.findById(id);
    }

    /**
     * 
     * @param id
     * @param club
     * @return
     */
    @ApiOperation(value = "set match by id", notes = "get a team by id", httpMethod = "POST", response = Match.class)
    @RequestMapping(value = "/match/{id}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(value = HttpStatus.OK)
    public @ResponseBody Match setMatch(@PathVariable String id,
	    @RequestBody Match match) {
	LOG.debug("update club with id {}", id);
	return match;
    }
}
