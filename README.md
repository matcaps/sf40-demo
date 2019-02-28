Symfony 3.0.9 empty app
=====================

Plug-and-play Symfony 3.0.9 for demonstration

# Setup

Clone the repository and run this:

```bash
make install
```

Then open [127.0.0.1:9080](127.0.0.1:9080).

Enjoy!

# What it contains

Shipped with a `docker-compose` configuration providing:

* PHP 7.1.26 (so we use the lowest possible PHP version).
* Nginx accessible at [127.0.0.1:9080](127.0.0.1:9080), proxying to the PHP container.
* A database with MySQL 5.7 with an already configured `root` user.
* A configured `mailcatcher` container accessible at [127.0.0.1:1080](127.0.0.1:1080) in case you want to send and check emails.
