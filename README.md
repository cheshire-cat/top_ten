# Quick start (development env)

### Copy master.key in config/


### Create .env file

```
#.env
COIN_MARKET_CAP_API_KEY=xxx
GITHUB_KEY=xxx
GITHUB_SECRET=xxx
```

This is for your convinience.
Normally its content goes to encrypted credentials, rather than in env vars.
I used new version of coinmarketcap APIs. You can get api key here: <https://sandbox.coinmarketcap.com/>
Make sure GitHub Authorization callback URL is ```http://127.0.0.1:3000/auth/github/callback```

### Prepare development env and run it.

```bash
sudo docker-compose build
sudo docker-compose run dev-app rake db:create
sudo docker-compose run dev-app rake db:migrate

sudo docker-compose up
```


### Visit <http://127.0.0.1:3000>
(Javascript should be enabled for correct work.)


### Optional.

tests:

```bash
sudo docker-compose run dev-app rspec
```
Also, you can check coverage in coverage/

docs:

```bash
sudo docker-compose run dev-app yard
```

It's partially documented though...

code style:

```bash
sudo docker-compose run dev-app rubocop
```


# Not so quick start (production-like env)

It is just a production-like setup.
It is not a real production and high-load ready setup.
Yet it works trough ssl and does rails production setup.


### Copy master.key in config/


### Create .env file

```
#.env
COIN_MARKET_CAP_API_KEY=xxx
GITHUB_KEY=xxx
GITHUB_SECRET=xxx
```

This is for your convinience.
Normally its content goes to encrypted credentials, rather than in env vars.
I used new version of coinmarketcap APIs. You can get api key here: <https://sandbox.coinmarketcap.com>
Make sure GitHub Authorization callback URL is ```https://127.0.0.1:443/auth/github/callback```


### Create your or copy my key, certificate and D-H parameter file in production/secrets/.
My certs are self-singed. Browser will warn you about unsecure connection because of that.


### Prepare production env and run it.

```bash
sudo docker-compose -f docker-compose-production.yml build
sudo docker-compose -f docker-compose-production.yml run app rake db:create
sudo docker-compose -f docker-compose-production.yml run app rake db:migrate

sudo docker-compose -f docker-compose-production.yml up
```


### Visit <https://127.0.0.1:443>
(Javascript should be enabled for correct work.)

