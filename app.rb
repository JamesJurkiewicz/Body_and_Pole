require 'sinatra'
require 'pony'
require 'json'
require 'rubygems'
#require 'google/api_client'
require 'google_drive'

# Authorizes with OAuth and gets an access token.
=begin
client = Google::APIClient.new(
  :application_name => 'bodyandpole',
  :application_version => '2.0'
)
auth = client.authorization
auth.client_id = "804100857671-emvn1rtpr41bvojv6qqt14ulkdqmcklg.apps.googleusercontent.com"
auth.client_secret = "cOWPI8V-XDeIumMV4pGLQS8-"
auth.scope =
    "https://www.googleapis.com/auth/drive " +
    "https://docs.google.com/feeds/ " +
    "https://docs.googleusercontent.com/ " +
    "https://spreadsheets.google.com/feeds/"
auth.redirect_uri = "urn:ietf:wg:oauth:2.0:oob"
print("1. Open this page:\n%s\n\n" % auth.authorization_uri)
print("2. Enter the authorization code shown in the page: ")
auth.code = $stdin.gets.chomp
auth.fetch_access_token!
access_token = auth.access_token
=end

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

  #only here to remember log in deets #session = GoogleDrive.login("bodyandpole.gsy@gmail.com", "9carryonbrynn99")
  
   # Creates a session.
  session = GoogleDrive.login("bodyandpole.gsy@gmail.com", "9carryonbrynn99")
  #session = GoogleDrive.login_with_oauth(access_token)
  #First worksheet of
  # https://docs.google.com/spreadsheets/d/1eiEXfZT4PNEdO3tScgJ1toQEwRxZdL_j5X12sNvnP8o/edit#gid=0
  ws = session.spreadsheet_by_key("1G5UpwugCPQvUn5CYo17xnuQ8PiMk1y2E_1uGc5vc-XI").worksheets[0]

  #ws = session.spreadsheet_by_key("1eiEXfZT4PNEdO3tScgJ1toQEwRxZdL_j5X12sNvnP8o").worksheets[0]

  @jan_1_645 = ws[2,2]
  @jan_1_745 = ws[3,2] 
  @jan_2_7 = ws[4,2]
  @jan_3_8 = ws[5,2] 
  @jan_chor = ws[6,2] 

    puts @jan_1
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

  if params[:disclaimer]= "confirmed"
    @classes = params[:class] 
    @name=   params[:name].split.first.capitalize
    @email=  params[:email]
    @level=  params[:class].split[2]
    @date=   params[:class].split.first

    if params[:class].split[2]=1
      @cost=80
    else
      @cost=85
    end
    
    if @classes=="jan lvl 1 6:45pm"
      i=2
      elsif @classes=="jan lvl 1 7:45pm"
      i=3
     elsif @classes=="jan lvl 2 7pm"
      i=4
     elsif @classes=="jan lvl 3 8pm"
      i=5
     elsif @classes=="jan choreography"
      i=6
    end
    puts "THE VALUE FOR I AND SPREADSHEET VALUE ARE:"
    puts i 
    #puts p ws[i.to_i,8]


    # Creates a session.
     session = GoogleDrive.login("bodyandpole.gsy@gmail.com", "9carryonbrynn99")
    ws = session.spreadsheet_by_key("1G5UpwugCPQvUn5CYo17xnuQ8PiMk1y2E_1uGc5vc-XI").worksheets[0]

      @i=p ws[i.to_i,2].to_i
      puts @i

    if @i >= 1 
      # Dumps all cells.
      for row in ws.num_rows+1..ws.num_rows+1
        for col in 1..ws.num_cols
         ws[row, 1]= @name
         ws[row, 2]=params[:name].split(' ',2).last.capitalize
         ws[row, 3]= @email
         ws[row, 4]= params[:phone]
         ws[row, 5]= params[:class]
         ws[row, 6]= params[:disclaimer]
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
        :from => 'Body & Pole Limited',
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
  else 
    erb :no_disclaimer
  end
end
