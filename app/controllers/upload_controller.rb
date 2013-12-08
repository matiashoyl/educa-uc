require 'data_file'
class UploadController < ApplicationController
  def initialize
    
  end

  def index
    render :file=> 'app/views/upload/uploadfile.html.erb'
  end

  def uploadfile
    mime_type = 
      "application/vnd.openxmlformats-
      officedocument.wordprocessingml.document"
    
    s =  School.last
    DataFile.save(s,"Mayo",2013)
    
    # Send the new file with the wordprocessingml document
    # content type.
    send_file("public/resources/newdoc.docx",
      :filename=> "newdoc.docx",
      :type=>mime_type)
  end
end