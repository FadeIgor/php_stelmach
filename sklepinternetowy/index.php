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
        <label for="nazwa">nazwa</label>
        <input type="text" name="nazwa" id="nazwa">

        <label for="opis">opis</label>
        <input type="text" name="opis" id="opis">

        <label for="cena">cena</label>
        <input type="number" name="cena" id="cena">

        <label for="stan">stan</label>
        <input type="number" name="stan" id="stan">

        <label for="kategoria">kategoria:</label>
        
        <select name="kategoria" id="kategoria">
                <option>Wybierz kategorie</option>
                <?php 
                    require_once "connect.php";

                    $query1 = 'SELECT * FROM kategorie';
                    $exec1 = mysqli_query($connect, $query1);

                    while($result1 = mysqli_fetch_assoc($exec1)){
                        echo '<option value="'.$result1['IDKategorii'].'">'.$result1['OpisKategorii'].'</option>';
                    }
                ?>
        </select>
        <button type="submit" id="dodaj" name="dodaj">Wyslij</button>
    </form>

    <?php

        if(isset($_POST['dodaj'])){
            $nazwa = $_POST['nazwa'];
            $opis = $_POST['opis'];
            $cena = $_POST['cena'];
            $stan = $_POST['stan'];
            $idkategorii = $_POST['kategoria'];

            if(!empty($nazwa) && !empty($opis) && !empty($cena) && !empty($stan) && !empty($idkategorii)){
                $query2 = "INSERT 	INTO produkty (NazwaProduktu, OpisProduktu, CenaDetaliczna, StanMagazynowy, IDKategorii)
		                        VALUES ('$nazwa', '$opis', '$cena', '$stan', '$idkategorii');";
                $exec2 = mysqli_query($connect, $query2);
                echo 'dodano produkt'; 
            }
            else{
                echo "nie podano wszystkich danych!!!";
            }
        }

        mysqli_close($connect);
    ?>

    <br>
</body>
</html>