premailer-server
================
I liked the API at http://premailer.dialect.ca/, but it is hard to trust a free service and rely on it for mission critical stuff.

So we put together this simple Sinatra wrapper to act as a web-interface to Premailer.

Just do a form POST with "html" and you'll receive JSON of the inlined HTML with the html and txt versions.

Relies on nokogiri within Premailer, and uses Zurb's recommended premailer settings.
