# Day One Export

This is a simple script to convert the JSON export from the [Day One](http://dayoneapp.com/) journaling app into a set of markdown files.
Day One is an awesome tool, but I like to keep an offline backup to reduce my dependencies on the cloud.

This script will process your journal export and map any embedded photos into the markdown files.
The result is that you should be able to use any markdown editor to view your journal entries, including the embedded photos.

## Usage

1. Export your Day One journal to JSON using the Day One app.
2. Clone this repo.
3. Run `ruby export.rb -s /path/to/your/journal.json -o /path/to/output/folder`
4. This will leave you with a folder full of markdown files, one for each entry in your journal.

## Backup
Write your output file to a backup location including the 'photos' folder in the original Day One export.

## License
MIT license. See the LICENSE file for details.