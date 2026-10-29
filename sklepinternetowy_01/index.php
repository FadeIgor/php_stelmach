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

        $query1 = "SELECT COUNT(*) FROM klienci";
        $exec1 = mysqli_query($connect, $query1);
        $result1 = mysqli_fetch_row($exec1);

        echo "W bazie znajduje się: ".$result1[0]." klientów.";
        

    ?>
    <br>
   <a href="index.php">strona glowna</a> 
   <a href="dodawanie.php">Dodaj produkt</a>
   <a href="raporty.php">Raport</a>
   <a href="dostawcy.php">Dostawcy produktow</a>
</body>
</html>