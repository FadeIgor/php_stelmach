<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PIEKARNIA</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <nav>
        <a href="1.png">KWERENDA 1</a>
        <a href="">KWERENDA 2</a>
        <a href="">KWERENDA 3</a>
        <a href="">KWERENDA 4</a>
    </nav>

    <header>
        <h1>WITAMY</h1>
        <h4>NA STRONIE PIEKARNI</h4>
        <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Cumque in quam sunt vel alias laudantium cupiditate. Magni nulla nisi corporis ipsa ab. Rem beatae quisquam error repudiandae asperiores architecto delectus.</p>
    </header>
    
    <main>
        <h4>Wypierz rodzaj wypieku:</h4>

        <form action="" method="POST">
            <select name="rodzaj" id="rodzaj">
                <?php
                    $connect = mysqli_connect('127.0.0.1','root','','piekarnia');
                    $query1 =  'SELECT DISTINCT wyroby.Rodzaj FROM wyroby';
                    $exec1   = mysqli_query($connect, $query1);

                    while ($result1 = mysqli_fetch_row($exec1)) {
                        echo "<option>".$result1[0]."</option>";
                    }

                ?>
            </select>
             </select>
        <input type="submit" name="wybierz" value="wybierz">

        <?php

            if($_SERVER["REQUEST_METHOD"] === "POST"){
                $occur = $_POST["rodzaj"];

                $query2 = "SELECT * FROM wyroby where wyroby.Rodzaj = '$occur'";
                $exec2 = mysqli_query($connect, $query2);

                echo "<table border='1'><th>rodzaj</th> <th>Nazwa</th><th>gramatura</th><th>Cena</th>";
                
                while( $result2 = mysqli_fetch_row($exec2))
                {
                    echo "<tr><td>".$result2[1]."</td><td>".$result2[2]."</td><td>".$result2[3]."</td><td>".$result2[4]."</td></tr></td>";   
                }

                echo "</table>";
            }

        ?>
        </form>



    </main>

    <footer>
        <p>autor: Igor Wickowski</p>
        <p>15.10.2026</p>
    </footer>
</body>
</html>