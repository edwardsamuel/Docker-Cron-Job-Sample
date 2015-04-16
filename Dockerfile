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