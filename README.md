# OctoEvents

## Prerequisites

### Elixir

1. Follow the steps to install elixir on your OS available [here](https://elixir-lang.org/install.html);
2. Check that elixir is installed correctly:
```bash
$ elixir --version
```

### Phoenix

1. Follow the steps to install Phoenix available [here](https://hexdocs.pm/phoenix/installation.html);
2. You won't need node.js for this project, but you will need PostgreSQL.
### Postgres

1. Follow the steps to install PostgreSQL available [here](https://wiki.postgresql.org/wiki/Detailed_installation_guides);
2. Make sure your 'postgres' user has the default 'postgres' password and can login with it;

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

### Test repository

We need a test repository to validate that events triggers the webhook.

1. Login to your github account;
2. [Create](https://github.com/new) a new repository with a README;
3. Keep track of the test repository name, it will be needed later.

## Starting up

### Clone
1. Clone this project:
```bash
$ git clone https://github.com/ricardoebbers/octo_events.git
```
2. Change into repository directory:
```bash
$ cd octo_events
```

### Phoenix server

1. Compile project:
```bash
$ mix compile
```
2. Setup ecto:
```bash
# Create the storage for the repositories
$ mix ecto.create
# You should see this line:
# The database for OctoEvents.Repo has been created

# Run the pending migrations
$ mix ecto.migrate
# You should see "== Migrated (...) in 0.0s" for each migration in the project
```
3. Start up server:
```bash
$ mix phx.server
# Your terminal should contain these lines:
# [info] Running OctoEventsWeb.Endpoint with cowboy 2.8.0 at 0.0.0.0:4000 (http)
# [info] Access OctoEventsWeb.Endpoint at http://localhost:4000
```

### Ngrok

1. On another terminal, fire up the ngrok and point to the Phoenix server port (defaults to 4000):
```bash
$ ./ngrok/ngrok http 4000
# Your terminal shoud contain a text-based dashboard with a line like this:
# Forwarding                    http://ed5cb167ae99.ngrok.io -> http://localhost:4000
                                ^ Take note of this address, you will need it to configure the webhook
```
2. Click the address exposed by ngrok;
3. You should see the NoRouteError page from Phoenix for GET /. This is working as expected.

### Configure Webhook

1. Create a new webhook for your test repository at `https://github.com/<your_github_username>/<your_test_repository>/settings/hooks/new` (you might need to confirm your github access, as you will be entering sudo mode)
2. On "payload URL" insert the forwarding address from ngrok terminal, with the `/payload` suffix like this: `http://<your_ngrok_url_here>.ngrok.io/payload`;
3. On "Content type" select "application/json";
4. You can keep the "secret key" blank for now;
5. Check the "let me select individual events" radio button;
6. Check the "Issues" checkbox and **uncheck** "Pushes" checkbox;
7. Keep the "Active" checkbox checked;
8. Click on "Add Webhook" button;
9. Github sends a `ping` event when webhooks are created. On the Recent Deliveries section you should see an uuid with a green checkmark like this: ![Ping ok](./img/ping_ok.png)


## Testing

We should be all set up, so now we can test the service.

### Running tests

You can run all tests on the service by using mix:
```bash
$ mix test
```

### Validating that issue events are stored

1. Go to the test repository and create a new issue `https://github.com/<your_github_username>/<your_test_repository>/issues/new`;
2. Check the **ngrok** terminal, you should see something like:
```bash
HTTP Requests
-------------

POST /payload                  201 Created # <- this signifies that we stored the event
POST /payload                  200 OK # <- this is from the ping event sent before

```

### Validating that other event types are discarded

1. Edit your webhook to send unhandled events like `Pull requests`;
2. Create a pull request. You can edit the README file on the browser for simplicity.
3. Check the Ngrok terminal again, you should see:
```bash
HTTP Requests
-------------

POST /payload                  400 Bad Request
```

### Listing stored events

// TODO 