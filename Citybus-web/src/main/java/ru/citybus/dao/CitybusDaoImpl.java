package ru.citybus.dao;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import ru.citybus.model.TimeTable;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * User: sedrakpc
 * Date: 7/23/14
 * Time: 9:53 PM
 */
public class CitybusDaoImpl {

    private DataSource dataSource;

    private JdbcTemplate jdbcTemplate;

    public void setDataSource(DataSource dataSource) {
        jdbcTemplate = new JdbcTemplate(dataSource);
    }

    public List<TimeTable> getTimeTable(String type, String name) {
        String sql = "select * from rt_time_table where route in (select id from rt_route where type = ? and name = ?)";
        return jdbcTemplate.query(sql, new TimeTableMapper(), type, name);
    }

    private class TimeTableMapper implements RowMapper<TimeTable>{

        @Override
        public TimeTable mapRow(ResultSet rs, int i) throws SQLException {
            TimeTable timeTable = new TimeTable();
            timeTable.setRoute(rs.getInt("route"));
            timeTable.setStop(rs.getInt("stop"));
            timeTable.setDates(rs.getString("dates"));
            timeTable.setHour(rs.getInt("hour"));
            timeTable.setMinute(rs.getInt("minute"));
            return timeTable;
        }
    }
}
