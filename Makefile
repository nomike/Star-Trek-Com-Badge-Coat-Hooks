.PHONY: clean output

output/star-trek-coat-hook.stl: output
	openscad -o $@ star-trek-coat-hook.scad

output:
	mkdir -p output

clean: 
	rm -f output/star-trek-coat-hook.stl
	
