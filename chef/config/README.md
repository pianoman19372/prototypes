chef config dir
===============

this is not part of a typical chef repo, this is where i dump my creds and
knife config used by the Makefile on provisioning. 

security warning
================
This is just a demo of provisioning nothing to something chef servers.  Its
essential to site security to properly configure and protect your .pem files

Using this demo as-is is not 100% production ready.

in short: 
 * dont check in your .pem files
 * dont check in your .crt files
 * dont hardcode passwords (in the Makefile), pass in ENV variables instead.

Common Pitfalls
===============

knife ssl check fails
---------------------
we're generating our own ssl certs instead of using real ones.   you need
to add the cert to your ~/.chef/trusted_certs path in knife.rb

knife client list fails
-----------------------
the chef url is wrong.   should be https://chefserver.fqdn:443/organizations/ORG_NAME
