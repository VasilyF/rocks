<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport"
              content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">

        <link rel="stylesheet" href="../styles/general.css">
        <link rel="stylesheet" href="../styles/login.css">

        <title>Rocks Login</title>
    </head>
    <body>
        <main>
        <form id=loginForm action="TODO" method="post" class="center">
            <ul>
                <li>
                    <label for="unInput">Username</label>
                    <input id="unInput" type="text" name="username">
                </li>
                <li>
                    <label for="pwdInput">Password</label>
                    <input id="pwdInput" type="password" name="password">
                </li>
                <li>
                    <button type="submit">Log In</button>
                </li>
            </ul>
        </form>
        </main>
        <?php include "common/footer.php" ?>
    </body>
</html>