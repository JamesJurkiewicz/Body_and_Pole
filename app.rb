require 'sinatra'
require 'pony'
require 'json'
require 'rubygems'
require 'google_drive'

get '/'  do
  erb :index
end

get '/index'  do
  erb :index
end


get '/about_us'  do
  erb :about_us
end

get '/classes'  do
  erb :classes
end

get '/instructors'  do
  erb :instructors
end

get '/information' do 
  erb :information
end

get '/sign_up'  do

   session = GoogleDrive.login("james.jurkiewicz12@gmail.com", "JboSelect1")
    #First worksheet of
    #https://docs.google.com/spreadsheet/ccc?key=pz7XtlQC-PYx-jrVMJErTcg
    ws = session.spreadsheet_by_key("1aqlkV2gAxOQ_Bpd_E43fBJpF9KMb47OLxV9fqGvwOcw").worksheets[0]

    @sept_beg_1_6 = ws[2,8]
    @sept_beg_2_7 = ws[3,8] 
    @sept_beg_1_8 = ws[4,8]
    @nov_beg_1_6 = ws[5,8] 
    @nov_beg_2_7 = ws[6,8]
    @nov_beg_1_8 = ws[7,8] 


  erb :sign_up
end

get '/contact'  do
  erb :contact
end

get '/gallery'  do
  erb :gallery
end

get '/sign_in'  do
  erb :sign_in
end

post '/sign_up' do
  classes = params[:class] 
  @name=   params[:name].split.first.capitalize
  @email=  params[:email]
  @level=  params[:class].split[1..2].join
  date=   params[:class].split.first
  

  session = GoogleDrive.login("james.jurkiewicz12@gmail.com", "JboSelect1")

    # First worksheet of
    # https://docs.google.com/spreadsheet/ccc?key=pz7XtlQC-PYx-jrVMJErTcg
    ws = session.spreadsheet_by_key("1aqlkV2gAxOQ_Bpd_E43fBJpF9KMb47OLxV9fqGvwOcw").worksheets[0]
      # Dumps all cells.
      for row in ws.num_rows+1..ws.num_rows+1
        for col in 1..ws.num_cols
         ws[row, 1]= @name
         ws[row, 2]= @email
         ws[row, 3]= params[:class]
        end
      end
      ws.save

      if classes=="september beginner 1 6pm"
        i=2
        elsif classes=="september beginner 2 7pm"
        i=3
        elsif classes=="september beginner 1 8pm"
        i=4
        elsif classes=="november beginner 1 6pm"
        i=5
        elsif classes=="november beginner 2 7pm"
        i=6
        elsif classes=="november beginner 2 8pm"
        i=7
      end
      puts ws[i,8]

    if ws[i,8].to_i >= 0 

=begin
      Pony.mail( 
          :to => @email,
          #:bcc => "anneka@",
          :subject => "Body and Pole Guernsey confirmation",
          :body => erb(:email, :layout => false),
        # :attachments => {File.basename("#{H&F_Declaration}") => File.read("#{H&F_Declaration}")},
        # :attachments => {"H&F_Declaration.docx" => File.read("/H&F_Declaration.docx"), "hello.txt" => "hello!"}   
          )
  =end
=end
    Pony.mail(:to => 'james.jurkiewicz12@gmail.com', :subject => "Wow - an email", :body=>"Hi. This is your program speaking. Bye.")
      erb :thankyou
    else 
      erb :failure
    end

end 
