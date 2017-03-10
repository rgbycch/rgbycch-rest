package com.gffny.rgbycch.rest.model;

/**
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
public class SquadMember {

    private String id;
    private String firstName;
    private String lastName;
    private String displayName;

    public SquadMember() {
        //default empty constructor for serialisation, etc
    }

    public SquadMember(String id, String firstName, String lastName) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }
}
