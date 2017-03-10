package com.gffny.rgbycch.rest.model.incident;

import com.gffny.rgbycch.rest.model.OppositionPlayer;
import com.gffny.rgbycch.rest.model.TeamMember;
import com.gffny.rgbycch.rest.model.enums.IncidentType;

import java.util.Date;

/**
 * Specifically refers to actions that have the player as a subject (score, foul, error)
 *
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
public class PlayerIncident extends Incident {

    private Date eventTime;
    // since every PlayerIncident has to happen in the confines of a match, use TeamMember
    private TeamMember subject;
    private IncidentType type;
    private String description;
    private OppositionPlayer oppositionPlayer;

    public Date getEventTime() {
        return eventTime;
    }

    public void setEventTime(Date eventTime) {
        this.eventTime = eventTime;
    }

    public TeamMember getSubject() {
        return subject;
    }

    public void setSubject(TeamMember subject) {
        this.subject = subject;
    }

    public IncidentType getType() {
        return type;
    }

    public void setType(IncidentType type) {
        this.type = type;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public OppositionPlayer getOppositionPlayer() {
        return oppositionPlayer;
    }

    public void setOppositionPlayer(OppositionPlayer oppositionPlayer) {
        this.oppositionPlayer = oppositionPlayer;
    }
}
