# cityofcapetown/nginx-auth-ldap
[![stars](https://img.shields.io/docker/stars/cityofcapetown/nginx-ldap-proxy.svg?maxAge=2592000)](https://hub.docker.com/r/cityofcapetown/nginx-ldap-proxy/) [![pulls](https://img.shields.io/docker/pulls/cityofcapetown/nginx-ldap-proxy.svg?maxAge=2592000)](https://hub.docker.com/r/cityofcapetown/nginx-ldap-proxy/) [![](https://images.microbadger.com/badges/image/dweomer/nginx-ldap-proxy.svg)](https://microbadger.com/images/cityofcapetown/nginx-ldap-proxy "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/dweomer/nginx-ldap-proxy.svg)](https://microbadger.com/images/cityofcapetown/nginx-ldap-proxy "Get your own version badge on microbadger.com")

## Nginx on Alpine w/ LDAP Authentication

Built to be compatible with the [official Nginx image](https://hub.docker.com/_/nginx/). Leverages the LDAP authentication module from [kvspb/nginx-auth-ldap](https://github.com/kvspb/nginx-auth-ldap).

Intended to be used as a simple, modularised LDAP auth proxy in front of other applications.

### Getting Started

By default, this image rolls it's own config, and uses the following env variables to substitute in various values:

* `BIND_DN` - The DN of the user that will bind onto the LDAP server, e.g. `"CN=My Service Account,OU=My Org Unit,DC=capetown,DC=gov,DC=za"`
* `BIND_DN_PASSWORD` - The password of the bind DN user.
* `LDAP_WELCOME_MSG` - Message shown when prompting users for their username and password, e.g. `"Hello, welcome to my app - please use your special credentials"`
* `LDAP_URL` - LDAP URL to bind, and search against. Defaults to `ldap://capetown.gov.za:3268/dc=capetown,dc=gov,dc=za?sAMAccountName?sub?(objectClass=person)` which is all users at the City of Cape Town, e.g. `ldap://capetown.gov.za:3268/dc=capetown,dc=gov,dc=za?sAMAccountName?sub?(&(memberOf:1.2.840.113556.1.4.1941:=CN=My%20Group,OU=Resource%20Groups,OU=Groups,DC=capetown,DC=gov,DC=za)(objectClass=person))`
* `BACKEND_SERVER` - backend server (without protocol) to pass the authenticated user to, e.g. `my-service.capetown.gov.za`.

To limit access to a specific group, add it to the `LDAP_URL` (see the example above).

Command example:
```bash
$ docker run -it --rm --name nginx-ldap-proxy-test -p 8080:80 --env BACKEND_SERVER="192.168.16.1:8000" \
                                                              --env BIND_DN="CN=My Service Account,OU=My Org Unit,DC=capetown,DC=gov,DC=za" \
                                                              --env BIND_DN_PASSWORD="My Service Account's password" \
                                                              --env LDAP_WELCOME_MSG="Hello, World! Please use your normal credentials to access" \
                                                              cityofcapetown/nginx-ldap-proxy
```

### Advanced Settings
Please see [test/my-secured-site/secured.conf](test/my-secured-site/secured.conf) for an example of more advanced configurations.

#####  Copyright Notice
>The [MIT License](LICENSE) ([MIT](https://opensource.org/licenses/MIT))
>
> Copyright &copy; 2017 [Jacob Blain Christen](https://keybase.io/dweomer) and [City of Cape Town](https://www.capetown.gov.za)
>
> Permission is hereby granted, free of charge, to any person obtaining a copy of
> this software and associated documentation files (the "Software"), to deal in
> the Software without restriction, including without limitation the rights to
> use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
> the Software, and to permit persons to whom the Software is furnished to do so,
> subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in all
> copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
> FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
> COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
> IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
> CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[hub]: https://hub.docker.com/r/cityofcapetown/nginx-ldap-proxy/
[issues]: https://github.com/cityofcapetown/dockerfiles-nginx-auth-ldap/issues
