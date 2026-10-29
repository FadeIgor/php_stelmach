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
        <label for="nazwa">nazwa produktu</label>
        <input type="text" id="nazwa" name="nazwa" required>

        <label for="opis">opis produktu</label>
        <input type="text" id="opis" name="opis" required>

        <label for="cena">Cena detaliczna</label>
        <input type="text" id="cena" name="cena" required>

        <label for="stan">Stan magazynowy</label>
        <input type="text" id="stan" name="stan" required>

        <label for="kat">Id kategorii</label>
        <input type="text" id="kat" name="kat" required>

        <input type="submit" name="dodaj" value="Dodaj produkt">
    </form>

    <?php 
        require_once "connect.php";
        
         if(isset($_POST['dodaj'])) {
                $nazwa = $_POST['nazwa'];
                $opis = $_POST['opis'];
                $cena = $_POST['cena'];
                $stan = $_POST['stan'];
                $kat = $_POST['kat'];

                $produkt_dodaj = "INSERT INTO produkty(
                        NazwaProduktu,
                        OpisProduktu,
                        CenaDetaliczna,
                        StanMagazynowy,
                        IDKategorii
                        ) VALUES('$nazwa', '$opis', '$cena', '$stan', '$kat')";
                mysqli_query($connect, $produkt_dodaj);
            
        }
            
            

    ?>
    <br>
   <a href="index.php">strona glowna</a> 
   <a href="dodawanie.php">Dodaj produkt</a>
   <a href="raporty.php">Raport</a>
   <a href="dostawcy.php">Dostawcy produktow</a>
</body>
</html>