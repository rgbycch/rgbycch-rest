package com.gffny.rgbycch.rest.model;

/**
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
public class TeamMember extends SquadMember {

    // TODO refactor this concept as { player, position, isCaptain, isViceCaptain }

    public TeamMember() {
        // default zero-arg constructor
    }

    public TeamMember(final String id, final String firstName, final String lastName) {
        super(id, firstName, lastName);
    }
}
