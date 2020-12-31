<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
        <link rel="stylesheet" href="resources/css/style.css" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Turtle Bread</title>
    </head>
    <body>
        <div id="navigation-bar">
            <nav class="navbar navbar-expand-sm" >
                <a class="navbar-brand" href="index.html" >
                    Bakery Logo (back to home)
                </a>
            </nav>
        </div>
        <div class="row" id="container">
            <div class="col-6" id="image">
                <a href="">
                    <img class="img-thumbnail img-fluid" src="images/turtle.jpg" alt="Turtle-Shaped Bread"/>
                </a>
            </div>
            <div class="col-6" id="description">
                <p style="font-size: 32px">Simple but a tasty classic that will surely make a great lunch!</p>
                <p> Maximum of 5 breads per order.</p>
                <form action="cart" method="post">
                    <p>
                        <!-- <label>Quantity</label> -->
                        <!-- <input type="number" id="quantity" min="1" max="5" name="quantity"></input> -->
                        <input type="text" name="item" value="turtlebread" style="display:none" />
                    </p>
                    <p>
                        <input type="submit" name="submit" value="add" />
                    </p>
                </form>
            </div>
        </div>        
    </body>
</html>