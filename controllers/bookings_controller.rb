require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative( '../models/booking.rb' )
require_relative( '../models/member.rb' )
require_relative( '../models/session.rb' )
also_reload( '../models/*' )

get '/bookings' do
  @bookings = Booking.all
  erb ( :"bookings/index" )
end

get '/bookings/new' do
  @members = Member.all
  @sessions = Session.available_sessions
  erb(:"bookings/new")
end

get '/bookings/:id' do
  @booking = Booking.find(params['id'].to_i)
  erb( :"bookings/show" )
end

post '/bookings' do
  booking = Booking.new(params)
  booking.save
  redirect to("/bookings")
end

post '/bookings/:id/delete' do
  booking = Booking.find(params['id'])
  booking.delete
  redirect to '/bookings'
end

post '/bookings/:id' do
  booking = Booking.new(params)
  booking.update
  redirect to "/bookings/#{params['id']}"
end
