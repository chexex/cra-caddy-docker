# Stage 0, "build-stage" to build and compile the frontend
from node:11-alpine as build-stage
WORKDIR /app
COPY . ./
RUN npm i
RUN yarn install
RUN npm run build

# Stage 1, to have only the compiled app, ready for production with Caddy
from abiosoft/caddy
COPY --from=build-stage /app/build  /www
COPY ./Caddyfile /etc/Caddyfile
