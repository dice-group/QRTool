package com.unister.semweb.ned.QRToolNED.controller;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class UsersController {

    @Autowired
    @Qualifier("userService")
    private ExtendedUserDetailsManager userDetailsManager;

    @Autowired
    PasswordEncoder encoder;

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(method = RequestMethod.GET)
    public String admin(Model model) {
        model.addAttribute("user", new UserWrapper());
        List<UserWrapper> userList = userDetailsManager.listUsers();
        model.addAttribute("userList", userList);
        return "admin/users";
    }

    @PreAuthorize("hasRole('ROLE_ADMIN')")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String createUser(@ModelAttribute("user") UserWrapper userWrapper) {
        userWrapper.setPassword(encoder.encodePassword(userWrapper.getPassword(), null));
        Collection<GrantedAuthority> authorithies = new ArrayList<GrantedAuthority>(2);
        if (userWrapper.isAdmin()) {
            authorithies.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        }
        authorithies.add(new SimpleGrantedAuthority("ROLE_USER"));
        User user = new User(userWrapper.getUserName(), userWrapper.getPassword(), true, true, true, true, authorithies);
        userDetailsManager.createUser(user);
        return "admin/users";
    }

}
