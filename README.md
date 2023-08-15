# Guacamole Installation Script

This script automates the installation and configuration of Guacamole on Ubuntu.  
After the installation is complete, the guacamole server should be accessible on `http://SERVER_IP:8080/guacamole`

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

## Additional Scripts

### Managing Users

The `guac-users.sh` script allows adding and removing user accounts by modifying `user-mapping.xml`.

```
./guac-users.sh add <username> <password>  # Add user
./guac-users.sh delete <username>         # Delete user
```

### Managing Connections

The `guac-servers.sh` script allows adding, deleting, and editing connections by modifying `user-mapping.xml`.

```  
./guac-servers.sh add <name> <parameters>    # Add connection
./guac-servers.sh delete <name>              # Delete connection
./guac-servers.sh edit <name> <parameters>   # Edit connection
```
To add a connection:
- `<name>` - Name of the connection
- `<protocol>` - Protocol, either `rdp` or `vnc`
- `<param name="hostname">` - Remote host IP or hostname
- `<param name="port">` - Port for remote connection

For example:  
`./guac-servers.sh add 'Windows 10' '<protocol>rdp</protocol><param name="hostname">192.168.0.10</param><param name="username">Admin</param><param name="password">Password</param><param name="port">3389</param><param name="ignore-cert">true</param>'`

For further information see script comments for parameter syntax.

## Configuration  

The main install script will create a default `guacamole.properties` and `user-mapping.xml`. These can be further customized using the `guac-users.sh` and `guac-servers.sh` scripts.  
  
For windows server, make sure to have either working certificates or define the following parameter within the connection:  
`<param name="ignore-cert">true</param>`

## Troubleshooting

If the installation fails, check:

- Version exists at download URL
- Dependencies installed properly  
- Tomcat initialized correctly
- guacamole.properties and user-mapping.xml correct  

## License

This script is licensed under the GNU General Public License v3.0. See `LICENSE` for more details.

Let me know if you would like me to modify or add anything to this README!
