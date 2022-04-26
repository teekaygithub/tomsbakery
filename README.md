# ============================================
# Run locally
# ============================================

Define the 5 environment variables on your system:

SQL_TK_USER:        Username for MySQL database
SQL_TK_PW:          Password for MySQL database
SQL_HOST:           URL for MySQL database, DB name excluded (e.g. jdbc:mysql://localhost:3306)
STRIPE_PUBLIC_KEY:  Public key for Stripe payment service
STRIPE_SECRET_KEY:  Secret key for Stripe payment service

Run 'mvn clean install', then 'mvn spring-boot:run'

# ============================================
# Run docker container by 'run' command
# ============================================

Assuming an image exists (docker-pull or docker-build), run with the following commands:

docker run --name=mydb -d -e MYSQL_ROOT_PASSWORD=%SQL_TK_PW% --network tbnw -v tbvol:/data mysql:latest
docker run --rm --name=[desired container name] -d -p 8443:8443 --env-file=.env [your image name]:[version]

Make sure you have an .env file that has all the environment variables listed above.

# ============================================
# Run docker container by 'compose' command
# ============================================

Run the following command:

docker compose up -d

Same as above, make sure you have an '.env' file with all your environment variables defined.