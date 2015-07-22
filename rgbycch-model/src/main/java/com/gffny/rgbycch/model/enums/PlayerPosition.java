/**
 * 
 */
package com.gffny.rgbycch.model.enums;

import com.fasterxml.jackson.annotation.JsonValue;

/**
 * @author John D. Gaffney | gffny.com
 *
 */
public enum PlayerPosition {

    PP10(10);

    private int positionNumber;

    /**
     * 
     * @param positionNumber
     */
    PlayerPosition(int positionNumber) {
	this.positionNumber = positionNumber;
    }

    /**
     * 
     */
    @JsonValue
    @Override
    public String toString() {
	return "rgbycch.model.playerposition.".concat(name().toLowerCase());
    }

    /**
     * 
     * @return
     */
    public int getPositionNumber() {
	return positionNumber;
    }

    /**
     * 
     * @param positionNumber
     */
    public void setPositionNumber(int positionNumber) {
	this.positionNumber = positionNumber;
    }
}
