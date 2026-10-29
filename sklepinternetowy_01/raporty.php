<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <?php 
        require_once "connect.php";

        $query1 = "SELECT klienci.ImieKlienta, klienci.NazwiskoKlienta, SUM(dane_zamowien.CenaZakupu * dane_zamowien.ZamowionaIlosc) FROM klienci INNER JOIN zamowienia ON klienci.IDKlienta = zamowienia.IDKlienta INNER JOIN dane_zamowien on zamowienia.NumerZamowienia = dane_zamowien.NumerZamowienia GROUP BY klienci.IDKlienta";
        $exec1 = mysqli_query($connect, $query1);

        echo "<table border='1'><tr><th>Imie</th><th>Nazwisko</th><th>wartosc</th></tr>";

        while ( $result1 = mysqli_fetch_row($exec1))
        {
            echo "<tr><td>".$result1[0]."</td><td>".$result1[1]."</td><td>".$result1[2]."</td></tr>";
        }

        echo "</table>";
    ?>
    <br>
   <a href="index.php">strona glowna</a> 
   <a href="dodawanie.php">Dodaj produkt</a>
   <a href="raporty.php">Raport</a>
   <a href="dostawcy.php">Dostawcy produktow</a>
</body>
</html>