require 'net/http'
require 'jwt'
require 'json'
require 'openssl'
require 'base64'

jwks_url = #'https://cognito-idp.eu-west-2.amazonaws.com/eu-west-2_6mJr60x9m/.well-known/jwks.json'
jwks_json = Net::HTTP.get(URI(jwks_url))
jwks = JSON.parse(jwks_json)

token = #"eyJraWQiOiJnc3RkNWRBOGFNS3BVRGFPdlBnQWRvbjhpZ3JGdkFDZkZ1b093RUhSTGlVPSIsImFsZyI6IlJTMjU2In0.eyJzdWIiOiI0cDQwcHFjZWlqZHZmbTkxM3A4Z2w1dmk2cCIsInRva2VuX3VzZSI6ImFjY2VzcyIsInNjb3BlIjoibWFhdC1jZC1hcGlcL3N0YW5kYXJkIiwiYXV0aF90aW1lIjoxNjk0NDQzNzM3LCJpc3MiOiJodHRwczpcL1wvY29nbml0by1pZHAuZXUtd2VzdC0yLmFtYXpvbmF3cy5jb21cL2V1LXdlc3QtMl82bUpyNjB4OW0iLCJleHAiOjE2OTQ0NDczMzcsImlhdCI6MTY5NDQ0MzczNywidmVyc2lvbiI6MiwianRpIjoiZjdiZWUyMDEtNWM4NC00MjcyLWE3YWMtNzZhNzc4MDY3MzFhIiwiY2xpZW50X2lkIjoiNHA0MHBxY2VpamR2Zm05MTNwOGdsNXZpNnAifQ.MhOqIMvQeJWFUtAGyCF0Ej0k2ud7oCdILgA0_Nte8dMPfsy4K-W1VEc1MPX68JRZ7nGwQML2HlXjVo2ROP_BEfvarcavuTs6udEME3FUS9A4zq8ZL1aKS6_chzE-8ndJLCiK-SqXY2-XfwWy2N8ZNpJSiC7Y_Nhxngop7K9HgI2JN2kVTcrmzLZQbf7l9Vhb0_Hep57EpLp40ooK82Jx6PoGAeBIXwaYi_IgP9tZ1HUJUuWP6ClLDlqlQilOoMU5cmrbyp6z2fawbUngfk-jBMVowuzCkVWrrFO6HlDn27r_lpXhyuNhnhPpQIJMgBBLQ8_2bk1jq5uIEsALFNKtTw"

header = JWT.decode(token, nil, false)[1]
jwk = jwks['keys'].find { |k| k['kid'] == header['kid'] }

modulus = Base64.urlsafe_decode64(jwk['n'])
exponent = Base64.urlsafe_decode64(jwk['e'])

rsa_public = OpenSSL::PKey::RSA.new
rsa_public.set_key(OpenSSL::BN.new(modulus, 2), OpenSSL::BN.new(exponent, 2), nil)

begin
  decoded_token = JWT.decode(token, rsa_public, true, { algorithm: 'RS256' })
  puts "Token is valid"
  puts "Public key for token: #{rsa_public}"
  puts "Decoded token: #{decoded_token}"
rescue JWT::DecodeError => e
  puts "Invalid token: #{e.message}"
end
