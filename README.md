## Run Cron Job inside Docker Container

**hello.cronjob**

To run a cron job inside a Docker container, you need to specify your cron job first inside a file.


    * * * * * echo "Hello world" `date` >> /var/log/cron.log 2>&1
    

This cron job will `echo`-ing string and system date to a file.
Please notice there is **a new line** in the end of file.

**Dockerfile**

Create a `Dockerfile` to run our cronjob using cron tab.

    FROM ubuntu:14.04.1
    MAINTAINER Edward Samuel Pasaribu <edwardsamuel92@gmail.com>

    # Copy cron job to container
    ADD hello.cronjob /opt/hello/hello.cronjob

    # Change permission cron job file and load it with crontab
    RUN \
        chmod 0644 /opt/hello/hello.cronjob && \
        crontab /opt/hello/hello.cronjob

    # Create a file needed by hello.cronjob
    RUN \
        touch /var/log/cron.log

    # Run the command on container startup:
    # - Run non-daemonized cron in background
    # - Output the log result from hello.cronjob
    CMD (cron -f &) && tail -f /var/log/cron.log

### How to run

    git clone https://github.com/edwardsamuel/Docker-Cron-Job-Sample.git
    docker build -t edwardsp/cron-job-sample ./Docker-Cron-Job-Sample
    docker run -it edwardsp/cron-job-sample
