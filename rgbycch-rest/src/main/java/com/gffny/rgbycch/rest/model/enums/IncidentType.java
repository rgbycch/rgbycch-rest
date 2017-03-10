package com.gffny.rgbycch.rest.model.enums;

/**
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
public enum IncidentType {

    // fouls
    PENALTY("com.gffny.rgbycch.penalty"),
    FOUL("com.gffny.rgbycch.foul"),

    // gameplay
    SCRUM("com.gffny.rgbycch.scrum"),
    KICKOFF("com.gffny.rgbycch.kickoff"),
    LINEOUT("com.gffny.rgbycch.lineout"),
    SCORE("com.gffny.rgbycch.score"),

    // match
    INJURY("com.gffny.rgbycch.injury"),
    SUBSTITUTION("com.gffny.rgbycch.substitution"),
    MATCHSTART("com.gffny.rgbycch.matchstart"),
    HALFSTART("com.gffny.rgbycch.halfstart"),
    MATCHEND("com.gffny.rgbycch.matchend"),
    HALFEND("com.gffny.rgbycch.halfend");

    private String key;

    IncidentType(String key) {
        this.key = key;
    }

    /**
     * Key used for localisation of position names
     * @return
     */
    public String getKey() {
        return this.key;
    }

}
