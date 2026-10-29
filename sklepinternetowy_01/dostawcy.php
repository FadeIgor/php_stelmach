<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <form action="" method="POST">

        <label for="dostawcy">Wybierz dostawce</label>
        <select name="dostawcy" id="dostawcy">

        <?php
            // połączenie z bazą
            require_once "connect.php";

            $query11 = "SELECT DISTINCT dostawcy.NazwaDostawcy FROM dostawcy";
            $exec11 = mysqli_query($connect, $query11);
            
            while ($result1 = mysqli_fetch_row($exec11)) 
            {
                echo "<option value='".$result1[0]."'>".$result1[0]."</option>";
            }
        ?>

        </select>
        <input type="submit" name="wybierz" value="wybierz dostawce">
    </form>

    <?php
        if($_SERVER["REQUEST_METHOD"] === "POST"){
            $occur = $_POST["dostawcy"];

            // Poprawka 1: Dodano cudzysłowy wokół '$occur' w zapytaniu SQL
            $query2 = "SELECT DISTINCT produkty.NazwaProduktu, produkty.OpisProduktu, produkty.CenaDetaliczna, dostawcy.NazwaDostawcy FROM produkty INNER JOIN dostawcy_produktow ON produkty.NumerProduktu = dostawcy_produktow.NumerProduktu INNER JOIN dostawcy ON dostawcy.IDDostawcy = dostawcy_produktow.IDDostawcy WHERE dostawcy.NazwaDostawcy = '$occur'";
            $exec2 = mysqli_query($connect, $query2);

            echo "<table border='1'><tr><th>lp</th><th>Nazwa</th><th>opis</th><th>cena</th></tr>";
            
            $lp = 1;
            while($result2 = mysqli_fetch_row($exec2))
            {
                // Poprawka 2: Poprawiono strukturę komórek tabeli (brak zduplikowanych </td> i dodano kolumnę 'lp')
                echo "<tr><td>".$lp."</td><td>".$result2[0]."</td><td>".$result2[1]."</td><td>".$result2[2]." zł</td></tr>"; 
                $lp++;  
            }

            echo "</table>";
        }
    ?>
    <br>
   <a href="index.php">strona glowna</a> 
   <a href="dodawanie.php">Dodaj produkt</a>
   <a href="raporty.php">Raport</a>
   <a href="dostawcy.php">Dostawcy produktow</a>
</body>
</html>