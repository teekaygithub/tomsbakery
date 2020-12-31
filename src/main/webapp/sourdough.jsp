<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
        <link rel="stylesheet" href="resources/css/style.css" />
        <link rel="stylesheet" href="resources/css/sourdough.css" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Sourdough Bread</title>
    </head>
    <body>
        <div id="navigation-bar">
            <nav class="navbar navbar-expand-sm" >
                <a class="navbar-brand" href="index.html" >
                    Bakery Logo (back to home)
                </a>
            </nav>
        </div>
        <div class="row">
            <div class="col-6">
                <a href="">
                    <img class="img-thumbnail img-fluid" src="images/sourdough.jpg" alt="Sourdough Bread"/>
                </a>
            </div>
            <div class="col-6">
                <p style="font-size: 32px">Simple but a tasty classic that will surely make a great lunch!</p>
                <p> Maximum of 5 breads per order.</p>
                <form action="cart" method="post">
                    <p>
                        <!-- <label>Quantity</label> -->
                        <!-- <input type="number" id="quantity" min="1" max="5" name="quantity"></input> -->
                        <input type="text" name="item" value="sourdough" style="display:none" />
                    </p>
                    <p>
                        <input type="submit" name="submit" value="add" />
                    </p>
                </form>
            </div>
        </div>        
    </body>
</html>