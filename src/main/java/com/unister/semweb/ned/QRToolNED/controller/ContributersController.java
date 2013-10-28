package com.unister.semweb.ned.QRToolNED.controller;

import java.io.Serializable;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.unister.semweb.ned.QRToolNED.datatypes.TextWithLabels;
import com.unister.semweb.ned.QRToolNED.db.DbAdapter;

@SuppressWarnings("serial")
@Controller
@Scope("session")
public class ContributersController implements Serializable {
    @Autowired
    private DbAdapter dbAdapter;

    @RequestMapping(method = RequestMethod.GET, value = "/contributers")
    public String login(Model model) throws Exception {
        // get session User name
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        TextWithLabels text = dbAdapter.getTextForUser(username);
        if (text == null) {
            String thanks = "No more texts to annotate!\n "
                    + "Thank you for your collaboration.";
            model.addAttribute("text", thanks);
        }
        return "/contributers";
    }
}
