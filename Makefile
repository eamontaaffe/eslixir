TEST=7379

test-start:
	redis-server --port $(TEST) --daemonize yes

test-stop:
	redis-cli -p $(TEST) shutdown
