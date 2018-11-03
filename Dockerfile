FROM node:8
RUN apt-get update && apt-get install -y \
gnupg \
curl \
unzip \
zip \
python-dev

# Create a directory where app will be placed
RUN mkdir -p /usr/src/app

# Change directory so that commands run inside this new directory
WORKDIR /usr/src/app
COPY package.json /usr/src/app

# copy all the code needed to run the 
COPY . /usr/src/app

# Install dependecies
RUN npm install \ 
&& npm install -g @angular/cli \
&& npm rebuild node-sass

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# Serve the app
CMD ng serve --host 0.0.0.0 --poll 1