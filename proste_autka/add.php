<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Autka - Dodawanie</title>
</head>
<body>
    <form action="" method="POST">
        <label for="klient"></label>
        <select name="klient" id="klient" required>
            <?php
                require_once 'connect.php';
                
                $query1 = "SELECT id_klienta, concat(imie, ' ', nazwisko) FROM klienci";
                $exec1 = mysqli_query($connect, $query1);

                while($result1 = mysqli_fetch_row($exec1)){
                    echo "<option value='$result1[0]'>$result1[1]</option>";
                }

            ?>
        </select><br>
        <label for="samochod"></label>
        <select name="samochod" id="samochod" required>
            <?php
                $query2 = "SELECT id_samochodu, concat(marka, ' ', model) FROM samochody";
                $exec2 = mysqli_query($connect, $query2);

                while($result2 = mysqli_fetch_row($exec2)){
                    echo "<option value='$result2[0]'>$result2[1]</option>";
                }

            ?>
        </select><br>
        <label for="pracownik"></label>
        <select name="pracownik" id="pracownik" required>
            <?php
                $query3 = "SELECT id_pracownika, concat(imie_p, ' ', nazwisko_p) FROM pracownicy";
                $exec3 = mysqli_query($connect, $query3);

                while($result3 = mysqli_fetch_row($exec3)){
                    echo "<option value='$result3[0]'>$result3[1]</option>";
                }

            ?>
        </select><br>
        <label for="wyp">Data wyp</label>
        <input type="date" name="wyp" id="wyp" required><br>

        <label for="odd">Data wyp</label>
        <input type="date" name="odd" id="odd" required>
        <br>
        <button type="submit" id="dodaj" name="dodaj">Dodaj</button>
    </form>

    <?php
        if(isset($_POST['dodaj'])){
            $klient = $_POST['klient'];
            $samochod = $_POST['samochod'];
            $pracownik = $_POST['pracownik'];
            $wyp = $_POST['wyp'];
            $odd = $_POST['odd'];
            $query4 = "INSERT   INTO wypozyczenia (id_klienta, id_samochodu, id_pracownika, data_wyp, data_odd) 
                                values($klient, $samochod, $pracownik, $wyp, $odd)";
            $exec4 = mysqli_query($connect ,$query4);

        }
        mysqli_close($connect);
    ?>
</body>
</html>