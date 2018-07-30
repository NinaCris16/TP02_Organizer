package br.cefetmg.inf.organizer.controller;

import br.cefetmg.inf.organizer.model.domain.User;
import br.cefetmg.inf.organizer.model.service.IKeepUser;
import br.cefetmg.inf.organizer.model.service.impl.KeepUser;
import br.cefetmg.inf.util.PasswordCriptography;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class DeleteUser implements GenericProcess {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
        String pageJSP = "";
        
        String password = PasswordCriptography.generateMd5(req.getParameter("password"));
        
        User user = (User) req.getSession().getAttribute("user");
        
        if(!(password.equals(user.getUserPassword()))){
            //erro, tratar depois
        }else{
            IKeepUser keepUser = new KeepUser();
            boolean success = keepUser.deleteAccount(user);
            if(!success){
                //erro
            }else{
                HttpSession session = req.getSession();
                session.invalidate();
                pageJSP = "/login.jsp";
            }
        }
        
        return pageJSP;
    }
    
}
