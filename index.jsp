<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*,jakarta.servlet.http.*" %>
<%
    HttpSession s = request.getSession(true);
    Map<String,Integer> cart = (Map<String,Integer>) s.getAttribute("cart");
    if (cart == null) { cart = new LinkedHashMap<>(); s.setAttribute("cart", cart); }

    class Item { String id,name; int price; Item(String i,String n,int p){id=i;name=n;price=p;} }
    Map<String,Item> products = new LinkedHashMap<>();
    products.put("coffee", new Item("coffee","コーヒー",300));
    products.put("tea",    new Item("tea","紅茶",250));
    products.put("muffin", new Item("muffin","マフィン",200));
%>
<!doctype html>
<html>
<head><meta charset="UTF-8"><title>超シンプルカート</title></head>
<body>
<h1>商品一覧</h1>
<ul>
<% for (Item it : products.values()) { %>
  <li>
    <%= it.name %> - <%= it.price %> 円
    <form action="<%= request.getContextPath() %>/cart" method="post" style="display:inline">
      <input type="hidden" name="action" value="add">
      <input type="hidden" name="id" value="<%= it.id %>">
      <button type="submit">カートに追加</button>
    </form>
  </li>
<% } %>
</ul>

<hr>
<h2>カート</h2>
<%
  int total = 0;
  if (cart.isEmpty()) {
%>
  <p>カートは空です。</p>
<%
  } else {
%>
  <table border="1" cellpadding="6">
    <tr><th>商品</th><th>数量</th><th>小計</th><th></th></tr>
<%
    for (Map.Entry<String,Integer> e : cart.entrySet()) {
        Item it = products.get(e.getKey());
        int qty = e.getValue();
        int sub = it.price * qty;
        total += sub;
%>
    <tr>
      <td><%= it.name %></td>
      <td><%= qty %></td>
      <td><%= sub %> 円</td>
      <td>
        <form action="<%= request.getContextPath() %>/cart" method="post" style="display:inline">
          <input type="hidden" name="action" value="remove">
          <input type="hidden" name="id" value="<%= it.id %>">
          <button type="submit">−1</button>
        </form>
      </td>
    </tr>
<% } %>
    <tr><th colspan="2" style="text-align:right">合計</th><th><%= total %> 円</th><th></th></tr>
  </table>
  <form action="<%= request.getContextPath() %>/cart" method="post">
    <input type="hidden" name="action" value="clear">
    <button type="submit">カートを空にする</button>
  </form>
<% } %>
</body>
</html>
