<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dodaj rybę</title>
</head>
<body>

    <form action="dodaj_rybe.php" method="POST">
        <label for="nazwa">Nazwa ryby:</label>
        <input type="text" id="nazwa" name="nazwa" required>
        <br><br>

        <label for="wystepowanie">Występowanie:</label>
        <input type="text" id="wystepowanie" name="wystepowanie" required>
        <br><br>

        <label for="styl">Styl:</label>
        <input type="text" id="styl" name="styl" required>
        <br><br>

        <input type="submit" name="dodaj" value="Dodaj rybę">
    </form>

</body>
</html>

<?php

require_once "connect.php";

IF (isset($_POST['dodaj']))  {

    $nazwa = $_POST['nazwa'];
    $wystepowanie = $_POST['wystepowanie'];
    $styl = $_POST['styl'];

    IF(!empty($nazwa) && !empty($wystepowanie) && !empty($styl))   {

        $query1 = "INSERT INTO ryby (nazwa, wystepowanie, styl_zycia)
                    VALUES ('$nazwa','$wystepowanie','$styl')";

        mysqli_query($connect,$query1);  
        
        echo "dodano nowa rybe";

    }

    else    {

        echo "wpisz wszystkie dane";

    }

}


mysqli_close($connect);

?>

<br><br><a href = 'index.php'>Kliknij do indexa</a>