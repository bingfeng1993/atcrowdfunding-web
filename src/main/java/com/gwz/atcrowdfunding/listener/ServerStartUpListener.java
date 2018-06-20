package com.gwz.atcrowdfunding.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * 服务器启动监听器
 * @author DELL
 *
 */
public class ServerStartUpListener implements ServletContextListener {

	public void contextInitialized(ServletContextEvent sce) {
		// 获取web的应用对象
		ServletContext application = sce.getServletContext();
		
		// 获取web的应用路径
		String path = application.getContextPath();
		
		// 将路径保存到application范围中
		application.setAttribute("APP_PATH", path);
	}

	public void contextDestroyed(ServletContextEvent sce) {

	}

}
