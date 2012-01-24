require 'spec_helper'

describe "Static pages" do

	subject { page }

	describe "Contact page" do
		before { visit contact_path }

		it { should have_selector("title", content: full_title("Contact Us")) }
	end

	describe "About page" do
		before { visit about_path }

		it { should have_selector("title", content: full_title("About Ruuva")) }
	end

	describe "Terms page" do
		before { visit terms_path }

		it { should have_selector("title", content: full_title("Terms & Conditions")) }
	end

	describe "Help page" do
		before { visit help_path }

		it { should have_selector("title", content: full_title("Ruuva Guide")) }
	end
end
