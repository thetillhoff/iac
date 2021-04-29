# magic-mirror

This application is running the magic-mirror software in server-only mode. This means it starts a docker-container, which hosts the magic-mirror software on a web-server.


## Access

To access it, a browser is required.

For automatic start it is required to:
- log a user in automatically at boot
- autostart the browser in full-screen mode (f.e. kiosk mode)
- point the browser to the container-URL
- hide the mouse cursor (f.e. with the `unclutter` software)
