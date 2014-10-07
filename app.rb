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

get '/disclaimer' do 
  erb :disclaimer
end


get '/sign_up'  do

   session = GoogleDrive.login("bodyandpole.gsy@gmail.com", "9carryonbrynn99")
    #First worksheet of
    # https://docs.google.com/spreadsheets/d/1eiEXfZT4PNEdO3tScgJ1toQEwRxZdL_j5X12sNvnP8o/edit#gid=0
    ws = session.spreadsheet_by_key("1eiEXfZT4PNEdO3tScgJ1toQEwRxZdL_j5X12sNvnP8o").worksheets[0]

    @nov_beg_3_6 = ws[2,8]
    @nov_beg_2_7 = ws[3,8] 
    @nov_beg_1_8 = ws[4,8]
    @jan_beg_1_6 = ws[5,8] 
    @jan_beg_1_7 = ws[6,8]
    @jan_beg_2_8 = ws[7,8] 


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
  @level=  params[:class].split[1]+" "+params[:class].split[2]
  date=   params[:class].split.first

  if params[:class].split[2]=1
    @cost=80
  else
    @cost=85
  end
  
  if classes=="november 7th 2014 beginner/intermediate level 3 6pm"
    i=2
    elsif classes=="november 7th 2014 beginner level 2 7pm"
    i=3
   elsif classes=="November 7th 2014 beginner level 1 8pm"
    i=4
   elsif classes=="January 2015 beginner level 1 6pm"
    i=5
   elsif classes=="January 2015 beginner level 1 7pm"
    i=6
   elsif classes=="January 2015 beginner level 2 8pm"
    i=7
  end
  puts "THE VALUE FOR I AND SPREADSHEET VALUE ARE:"
  puts i 
  #puts p ws[i.to_i,8]
  session = GoogleDrive.login("bodyandpole.gsy@gmail.com", "9carryonbrynn99")
    ws = session.spreadsheet_by_key("1eiEXfZT4PNEdO3tScgJ1toQEwRxZdL_j5X12sNvnP8o").worksheets[0]
      @i=ws[i.to_i,8].to_i
      puts @i

  if @i >= 1 

    session = GoogleDrive.login("bodyandpole.gsy@gmail.com", "9carryonbrynn99")

      # First worksheet of
      # https://docs.google.com/spreadsheets/d/1eiEXfZT4PNEdO3tScgJ1toQEwRxZdL_j5X12sNvnP8o/edit#gid=0
      ws = session.spreadsheet_by_key("1eiEXfZT4PNEdO3tScgJ1toQEwRxZdL_j5X12sNvnP8o").worksheets[0]
        # Dumps all cells.
        for row in ws.num_rows+1..ws.num_rows+1
          for col in 1..ws.num_cols
           ws[row, 1]= @name
           ws[row, 2]= @email
           ws[row, 3]= params[:class]
           ws[row, 4]= params[:disclaimer]
          end
        end
        ws.save

      Pony.mail(
        :to => @email,
        :subject => "Body and Pole Guernsey confirmation",
        :body => erb(:email, :layout => false),
      # :bcc => anneka@...
        :attachments => {"H&F_Declaration.docx" => File.read("public/H&F_Declaration.docx")},
        :via => 'smtp',
        :from => 'Body and Pole Guernsey',
        :via => :smtp,
        :via_options => {
          :address              => 'smtp.gmail.com',
          :port                 => '587',
          :enable_starttls_auto => true,
          :user_name            => 'bodyandpole.gsy@gmail.com',
          :password             => '9carryonbrynn99',
          :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
          :domain               => "localhost.localdomain" # the HELO domain provided by the client to the server
      })

    erb :thankyou

  else

      erb :failure
      
  end
end
