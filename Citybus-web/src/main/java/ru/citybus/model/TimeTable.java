package ru.citybus.model;

/**
 * User: sedrakpc
 * Date: 7/23/14
 * Time: 3:02 PM
 */
public class TimeTable {
    private int route;
    private int stop;
    private String dates;
    private int hour;
    private int minute;

    public int getRoute() {
        return route;
    }

    public void setRoute(int route) {
        this.route = route;
    }

    public int getStop() {
        return stop;
    }

    public void setStop(int stop) {
        this.stop = stop;
    }

    public String getDates() {
        return dates;
    }

    public void setDates(String dates) {
        this.dates = dates;
    }

    public int getHour() {
        return hour;
    }

    public void setHour(int hour) {
        this.hour = hour;
    }

    public int getMinute() {
        return minute;
    }

    public void setMinute(int minute) {
        this.minute = minute;
    }
}
