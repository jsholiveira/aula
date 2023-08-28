build:
	mvn clean package

run:
	mvn spring-boot:run -Dspring-boot.run.arguments=--spring.profiles.active=dev

image_build:
	docker build -t ping .

image_scout_viewer:
	docker scout quickview

image_scout_cves:
	docker scout cves ping

image_recommendations:	
	docker scout recommendations ping	

image_lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

image_all: image_build image_scout_viewer image_scout_cves image_recommendations
	echo "All"

run_container:
	docker run -d -p 8080:8080 ping