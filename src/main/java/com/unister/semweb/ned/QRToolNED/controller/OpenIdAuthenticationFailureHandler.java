package com.unister.semweb.ned.QRToolNED.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.openid.OpenIDAuthenticationStatus;
import org.springframework.security.openid.OpenIDAuthenticationToken;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

public class OpenIdAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {


    private ExtendedUserDetailsManager usersDetailsManager;

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {
        if (openIdAuthenticationSuccesfullButUserIsNotRegistered(exception)) {
            redirectToSuccess(request, response, exception);
        } else {
            super.onAuthenticationFailure(request, response, exception);
        }
    }

    private void redirectToSuccess(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {
        DefaultRedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
        OpenIDAuthenticationToken openIDAuthentication = getOpenIdAuthenticationToken(exception);
        addOpenIdAttributesToSession(request, openIDAuthentication);
        SecurityContext securityContext = SecurityContextHolder.getContext();
        securityContext.setAuthentication(openIDAuthentication);
        HttpSession session = request.getSession(true);
        session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
        redirectStrategy.sendRedirect(request, response, "/");
    }

    private void addOpenIdAttributesToSession(HttpServletRequest request,
            OpenIDAuthenticationToken openIdAuthenticationToken) throws ServletException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            throw new ServletException("No session found");
        }
        Collection<GrantedAuthority> authorithies = new ArrayList<GrantedAuthority>(2);
        authorithies.add(new SimpleGrantedAuthority("ROLE_USER"));
        User user = new User(openIdAuthenticationToken.getIdentityUrl(), "Unused", true, true, true, true, authorithies);
        usersDetailsManager.createUser(user);
    }

    private boolean openIdAuthenticationSuccesfullButUserIsNotRegistered(AuthenticationException exception) {
        return exception instanceof UsernameNotFoundException
                && exception.getAuthentication() instanceof OpenIDAuthenticationToken
                && OpenIDAuthenticationStatus.SUCCESS.equals((getOpenIdAuthenticationToken(exception)).getStatus());
    }

    private OpenIDAuthenticationToken getOpenIdAuthenticationToken(AuthenticationException exception) {
        return ((OpenIDAuthenticationToken) exception.getAuthentication());
    }

    public ExtendedUserDetailsManager getUsersDetailsManager() {
        return usersDetailsManager;
    }

    public void setUsersDetailsManager(ExtendedUserDetailsManager usersDetailsManager) {
        this.usersDetailsManager = usersDetailsManager;
    }


}
