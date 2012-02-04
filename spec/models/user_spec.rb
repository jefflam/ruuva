# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  name            :string(255)
#

require 'spec_helper'

describe User do

	before do
		@user = User.new(name: "Example User", email: "email@example.com", password: "foobar", password_confirmation: "foobar" ) 
	end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }

	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when name is too long" do
		before { @user.name = "a" * 51 }
		it { should_not be_valid }
	end

	describe "when email format is invalid" do
		invalid_addresses = %w[user@foo,com user_at_foo.org example.user@foo. ]
		invalid addresses.each do |invalid_address|
			before { @user.email = invalid_address }
			it { should_not be_valid }
		end
	end

	describe "when email format is valid" do
		valid_addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp ]
		valid_addresses.each do |valid_address|
			before { @user.email = valid_address }
			it { should be_valid }
		end
	end

	describe "when email is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it { should_not be_valid }
	end

	describe "when password is not present" do
		before { @user.password = @user.password_confirmation = " " }
		it { should_not be_valid }
	end
	
	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end
end
