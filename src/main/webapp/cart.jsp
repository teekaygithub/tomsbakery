<jsp:useBean id="cart" scope="session" class="com.tkato.tkbakery.Cart" />

<jsp:setProperty name="cart" property="*" />

<%
cart.process();
%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Your Shopping Cart</title>
    </head>
    <body>
        <div id="topbar" style="width:100%;height:100px;">
            <a href="index.html" style="float:left">Back to Home</a>
        </div>
        <%
            String [] items = cart.getItems();
            if (items.length == 0) {
        %>
        <p>Your cart is empty</p>
        <a href="index.html">See Our Menu!</a>
        <% } else { %>
        <div>
            <p>Your shopping cart</p>
            <form method="post">
                <table>
                    <tr>
                        <th>Item Name</th>
                        <th></th>
                    </tr>
                    <%for (String item: items) {%>
                    <tr>
                        <td><%= item %></td>
                        <td>
                            <input type="text" name="item" value=<%= item%> style="display:none" />
                            <input type="submit" name="submit" value="remove" />
                        </td>
                    </tr>
                    <% } %>
                </table>
            </form>
        </div>
        <div id="purchase-window">
            <form method="GET" action="order">
                <label>Complete your order:</label>
                <%for (String item: items) { %>
                <input type="hidden" name="items" value="<%= item%>" />
                <% } %>
                <input type="submit" value="Complete My Order"/>
            </form>
        </div>
        <% } %>
    </body>
</html>