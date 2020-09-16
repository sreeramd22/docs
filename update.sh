#!/bin/bash
#put script in xtended source folder, make executable (chmod +x update.sh) and run it (./update.sh)

#modify values below
#leave blank if not used
zip="Xtended-Tribute-To-MartinCoulon-x2-20200916.zip"
device="x2"
#don't modify from here
script_path="`dirname \"$0\"`"
zip_name=$script_path/out/target/product/$device/$zip
buildprop=$script_path/out/target/product/$device/system/build.prop
romtype="OFFICIAL"

if [ -f $script_path/$device.json ]; then
  rm $script_path/$device.json
fi

linenr=`grep -n "ro.system.build.date.utc" $buildprop | cut -d':' -f1`
datetime=`sed -n $linenr'p' < $buildprop | cut -d'=' -f2`
zip_only=`basename "$zip_name"`
id=`md5sum "$zip_name" | cut -d' ' -f1`
size=`stat -c "%s" "$zip_name"` version=`echo "$zip_only" | cut -d'-' -f3 `
echo '{
  "response": [
    {
        "filename": "'$zip_only'",
        "url": "https:\/\/downloads.msmxtended.org\/'$device'\/'$zip_only'",
        "datetime": '$datetime',
        "id": "'$id'",
        "size": '$size',
        "version": "'$version'",
        "romtype": "'$romtype'"
    }
  ]
}' >> $device.json
