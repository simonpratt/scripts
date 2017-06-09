#!/usr/bin/env bash

: ${sub_path?"You need to provide the submodule path param: sub_path "}

if [ -d "$sub_path" ]; then
	mv "$sub_path" "${sub_path}_"
	git submodule deinit "$sub_path"
	git rm "$sub_path"
	mv "${sub_path}_" "$sub_path"
	# git add "$sub_path/**"
fi



# mv asubmodule asubmodule_tmp
# git submodule deinit -f -- a/submodule    
# rm -rf .git/modules/a/submodule

# git rm -f a/submodule
# # Note: a/submodule (no trailing slash)