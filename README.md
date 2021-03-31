# OctoEvents

## Starting up

### Phoenix server

1. Setup ecto:
```bash
# Create the storage for the repositories
$ mix ecto.create
# Run the pending migrations
$ mix ecto.migrate
```
2. Start up server:
```bash
$ mix phx.server
```

### Ngrok

We are using Ngrok to expose the localhost environment, instead of deploying to a cloud service.

1. [Download](https://ngrok.com/download) and extract the binary to the [ngrok folder](./ngrok);
2. [Sign up](https://dashboard.ngrok.com/signup) and login to Ngrok;
3. Take note of your auth token available [here](https://dashboard.ngrok.com/get-started/your-authtoken);
4. Connect to your account:
```bash
# Considering you extracted ngrok to ./ngrok folder, send this on your terminal
$ ./ngrok/ngrok authtoken <your_auth_token>
# You should get a message 'Authtoken saved to configuration file(...)'
```
5. Fire up the ngrok and point to the Phoenix server port:
```bash
$ ./ngrok/ngrok http 4000
# Your terminal shoud contain a text-based dashboard with a line like this:
# Forwarding                    http://ed5cb167ae99.ngrok.io -> http://localhost:4000
```
6. Click the address exposed by ngrok;
7. You should see the NoRouteError page from Phoenix for GET /. This is working as expected.
