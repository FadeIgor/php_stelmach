
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Miasta z listy</title>
</head>
<body>
    <form action="index.php" method="POST">

        <label for="wyst">Wybierz miasta</label>
        <input type="text" name="miasta" id="miasta">
        <input type="submit" name="wybierz" value="wybierz miasto">

        <?php
            require_once "connect.php";

            if($_SERVER["REQUEST_METHOD"] === "POST"){
                $occur = $_POST["miasta"];

                $query2 = "SELECT klienci.id_klienta, klienci.imie_klienta, klienci.nazwisko_klienta, klienci.miasto_klienta, klienci.telefon_klienta, klienci.email_klienta FROM klienci where klienci.miasto_klienta = '$occur'";
                $exec2 = mysqli_query($connect, $query2);

                echo "<table border='1'><th>lp</th><th>imie</th><th>nazwisko</th><th> miasto</th><th>nr telefonu</th><th>email</th>";
                
                while( $result2 = mysqli_fetch_row($exec2))
                {
                    echo "<tr><td>".$result2[0]."</td><td>".$result2[1]."</td><td>".$result2[2]."</td><td>".$result2[3]."</td><td>".$result2[4]."</td><td>".$result2[5]."</td></tr></td>";   
                }

                echo "</table>";
            }

        ?>
    
    </form>
</body>
</html>