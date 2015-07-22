/**
 * 
 */
package com.gffny.rgbycch.dao.impl;

import org.springframework.stereotype.Repository;

import com.gffny.rgbycch.dao.TeamDao;
import com.gffny.rgbycch.model.Team;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Repository("teamDao")
public class TeamDaoJpaImpl extends GenericDaoJpaImpl<Team, Integer> implements
	TeamDao {

}
