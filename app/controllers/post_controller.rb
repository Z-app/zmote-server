class PostController < ApplicationController

  def insert_user
    name = params[:name]
    email = params[:email]
    render :json => User.create(:name => name, :email => email)
  end


=begin
  Inserts program in the database with the url:
  rails.z-app.se/post/insert_program
=end
  def insert_program
    name = params[:name]
    duration = params[:duration]
    start_time = params[:starttime]
    description = params[:description]
    short_description = params[:shortdescription]
    channel_name = params[:channel_name]
    theChannel = Channel.where(:name => channel_name)

    theProgram = Program.new
    theProgram.name = name
    # Changes the '.' to ':'. Otherwise the Time.parse thinks the time is a date.
    for i in 0..duration.length
      if duration[i] == '.'
        duration[i] = ':'
      end
    end
    theProgram.duration = Time.parse(duration)
    theProgram.starttime = DateTime.parse(start_time)
    theProgram.description = description
    theProgram.shortdescription = short_description

    theProgram.channel_id = theChannel
    # render :json => theProgram.save
  end

  def insert_channel
    name = params[:name]
    iconURL = params[:iconURL]
    channelURL = params[:channelURL]
    theChannel = Channel.new
    theChannel.name = name
    theChannel.iconURL = iconURL
    theChannel.channelURL = channelURL
    render :json => theChannel.save

  end

  def insert_post
    username = params[:username]
    program_name = params[:program_name]
    content = params[:content]
    timestamp = DateTime.parse(params[:timestamp])

    theUser = User.where(:name => username)
    if theUser != []
      theProgram = Program.where(:name => program_name)

      thePost = Post.new
      thePost.user_id = theUser
      thePost.program = theProgram
      thePost.content = content
      thePost.timestamp = timestamp
      render :json => thePost.save
    else
      render :json => nil
    end
  end
end