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

    PP1(1), PP2(2), PP3(3), PP4(4), PP5(5), PP6(6), PP7(7), PP8(8), PP9(9), PP10(
	    10), PP11(11), PP12(12), PP13(13), PP14(14), PP15(15);

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
