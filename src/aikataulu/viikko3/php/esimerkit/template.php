<!DOCTYPE html>
<html>
    <head>
        <title><?php if (isset($this->title)) echo $this->title; ?></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/main.css" rel="stylesheet">
    </head>
    <body>
      <nav>
        <a href="index.php">Lista</a>
        <a href="logout.php">Kirjaudu ulos</a>
      </nav>
            
      <div class="container">
        <?php if (!empty($this->error)): ?>
        <div class="alert alert-danger"><?php echo $this->error; ?></div>
        <?php endif; ?>
        <?php $this->displayContent(); ?>
      </div>
    </body>
</html>
