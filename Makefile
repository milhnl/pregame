.POSIX:
.PHONY: format

format:
	deno fmt

dist/index.html: Makefile index.html index.tsx
	mkdir -p dist
	deno eval \
		'import { bundle } from "https://deno.land/x/emit@0.22.0/mod.ts";'` \
			`' console.log((await bundle("./index.tsx", '"$$(\
				cat deno.json)"')).code);' \
		>dist/index.js
	<index.html awk '\
		/<!-- MODULE -->/ { \
			while (getline <"dist/index.js") print; \
			next; \
		} \
		{ print $$0; } \
	' >dist/index.html
	rm dist/index.js
