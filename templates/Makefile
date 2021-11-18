.phony : all, build, web, test, test-parallel, clean

DOCKER_IMAGE={{DOCKER_IMAGE}}

all: build

build:
	-rm -f Manifest.toml
	docker build -t ${DOCKER_IMAGE} .
	docker-compose build
	docker-compose run --rm julia julia --project=/work -e 'using Pkg; Pkg.instantiate()'
	docker-compose run --rm julia julia --project=docs -e 'using Pkg; Pkg.develop(PackageSpec(path=pwd())); Pkg.instantiate()'

# Excecute in docker container
web: docs
	julia --project=docs -e 'using Pkg; Pkg.develop(PackageSpec(path=pwd())); Pkg.instantiate(); \
		include("docs/make.jl"); \
		using LiveServer; servedocs(host="0.0.0.0"); \
		'

test: build
	docker-compose run --rm julia julia -e 'using Pkg; Pkg.activate("."); Pkg.test()'

clean:
	docker-compose down
	-rm -f playground/notebook/*.ipynb
	-rm -rf playground/notebook/*.gif
	-rm -rf playground/notebook/*.png
	-rm -f  Manifest.toml docs/Manifest.toml
	-rm -rf docs/build
