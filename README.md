# RefranerBot (Bot)

## Dependencies

- Elixir
- Git
- GNU Make

## Quick run

    $ echo '<TOKEN>' > bot.token
    $ make run

## Install (systemd)

If you have not done so already, write the Telegram token to `bot.token`:

    $ echo '<TOKEN>' > bot.token

Move the code to /opt and set permissions:

    # cd ..
    # cp -R refraner_bot /opt
    # chown -R www-data:www-data /opt/refraner_bot

Install the systemd service and enable it to run at startup:

    # cp refraner_bot/refraner_bot.service.sample /etc/systemd/system/refraner_bot.service
    # systemctl daemon-reload
    # systemctl enable refraner_bot

NOTE: if you chose to deploy the code to another path or use another user/group,
update them in /etc/systemd/system/refraner_bot.service after copying the template.

## Run (systemd)

After installing it, you can control the service via systemd:

    # systemctl start refraner_bot
    # systemctl stop refraner_bot
    # systemctl restart refraner_bot

## Start on system startup (systemd)

    # systemctl enable refraner_bot
