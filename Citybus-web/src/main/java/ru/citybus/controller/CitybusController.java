package ru.citybus.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import ru.citybus.dao.CitybusDaoImpl;
import ru.citybus.model.TimeTable;

import java.util.List;

/**
 * User: sedrakpc
 * Date: 7/23/14
 * Time: 2:47 PM
 */
@Controller
@RequestMapping("timetable")
public class CitybusController {

    @Autowired
    private CitybusDaoImpl citybusDao;

    @RequestMapping(value = "/route", headers="Accept=application/json", method=RequestMethod.GET)
    public @ResponseBody
    List<TimeTable> getTimeTable(@RequestParam("type") String type, @RequestParam("name") String name) {
        List<TimeTable> timeTableList = citybusDao.getTimeTable(type, name);
        return timeTableList;
    }
}
