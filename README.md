# apache-guacamole-helper

Here is a README for the Guacamole installation script:

# Guacamole Installation Script

This script automates the installation and configuration of Guacamole on Ubuntu.

## Usage

```bash
./install-guacamole.sh <version>
```

Replace `<version>` with the desired Guacamole version (e.g. 1.3.0).

The script will:

- Validate the version exists
- Install required dependencies
- Download and compile the Guacamole server
- Download the Guacamole web UI war file
- Configure guacamole.properties and user-mapping.xml
- Symlink configuration into Tomcat

## Configuration

The script configures Guacamole with:

- guacd listening on localhost:4822
- Basic file auth pointing to user-mapping.xml
- A single admin user "guacadmin" with password "guacadmin"
- A connection to VNC on localhost:5901

These can be customized by modifying `/etc/guacamole/guacamole.properties` and `/etc/guacamole/user-mapping.xml` after install.

## Troubleshooting

If the installation fails, check:

- Version exists at download URL
- Dependencies installed properly
- Tomcat initialized correctly
- guacamole.properties and user-mapping.xml correct

## License

This script is licensed under the GNU General Public License v3.0. See `LICENSE` for more details.
