default: dist

all: rbuild dist

clean:
	rm -f dist/*

rspec:
	bundle exec rake spec

rbuild: rspec
	bundle exec rake build

gh-pages-js:
	git push --delete origin gh-pages
	git subtree push --prefix client/app_js origin gh-pages

gh-pages-rb:
	git push --delete origin gh-pages
	git subtree push --prefix client/app_rb origin gh-pages

gh-pages-js-rb: dist
	git push --delete origin gh-pages
	git subtree push --prefix dist origin gh-pages

dist: dist/ajax_info.txt dist/ajax.js dist/index.html
	@echo distribution up-to-date

dist/ajax_info.txt: src/ajax_info.txt
	cp src/ajax_info.txt dist/ajax_info.txt

dist/ajax.js: src/ajax.js.rb
	bundle exec opal --compile \
	--gem opal-jquery \
	--include node_modules/jquery/dist \
	src/ajax.js.rb > dist/ajax.js

dist/index.html: src/index.html
	cp src/index.html dist/index.html
