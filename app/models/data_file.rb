class DataFile
  def initialize
  end

  # Save the uploaded files to a temp folder and then perform
  # translation.
  def self.save(school, month, year, subscales_scores, total_score)




    upload  = File.open("public/Informe.xslt", "r")
    upload1 = File.open("public/Informe.docx", "r")
    upload2 = File.open("public/Informe.xml", "r")

    name =
      sanitize_filename("public/Informe2.xslt").to_s
    name1 =
      sanitize_filename("public/Informe.docx").to_s
    name2 =
      sanitize_filename("public/Informe.xml").to_s

    directory = "public/data"



    # Create the file path.
    path = File.join(directory, name).to_s
    path1 = File.join(directory,name1).to_s
    path2 = File.join(directory,name2).to_s
    

    # Save the files.
    upload_file(path,upload,'file')
    upload_file(path1,upload1,'file1')
    upload_file(path2,upload2,'file2')

    OfficeOpenXML.translate(path,
                            path1,
                            path2,
                            "public/resources/newdoc.docx")
  end

  private
  def self.upload_file(path,uploadfile,file)
    File.open(path, "wb") do |f|
    f.write(uploadfile.read)
    end
  end

  private
  def self.sanitize_filename(file_name)
    # Get only the filename, not the whole path.
    just_filename = File.basename(file_name)
    # Replace all non-alphanumeric, underscore or period characters
    # with an underscore.
    just_filename.gsub(/[^\w\.\_]/,'_')
  end

end