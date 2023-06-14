require 'rails_helper'

RSpec.describe 'User Registration API' do
  describe 'POST /api/v0/users' do
    it 'can create a user' do
      user_params = {
        email: "testing@test.com",
        password: "password",
        password_confirmation: "password"
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      user = JSON.parse(response.body, symbolize_names: true)

      expect(user).to be_a Hash
      expect(user).to have_key :data
      expect(user[:data]).to be_a Hash
      expect(user[:data]).to have_key :id
      expect(user[:data][:id]).to be_a String
      expect(user[:data]).to have_key :type
      expect(user[:data][:type]).to eq('users')
      expect(user[:data]).to have_key :attributes
      expect(user[:data][:attributes]).to be_a Hash
      expect(user[:data][:attributes]).to have_key :email
      expect(user[:data][:attributes][:email]).to be_a String
      expect(user[:data][:attributes]).to have_key :api_key
      expect(user[:data][:attributes][:api_key]).to be_a String
      expect(user[:data][:attributes]).to_not have_key :password_digest
    end

    it 'returns an error if email is already taken; status 409' do
      User.create!(email: "testing@test.com", password: "password", api_key: "lfdkgj34t98sd34dfhj")
      user_params = {
        email: "testing@test.com",
        password: "password",
        password_confirmation: "password"
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(409)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to be_a Array
      expect(error[:errors][0]).to be_a Hash
      expect(error[:errors][0]).to have_key :detail
      expect(error[:errors][0][:detail]).to eq("Validation failed: Email has already been taken")
    end

    it 'returns an error if the passwords do not match; status 400' do
      user_params = {
        email: "whatever@example.com",
        password: "password",
        password_confirmation: "password1"
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(400)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to be_a Array
      expect(error[:errors][0]).to be_a Hash
      expect(error[:errors][0]).to have_key :detail
      expect(error[:errors][0][:detail]).to eq("Passwords do not match")
    end

    it 'returns an error if field is missing; status 422' do
      user_params = {
        email: "",
        password: "password",
        password_confirmation: "password"
      }
      headers = {"CONTENT_TYPE" => "application/json"}
      post "/api/v1/users", headers: headers, params: JSON.generate(user_params)

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      error = JSON.parse(response.body, symbolize_names: true)

      expect(error).to be_a Hash
      expect(error).to have_key :errors
      expect(error[:errors]).to be_a Array
      expect(error[:errors][0]).to be_a Hash
      expect(error[:errors][0]).to have_key :detail
      expect(error[:errors][0][:detail]).to eq("Validation failed: Email can't be blank")
    end
  end
end