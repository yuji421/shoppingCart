package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet(name="CartServlet", urlPatterns={"/cart"})
public class CartServlet extends HttpServlet {

    @SuppressWarnings("unchecked")
    private Map<String,Integer> cart(HttpSession s) {
        Object obj = s.getAttribute("cart");
        if (obj == null) {
            Map<String,Integer> m = new LinkedHashMap<>();
            s.setAttribute("cart", m);
            return m;
        }
        return (Map<String,Integer>) obj;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        HttpSession session = req.getSession(true);
        Map<String,Integer> cart = cart(session);

        String action = req.getParameter("action");
        String id = req.getParameter("id");

        if ("add".equals(action) && id != null) {
            cart.put(id, cart.getOrDefault(id, 0) + 1);
        } else if ("remove".equals(action) && id != null && cart.containsKey(id)) {
            int q = cart.get(id) - 1;
            if (q <= 0) cart.remove(id); else cart.put(id, q);
        } else if ("clear".equals(action)) {
            cart.clear();
        }
        resp.sendRedirect(req.getContextPath() + "/");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.sendRedirect(req.getContextPath() + "/");
    }
}
