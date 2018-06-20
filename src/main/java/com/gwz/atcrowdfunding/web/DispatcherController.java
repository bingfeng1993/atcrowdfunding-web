package com.gwz.atcrowdfunding.web;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gwz.atcrowdfunding.service.UserService;
import com.gwz.atcrowfunding.bean.AjaxResult;
import com.gwz.atcrowfunding.bean.Permission;
import com.gwz.atcrowfunding.bean.User;
import com.gwz.atcrowfunding.util.MD5Util;
import com.gwz.atcrowfunding.util.StringUtil;

@Controller
public class DispatcherController {

	@Autowired
	private UserService userService;

	@RequestMapping(value = { "", "/", "/index", "/index/" })
	public String index() {
		return "index";
	}

	@RequestMapping("/login")
	public String login() {
		return "login";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}
	
	@ResponseBody
	@RequestMapping("/checkLogin")
	public Object checkLogin(User user,HttpSession session) {
		AjaxResult result = new AjaxResult();

		user.setUserpswd(MD5Util.digest(user.getUserpswd()));
		User dbUser = userService.queryUser4Login(user);
		if (dbUser == null) {
			result.setSuccess(false);
		} else {
			result.setSuccess(true);
			
			//查询当前登录用户的权限菜单
			List<Permission> permissions = 
					userService.queryPermissionsByUser(dbUser);
			//整合权限菜单
			Map<Integer ,Permission> permissionMap = new HashMap<Integer, Permission>();
			//userAuthUrlSet：表示自己的授权列表
			Set<String> userAuthUrlSet = new HashSet<String>();
			for (Permission permission : permissions) {
				if(!StringUtil.isEmpty(permission.getUrl())) {
					userAuthUrlSet.add(permission.getUrl());
				}
				permissionMap.put(permission.getId(), permission);
			}
			Permission root = null;
			for (Permission permission : permissions) {
				Permission child = permission;
				if(child.getPid() == 0) {
					root = permission;
				}else {
					Permission parent = permissionMap.get(child.getPid());
					parent.getChildren().add(child);
				}
			}
			session.setAttribute("userAuthUrlSet", userAuthUrlSet);
			session.setAttribute("rootPermission", root);
			session.setAttribute("user", dbUser);
		}
		return result;
	}

	@RequestMapping("/dologin")
	public String doLogin(User user, Model model) {
		// 1、获取表单中传递的参数
		// 2、调用服务接口，查询数据
		user.setUserpswd(MD5Util.digest(user.getUserpswd()));
		User dbUser = userService.queryUser4Login(user);
		// 3、根据返回值判断是否登陆成功
		if (dbUser == null) {
			// 4.2、登陆失败，跳转到登录页面，提示错误信息
			String errorMsg = "登陆账号或密码不正确，请重新输入";
			model.addAttribute("errorMsg", errorMsg);
			return "redirect:/login";
		} else {
			// 4.1、登陆成功，跳转到后台的主页面
			return "main";
		}
	}

	@RequestMapping("/main")
	public String main() {
		return "main";
	}
	
	@RequestMapping("/error")
	public String error() {
		return "error";
	}

	@RequestMapping("/reg")
	public String reg() {
		return "reg";
	}

	// @RequestMapping("/member")
	// public String member() {
	// return "member";
	// }

	@RequestMapping("/checkRegist")
	public String doreg(User user, Model model) {
		// 1、获取表单中传递的参数
		// 2.1判断登录账号是否存在，存在，注册失败
		if (user.getLoginacct() == null) {

			// 2.2不存在，调用服务接口，插入数据
			userService.save(user);
			return "redirect:/login";
		}else {
			String errorMsg = "登陆账号已存在，请重新输入"; 
			model.addAttribute("errorMsg",errorMsg);
			return "reg";
		}
	}
}
