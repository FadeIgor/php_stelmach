<!DOCTYPE html>
<html lang="pl">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dodaj_rybe</title>
</head>

<body>
    <form action='dodaj_rybe.php' method='post'>
        <label>Podaj nazwe ryby: </label>
        <input type="text" name="nazwa" required><br><br>
        <label>Podaj wystepowanie: </label>
        <input type="text" name="wystepowanie"required><br><br>
        <label>Podaj styl życia: </label>
        <input type="text" name="styl"><br><br>
        <input type="submit" name="dodaj" value="dodaj rybe">
        <?php
        require_once "connect.php";
        if(isset($_POST['dodaj'])){
        $nazwa = $_POST['nazwa']; #z name'a w inpucie
        $wystepowanie = $_POST['wystepowanie'];
        $styl = $_POST['styl'];

        if(!empty('$nazwa') && !empty('$wystepowanie') && !empty('$styl')) {

        $ryba_dodaj = "INSERT INTO ryby(nazwa, wystepowanie, styl_zycia) VALUES ('$nazwa','$wystepowanie','$styl')";
        mysqli_query($connect, $ryba_dodaj);
        echo 'ryba w akwarium <br>';
        }
        else {
            echo 'uzupełnij wszystkie pola';
        };
        };
        mysqli_close($connect);
        ?>
    </form>
</body>

</html>