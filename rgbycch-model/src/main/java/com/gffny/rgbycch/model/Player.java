/**
 * 
 */
package com.gffny.rgbycch.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.gffny.rgbycch.model.enums.PlayerPosition;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
@JsonAutoDetect
@Entity
@Table(name = "t_player")
public class Player extends BaseEntity {

    private static final long serialVersionUID = -3512742281975570114L;
    private String firstName;
    private String lastName;
    private String nickName;
    private PlayerPosition primaryPosition;
    private PlayerPosition secondaryPosition;
    private PlayerPosition tertiaryPosition;
    private List<Team> teamList;

    @Size(max = 60)
    @NotBlank
    @Column(name = "frst_nm")
    public String getFirstName() {
	return firstName;
    }

    public void setFirstName(String firstName) {
	this.firstName = firstName;
    }

    @Size(max = 60)
    @NotBlank
    @Column(name = "lst_nm")
    public String getLastName() {
	return lastName;
    }

    public void setLastName(String lastName) {
	this.lastName = lastName;
    }

    @Size(max = 60)
    @NotBlank
    @Column(name = "nck_nm")
    public String getNickName() {
	return nickName;
    }

    public void setNickName(String nickName) {
	this.nickName = nickName;
    }

    @Enumerated(EnumType.STRING)
    @NotNull
    @Column(name = "prmry_pstn")
    public PlayerPosition getPrimaryPosition() {
	return this.primaryPosition;
    }

    public void setPrimaryPosition(PlayerPosition primaryPosition) {
	this.primaryPosition = primaryPosition;
    }

    @Enumerated(EnumType.STRING)
    @Column(name = "scndry_pstn")
    public PlayerPosition getSecondaryPosition() {
	return secondaryPosition;
    }

    public void setSecondaryPosition(PlayerPosition secondaryPosition) {
	this.secondaryPosition = secondaryPosition;
    }

    @Enumerated(EnumType.STRING)
    @Column(name = "trtry_pstn")
    public PlayerPosition getTertiaryPosition() {
	return tertiaryPosition;
    }

    public void setTertiaryPosition(PlayerPosition tertiaryPosition) {
	this.tertiaryPosition = tertiaryPosition;
    }

    @ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinTable(name = "t_team_member", joinColumns = { @JoinColumn(name = "pk") }, inverseJoinColumns = { @JoinColumn(name = "plyr_fk") })
    public List<Team> getTeamList() {
	return teamList;
    }

    public void setTeamList(List<Team> teamList) {
	this.teamList = teamList;
    }

    @Transient
    @Override
    public String name() {
	return getFirstName() + " " + getLastName();
    }
}
