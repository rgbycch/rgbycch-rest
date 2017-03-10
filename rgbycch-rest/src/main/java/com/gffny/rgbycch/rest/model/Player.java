package com.gffny.rgbycch.rest.model;

import com.gffny.rgbycch.rest.model.enums.PositionEnum;

import java.util.List;

/**
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
public abstract class Player {

    private String id;
    private String firstName;
    private String lastName;
    private String displayName;
    private PositionEnum primaryPosition;
    private PositionEnum secondaryPosition;
    private List<PositionEnum> alternatePositions;

    public Player() {
        // zero-arg constructor
    }

    public Player(String id, String firstName, String lastName) {
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

    public PositionEnum getPrimaryPosition() {
        return primaryPosition;
    }

    public void setPrimaryPosition(PositionEnum primaryPosition) {
        this.primaryPosition = primaryPosition;
    }

    public PositionEnum getSecondaryPosition() {
        return secondaryPosition;
    }

    public void setSecondaryPosition(PositionEnum secondaryPosition) {
        this.secondaryPosition = secondaryPosition;
    }

    public List<PositionEnum> getAlternatePositions() {
        return alternatePositions;
    }

    public void setAlternatePositions(List<PositionEnum> alternatePositions) {
        this.alternatePositions = alternatePositions;
    }
}
