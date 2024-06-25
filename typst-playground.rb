require 'typst'


# Compile `readme.typ` to PDF and save as `readme.pdf`
Typst::Pdf.new("./test.typ").write("test.pdf")
Typst::Html.new("./test.typ").write("test.html")

