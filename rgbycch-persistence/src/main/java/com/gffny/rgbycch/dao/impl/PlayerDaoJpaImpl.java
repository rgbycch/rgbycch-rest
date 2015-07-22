/**
 * 
 */
package com.gffny.rgbycch.dao.impl;

import org.springframework.stereotype.Repository;

import com.gffny.rgbycch.dao.PlayerDao;
import com.gffny.rgbycch.model.Player;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Repository("playerDao")
public class PlayerDaoJpaImpl extends GenericDaoJpaImpl<Player, Integer>
	implements PlayerDao {

}
