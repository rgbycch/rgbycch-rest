/**
 * 
 */
package com.gffny.rgbycch.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gffny.rgbycch.dao.GenericDao;
import com.gffny.rgbycch.model.Player;
import com.gffny.rgbycch.service.PlayerService;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Service
public class PlayerServiceImpl implements PlayerService {

    @Autowired
    private GenericDao<Player, Integer> playerRepository;

    /*
     * (non-Javadoc)
     * 
     * @see com.gffny.rgbycch.service.EntityManagmentService#findById(java.io.
     * Serializable)
     */
    @Override
    public Player findById(Integer id) {
	return playerRepository.findById(id);
    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * com.gffny.rgbycch.service.EntityManagmentService#insert(com.gffny.rgbycch
     * .model.Player)
     */
    @Override
    public Player insert(Player player) {
	return playerRepository.persist(player);
    }
}
