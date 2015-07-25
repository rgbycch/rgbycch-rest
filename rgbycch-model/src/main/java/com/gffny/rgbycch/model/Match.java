/**
 * 
 */
package com.gffny.rgbycch.model;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Entity
@Table(name = "t_match")
public class Match extends BaseEntity {

    private static final long serialVersionUID = 3347742352229388847L;
    private Competition competition;

    /*
     * (non-Javadoc)
     * 
     * @see com.gffny.rgbycch.model.BaseEntity#name()
     */
    @Override
    public String name() {
	// TODO Auto-generated method stub
	return null;
    }

    @Transient
    public Competition getCompetition() {
	return competition;
    }

    public void setCompetition(Competition competition) {
	this.competition = competition;
    }

}
