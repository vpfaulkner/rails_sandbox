require 'rails_helper'

feature 'Comoponent Code', js: true do
  let(:controller_code) do
    <<-CODE
    module Admin
      class UsersController
        before_action :set_user, only: [:show, :update, :edit, :destroy]

        def index
          @user = User.all
        end

        def show
        end

        def new
          @user = User.new
        end

        def edit
        end

        def create
          @user = User.new(user_params)

          if @user.save
            redirect_to @user, notice: 'user was successfully created.'
          else
            render :new
          end
        end

        def update
          if @user.update(user_params)
            redirect_to @user, notice: 'user was successfully updated.'
          else
            render :edit
          end
        end

        def destroy
          @user.destroy
          redirect_to users_url, notice: 'user was successfully destroyed.'
        end

        private

        def set_user
          @user = User.find(params[:id])
        end

        def user_params
          params.require(:user).permit(:name, :email)
        end
      end
    end
    CODE
  end

  let(:model_code) do
    <<-CODE
    module Admin
      class User < ApplicationRecord
      end
    end
    CODE
  end

  let(:new_html) do
    <<-CODE
    <h1>New User</h1>

    <%= render 'form', user: @user %>

    <%= link_to 'Back', users_path %>
    CODE
  end

  let(:show_html) do
    <<-CODE
    <p>
      <strong>Name:</strong>
      <%= @user.name %>
    </p>
    <p>
      <strong>Email:</strong>
      <%= @user.email %>
    </p>

    <%= link_to 'Edit', edit_user_path(@user) %> |
    <%= link_to 'Back', users_path %>
    CODE
  end

  let(:edit_html) do
    <<-CODE
    <h1>Editing User</h1>

    <%= render 'form', user: @user %>

    <%= link_to 'Show', @user %> |
    <%= link_to 'Back', users_path %>
    CODE
  end

  let(:index_html) do
    <<-CODE
    <h1>Users</h1>

    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Email</th>
          <th colspan="3"></th>
        </tr>
      </thead>

      <tbody>
        <% @users.each do |user| %>
          <tr>
            <td><%= user.name %></td>
            <td><%= user.email %></td>
            <td><%= link_to 'Show', user %></td>
            <td><%= link_to 'Edit', edit_user_path(user) %></td>
            <td><%= link_to 'Destroy', user, method: :delete, data: { confirm: 'Are you sure?' } %></td>
          </tr>
        <% end %>
      </tbody>
    </table>

    <br>

    <%= link_to 'New User', new_user_path %>
    CODE
  end

  let(:form_html) do
    <<-CODE
    <%= form_for(user) do |f| %>
      <% if user.errors.any? %>
        <div id="error_explanation">
          <h2><%= pluralize(user.errors.count, "error") %> prohibited this user from being saved:</h2>

          <ul>
          <% user.errors.full_messages.each do |message| %>
            <li><%= message %></li>
          <% end %>
          </ul>
        </div>
      <% end %>

      <div class="field">
        <%= f.label name %>
        <%= f.text_field name %>
      </div>

      <div class="field">
        <%= f.label email %>
        <%= f.text_field email %>
      </div>


      <div class="actions">
        <%= f.submit %>
      </div>
    <% end %>
    CODE
  end

  let(:routes_code) do
    <<-CODE
    Rails.application.routes.draw do
      namespace :admin do
        resources :user
      end
    end
    CODE
  end

  let(:raked_routes) do
    <<-CODE
              Prefix Verb   URI Pattern                    Controller#Action
    admin_user_index GET    /admin/user(.:format)          admin/user#index
                    POST   /admin/user(.:format)          admin/user#create
      new_admin_user GET    /admin/user/new(.:format)      admin/user#new
    edit_admin_user GET    /admin/user/:id/edit(.:format) admin/user#edit
          admin_user GET    /admin/user/:id(.:format)      admin/user#show
                    PATCH  /admin/user/:id(.:format)      admin/user#update
                    PUT    /admin/user/:id(.:format)      admin/user#update
                    DELETE /admin/user/:id(.:format)      admin/user#destroy
    CODE
  end

  scenario 'user navigates to root' do
    visit '/'
    expect(page).to have_content 'Rails Sandbox'

    expect(page).to have_content 'app/controllers/admin/users_controller.rb'
    expect(page).to have_content controller_code

    find('a', text: 'Model').click
    expect(page).to have_content 'app/models/admin/user.rb'
    expect(page).to have_content model_code

    find('a', text: 'Views').click
    expect(page).to have_content 'app/views/admin/users/new.html.erb'
    expect(page).to have_content new_html
    expect(page).to have_content 'app/views/admin/users/show.html.erb'
    expect(page).to have_content show_html
    expect(page).to have_content 'app/views/admin/users/edit.html.erb'
    expect(page).to have_content edit_html
    expect(page).to have_content 'app/views/admin/users/index.html.erb'
    expect(page).to have_content index_html
    expect(page).to have_content 'app/views/admin/users/_form.html.erb'
    expect(page).to have_content form_html

    find('a', text: 'Routes').click
    expect(page).to have_content 'config/routes.rb'
    expect(page).to have_content routes_code
    expect(page).to have_content 'rake routes'
    expect(page).to have_content raked_routes
  end
end
