class Auth0Controller < ApplicationController
  include DashboardHelper

  def callback
    # This stores all the user information that came from Auth0 and the IdP
    sign_in_user request.env['omniauth.auth']

    redirect_to_dashboard
  end

  def failure
    # show a failure page or redirect to an error page
    @error_message = request.params['message']
  end

  def dev_force_sign_in
    sign_in_user({
      "provider" => "auth0",
      "uid" => "email|57ce2425e618d33da217b48d",
      "info"=> {
        "name" => "pgwsmith+test3@gmail.com",
        "email"=>"pgwsmith+test3@gmail.com",
        "nickname"=>"pgwsmith+test3",
        "first_name"=>nil,
        "last_name"=>nil,
        "location"=>nil,
        "image" => "https://s.gravatar.com/avatar/8037c7eb2a657d20e029b37c6561b720?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fpg.png"
      },
      "credentials"=> {
        "token" => "X1KO3OGKvGV8er9O",
        "expires"=>true,
        "id_token"=> "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6InBnd3NtaXRoK3Rlc3QzQGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJpc3MiOiJodHRwczovL2J1cm50Y2FyYW1lbC5hdXRoMC5jb20vIiwic3ViIjoiZW1haWx8NTdjZTI0MjVlNjE4ZDMzZGEyMTdiNDhkIiwiYXVkIjoiWmVMWG9WMWlTbWJUTWNqQjFLQzlMV3Z3Skh1dGZYYkIiLCJleHAiOjE0NzMxNjQ4ODIsImlhdCI6MTQ3MzEyODg4Mn0.p54m7gyZ6ORr_wUxEEUx3dl3t_bIuUMbh2XbyfP0tIw",
        "token_type"=>"Bearer"
      },
      "extra"=> {
        "raw_info"=> {
          "email"=>"pgwsmith+test3@gmail.com", "email_verified"=>true, "clientID"=>"ZeLXoV1iSmbTMcjB1KC9LWvwJHutfXbB",
          "updated_at"=>"2016-09-06T02:28:02.036Z",
          "picture"=>"https://s.gravatar.com/avatar/8037c7eb2a657d20e029b37c6561b720?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fpg.png",
          "user_id"=>"email|57ce2425e618d33da217b48d",
          "name"=>"pgwsmith+test3@gmail.com",
          "nickname"=>"pgwsmith+test3",
          "identities"=>[{"user_id"=>"57ce2425e618d33da217b48d", "provider"=>"email", "connection"=>"email", "isSocial"=>false}],
          "created_at"=>"2016-09-06T02:04:37.995Z",
          "sub"=>"email|57ce2425e618d33da217b48d"
        }
      }
    })

    redirect_to_dashboard
  end
end
