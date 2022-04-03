package com.tkato.tkbakery.security;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    
    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .csrf().disable()
            .authorizeRequests()
            // .antMatchers("/", "index", "/css/*", "/js/*", "/images/*").permitAll()
            // .antMatchers("/api/**").permitAll() // temporary, for development purposes
            // .antMatchers("/users/**").permitAll() // temporary, for development purposes
            // .anyRequest().authenticated();
            .anyRequest().permitAll();
        // http.oauth2Login();
        // http.oauth2Client();
    }
}
