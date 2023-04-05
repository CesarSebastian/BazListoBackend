package org.pedidos.unixtime;

public class unixTime {
    public long unixTimeGet(){
        long y = System.currentTimeMillis();
        return '"'+y+'"';
    }
}
