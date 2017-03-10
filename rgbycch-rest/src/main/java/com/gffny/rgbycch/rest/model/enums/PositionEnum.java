package com.gffny.rgbycch.rest.model.enums;

/**
 * Created by John D. Gaffney | Isobar US
 * 3/9/17
 */
public enum PositionEnum {

    FULLBACK("com.gffny.rgbycch.tightheadprop"),
    RIGHTWING("com.gffny.rgbycch.tightheadprop"),
    SECONDCENTRE("com.gffny.rgbycch.tightheadprop"),
    FIRSTCENTRE("com.gffny.rgbycch.tightheadprop"),
    LEFTWING("com.gffny.rgbycch.tightheadprop"),
    FLYHALF("com.gffny.rgbycch.tightheadprop"),
    SCRUMHALF("com.gffny.rgbycch.tightheadprop"),
    LOOSEHEADPROP("com.gffny.rgbycch.tightheadprop"),
    HOOKER("com.gffny.rgbycch.tightheadprop"),
    TIGHTHEADPROP("com.gffny.rgbycch.tightheadprop"),
    SECONDROW("com.gffny.rgbycch.tightheadprop"),
    BLINDSIDEFLANKER("com.gffny.rgbycch.tightheadprop"),
    OPENSIDEFLANKER("com.gffny.rgbycch.tightheadprop"),
    NUMBEREIGHT("com.gffny.rgbycch.tightheadprop");

    private String key;

    // TODO breakdown more position lists as needed
    private static final PositionEnum[] FORWARDS = { TIGHTHEADPROP, LOOSEHEADPROP, HOOKER, SECONDROW, BLINDSIDEFLANKER, OPENSIDEFLANKER, NUMBEREIGHT };
    private static final PositionEnum[] BACKS = { SCRUMHALF, FLYHALF, LEFTWING, FIRSTCENTRE, SECONDCENTRE, RIGHTWING, FULLBACK };

    PositionEnum(String key) {
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
