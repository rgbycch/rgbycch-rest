/**
 * 
 */
package com.gffny.rgbycch.dao.impl;

import org.springframework.stereotype.Repository;

import com.gffny.rgbycch.dao.MatchDao;
import com.gffny.rgbycch.model.Match;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Repository("matchDao")
public class MatchDaoJpaImpl extends GenericDaoJpaImpl<Match, Integer>
	implements MatchDao {

}