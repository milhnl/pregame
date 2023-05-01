.POSIX:
.PHONY: format

format:
	deno fmt

dist/index.html: Makefile index.html index.tsx
	mkdir -p dist
	deno bundle --config=deno.json index.tsx \
		>dist/index.js
	<index.html awk '\
		/<!-- MODULE -->/ { \
			while (getline <"dist/index.js") print; \
			next; \
		} \
		{ print $$0; } \
	' >dist/index.html
	rm dist/index.js
