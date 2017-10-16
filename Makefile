test-start:
	docker run --name redis-test -d redis --p 6379

test-stop:
	docker stop redis-test
	docker rm redis-test
