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

import com.gffny.rgbycch.model.Player;
import com.gffny.rgbycch.service.PlayerService;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Controller
public class PlayerRestController extends V1RestController {

    @Autowired
    private PlayerService playerService;

    public static final String[] ALLOWED_FIELDS;

    static {
	List<String> allowedFields = new ArrayList<String>();
	allowedFields.addAll(Arrays.asList(new String[] { "firstName",
		"lastName", "nickName", "primaryPosition", "secondaryPosition",
		"tertiaryPosition" }));
	ALLOWED_FIELDS = allowedFields
		.toArray(new String[allowedFields.size()]);
    }

    /**
     * 
     * @param id
     * @return
     */
    @RequestMapping(value = "/player/{id}", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Player getPlayer(@PathVariable Integer id) {
	LOG.debug("get player with id {}", id);
	Player player = playerService.findById(id);
	return player;
    }

    /**
     * 
     * @param id
     * @param player
     * @return
     */
    @RequestMapping(value = "/player/{id}", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    @ResponseStatus(value = HttpStatus.OK)
    public Player setPlayer(@PathVariable Integer id, @RequestBody Player player) {
	LOG.debug("update player with id {}, firstName {}, surname {}", id,
		player.getFirstName(), player.getLastName());
	throw new NotImplementedException();
    }
}
