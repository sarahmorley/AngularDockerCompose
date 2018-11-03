FROM node:8

RUN apt-get update && apt-get install -y \
gnupg \
curl \
unzip \
zip \
python-dev

# Create a directory where app will be placed
RUN mkdir -p /usr/src/app

# Change to newly created directory
WORKDIR /usr/src/app

#Copy package.json over first to install npm
COPY ./package.json /usr/src/app

# Install dependecies
RUN npm install \ 
&& npm install -g @angular/cli \
&& npm rebuild node-sass

# Copy the app source code
COPY . /usr/src/app

# Add whats needed to PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# Serve the app to any listening ip and enable polling for reload after code change
CMD ng serve --host 0.0.0.0 --poll 1