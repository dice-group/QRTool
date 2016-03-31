package com.unister.semweb.ned.QRToolNED.db;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.unister.semweb.ned.QRToolNED.datatypes.Candidate;

public class CandidateRowMapper implements RowMapper<Candidate> {

    @Override
    public Candidate mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new Candidate(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4));
    }

}
