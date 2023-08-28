
i_build:
	docker build -t ping .

i_scout_viewer:
	docker scout quickview

i_scout_cves:
	docker scout cves ping

i_recommendations:	
	docker scout recommendations ping	

i_lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

i_all: i_build i_scout_viewer i_scout_cves i_recommendations i_lint
	echo "All"

run_container:
	docker run -d -e PROFILE=stg -p 8080:8080 ping

build:
	mvn clean package

run:
	echo mvn spring-boot:run -Dspring-boot.run.arguments=--spring.profiles.active=stg
