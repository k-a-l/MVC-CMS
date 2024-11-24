package com.clinic.util;

import java.util.Timer;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class TimerSetupListener implements ServletContextListener {
    private Timer timer;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        timer = new Timer(true);
        timer.scheduleAtFixedRate(new ExpireCheckTask(), 0, 24 * 60 * 60 * 1000); // Schedule task to run daily
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (timer != null) {
            timer.cancel();
        }
    }
}
