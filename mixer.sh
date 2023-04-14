# List of URLs to fetch
url_list=(
    "https://raw.githubusercontent.com/IranianCypherpunks/sub/main/config" #IranianCypherpunks
)

# Output file name
output_file="configs.txt"

# Check if the merged file already exists, and delete it if it does
if [ -f "$output_file" ]; then
  rm "$output_file"
fi 

# Loop through the URL list, fetch each URL and add it to output file
for url in "${url_list[@]}"
do
    curl "${url}" >> "${output_file}"
done

# Mix withoutsub.txt file to output file
cat withoutsub.txt >> "${output_file}"

# Remove comments from the output file
sed -i '/^#/d' "${output_file}"

# Remove empty lines from the output file
sed -i '/^$/d' "${output_file}"

# Remove duplicate lines from the output file
awk '!a[$0]++' "${output_file}" > "${output_file}.tmp" && mv "${output_file}.tmp" "${output_file}"

# Print the output file name
echo "All URLs fetched and mixed into ${output_file}"
