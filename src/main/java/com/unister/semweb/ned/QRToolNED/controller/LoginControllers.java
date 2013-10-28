package com.unister.semweb.ned.QRToolNED.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@SuppressWarnings("serial")
@Controller
@Scope("session")
public class LoginControllers {
    @RequestMapping(method = RequestMethod.GET, value = "/loginpage")
    public String login(Model model) throws Exception {
        return "/loginpage";
    }
}
