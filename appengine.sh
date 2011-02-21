if [ "$1" == "" ]; then
  echo " Utilisation: "
  echo "'appengine nom_application' pour créer l'architecture d'une nouvelle application AppEngine pour Python SDK";
else
  if [ ! -d $1 ]; then
        mkdir $1;
        touch $1/app.py;
        echo "
from google.appengine.ext import webapp
from google.appengine.ext.webapp.util import run_wsgi_app

class Accueil(webapp.RequestHandler):
    def get(self):
        self.response.headers['Content-Type'] = 'text/plain'
        self.response.out.write('Hello, webapp World!')

application = webapp.WSGIApplication(
                                     [('/', Accueil)],
                                     debug=True)

def main():
    run_wsgi_app(application)

if __name__ == "__main__":
    main()" > $1/app.py;
        touch $1/app.yml;
        echo "
application: $1
version: 1
runtime: python
api_version: 1

handlers:
- url: /.*
  script: app.py" > $1/app.yml;
  		echo " Votre application a été générée. Lancez 'dev_appserver.py .' ";
        cd $1; ls ;
      else
        echo "Erreur lors de la création de l'application : $1 existe déjà.";
    fi;
fi
