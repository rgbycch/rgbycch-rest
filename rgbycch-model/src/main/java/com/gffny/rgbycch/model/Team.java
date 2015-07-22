/**
 * 
 */
package com.gffny.rgbycch.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@Entity
@Table(name = "t_team")
public class Team extends BaseEntity {

    private static final long serialVersionUID = -5461181250703403428L;
    private List<Player> teamMemberList;

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable(name = "t_team_member", joinColumns = { @JoinColumn(name = "pk") }, inverseJoinColumns = { @JoinColumn(name = "tm_fk") })
    public List<Player> getTeamMemberList() {
	return teamMemberList;
    }

    public void setTeamMemberList(List<Player> teamMemberList) {
	this.teamMemberList = teamMemberList;
    }

    @Override
    public String name() {
	// TODO Auto-generated method stub
	return null;
    }
}
