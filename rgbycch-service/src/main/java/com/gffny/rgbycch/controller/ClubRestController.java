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

import com.gffny.rgbycch.model.Club;
import com.gffny.rgbycch.service.ClubService;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Controller
@Api(value = "")
public class ClubRestController extends V1RestController {

    @Autowired
    private ClubService clubService;

    /**
     * 
     * @param id
     * @return
     */
    @ApiOperation(value = "get club by id", notes = "get a club by id", httpMethod = "GET", response = Club.class)
    @RequestMapping(value = "/club/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(value = HttpStatus.OK)
    public @ResponseBody Club getClub(@PathVariable Integer id) {
	LOG.debug("get club with id {}", id);
	return clubService.findById(id);
    }

    /**
     * 
     * @param id
     * @param club
     * @return
     */
    @ApiOperation(value = "set club by id", notes = "set a club by id", httpMethod = "POST", response = Club.class)
    @RequestMapping(value = "/club/{id}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseStatus(value = HttpStatus.OK)
    public @ResponseBody Club setClub(@PathVariable String id,
	    @RequestBody Club club) {
	LOG.debug("update club with id {}", id);
	// clubService.persist
	return club;
    }
}
