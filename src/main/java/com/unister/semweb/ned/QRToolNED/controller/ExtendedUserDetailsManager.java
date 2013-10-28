package com.unister.semweb.ned.QRToolNED.controller;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.security.provisioning.JdbcUserDetailsManager;

public class ExtendedUserDetailsManager extends JdbcUserDetailsManager {

    public static final String LIST_ALL_USERS_SQL = "Select users.username, users.enabled, authorities.authority from users LEFT JOIN authorities ON users.username=authorities.username order by username;";

    public List<UserWrapper> listUsers() {
        List<UserWrapper> results = getJdbcTemplate().query(LIST_ALL_USERS_SQL,
                new ResultSetExtractor<List<UserWrapper>>() {

                    @Override
                    public List<UserWrapper> extractData(ResultSet rs) throws SQLException, DataAccessException {
                        ArrayList<UserWrapper> list = new ArrayList<UserWrapper>();
                        String precedentUsername = "";
                        UserWrapper wrapper;
                        while (rs.next()) {
                            if (rs.getString(1).equals(precedentUsername)) {
                                if (rs.getString(3).equals("ROLE_ADMIN")) {
                                    list.get(list.size() - 1).setAdmin(true);
                                }
                            } else {
                                wrapper = new UserWrapper();
                                wrapper.setEnabled(rs.getBoolean(2));
                                wrapper.setUserName(rs.getString(1));
                                if (rs.getString(3).equals("ROLE_ADMIN")) {
                                    wrapper.setAdmin(true);
                                }
                                list.add(wrapper);
                                precedentUsername = wrapper.getUserName();
                            }
                        }
                        return list;
                    }

                });

        return results;
    }
}
