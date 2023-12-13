compile:
	haxe build.hxml

retail: compile
	rm -rf retail
	mkdir -p retail/build
	mkdir -p retail/src
	mkdir -p temp
	terser --compress unsafe_arrows=true,passes=8 -- build/main.js > temp/main.min.js
	cp -rf data retail/data
	cp temp/main.min.js retail/build/main.js
	cp src/index.html retail/src/index.html

zip: retail
	rm -f retail.zip
	cd retail && zip ../retail.zip -r .
	stat retail.zip | grep Size

.PHONY: build retail
