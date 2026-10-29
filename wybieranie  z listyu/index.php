
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ryby wystepowanie</title>
</head>
<body>
    <form action="index.php" method="POST">

        <label for="wyst">Wybierz wystepowanie ryb</label>
        <select name="wyst" id="wyst">

        <?php
            //połączenie z bazą
            require_once "connect.php";

            $query1 = "SELECT DISTINCT ryby.wystepowanie FROM ryby";
            $exec1 = mysqli_query($connect, $query1);
            
            while ($result1 = mysqli_fetch_row($exec1)) 
            {
                echo "<option value='".$result1[0]."'>".$result1[0]."</option>";
            }

        ?>

        </select>
        <input type="submit" name="wybierz" value="wybierz wystepowanie">

        <?php

            if($_SERVER["REQUEST_METHOD"] === "POST"){
                $occur = $_POST["wyst"];

                $query2 = "SELECT * FROM ryby where ryby.wystepowanie = '$occur'";
                $exec2 = mysqli_query($connect, $query2);

                echo "<table border='1'><th>lp</th><th>nazwa ryby</th> <th>wystepowanie</th><th> styl zycia</th>";
                
                while( $result2 = mysqli_fetch_row($exec2))
                {
                    echo "<tr><td>".$result2[0]."</td><td>".$result2[1]."</td><td>".$result2[2]."</td><td>".$result2[3]."</td></tr></td>";   
                }

                echo "</table>";
            }

        ?>
    
    </form>
</body>
</html>