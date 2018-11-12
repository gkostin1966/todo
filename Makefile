all: clean

clean:
	rm -f js/todo.js

js/todo.js: lib/todo.rb
	bundle exec opal --compile --gem ruby-trello --include bundle \
	--include /usr/local/Homebrew/Library/Homebrew/vendor/portable-ruby/2.3.3/lib/ruby/2.3.0/ \
	--include /usr/lib/zsh/5.0.8/zsh/net/ \
	--include lib --include lib/todo lib/todo.rb > js/todo.js


gh-pages-js:
	git push --delete origin gh-pages
	git subtree push --prefix client/app_js origin gh-pages

gh-pages-rb:
	git push --delete origin gh-pages
	git subtree push --prefix client/app_rb origin gh-pages
