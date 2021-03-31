# OctoEvents

## Starting up

### Phoenix server

// TO-DO

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
```
