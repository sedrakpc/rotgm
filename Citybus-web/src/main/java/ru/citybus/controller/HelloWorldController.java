package ru.citybus.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import ru.citybus.model.TimeTable;

/**
 * User: sedrakpc
 * Date: 7/23/14
 * Time: 2:47 PM
 */
@Controller
@RequestMapping("timetable")
public class HelloWorldController {

    @RequestMapping(value = "/route", headers="Accept=application/json", method=RequestMethod.GET)
    public @ResponseBody
    TimeTable hello() {
        TimeTable tt = new TimeTable();
        tt.setDates("1100110");
        tt.setHour(5);
        tt.setMinute(21);
        return tt;
    }
}
