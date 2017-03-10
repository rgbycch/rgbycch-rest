package com.gffny.rgbycch.rest.model;

/**
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
public class SquadMember extends Player {

    public SquadMember() {
        //default empty constructor for serialisation, etc
    }

    public SquadMember(String id, String firstName, String lastName) {
        super(id, firstName, lastName);
    }

}
