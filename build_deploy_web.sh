#!/bin/bash

flutter pub get
flutter build web --release --source-maps
rsync -avz build/web/* paul@www.paulmin.nl:/var/www/html/lipl.paulmin.nl/
