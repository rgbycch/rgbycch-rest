package com.gffny.rgbycch.rest.model;

import java.util.Date;

/**
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
public class Match {

    private String opposition;
    private Date eventTime;
    private String referee;
    private String location;
    private Team team;

    public String getOpposition() {
        return opposition;
    }

    public void setOpposition(String opposition) {
        this.opposition = opposition;
    }

    public Date getEventTime() {
        return eventTime;
    }

    public void setEventTime(Date eventTime) {
        this.eventTime = eventTime;
    }

    public String getReferee() {
        return referee;
    }

    public void setReferee(String referee) {
        this.referee = referee;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}
