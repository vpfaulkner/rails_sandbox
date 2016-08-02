require 'rails_helper'

feature 'Resource Input', js: true do
  before(:each) do
    visit '/'
  end

  scenario 'user changes the name' do
    page.all(:xpath, '//input[@name="name"]').first.set('Person')
    find('a', text: 'Controller').click # Unfocuses input to trigger change

    expect(page).to have_content 'app/controllers/admin/people_controller.rb'
    expect(page).to have_content 'class PeopleController'
  end

  scenario 'user changes the namespace' do
    page.all(:xpath, '//input[@name="namespace"]').first.set('V1')
    find('a', text: 'Controller').click # Unfocuses input to trigger change

    expect(page).to have_content 'app/controllers/v1/users_controller.rb'
    expect(page).to have_content 'module V1'
  end

  scenario 'user changes the CRUD' do
    expect(page).to have_content 'def create'

    page.find('select#crud', visible: :all).unselect 'Create', visible: :all
    find('a', text: 'Controller').click # Unfocuses input to trigger change

    expect(page).not_to have_content 'def create'
  end

  scenario 'user changes existing attribute name' do
    expect(page).to have_content '.permit(:name,'
    expect(page).not_to have_content '.permit(:last_name,'

    find('.attribute-button').click
    page.all(:xpath, '//input[@value="Name"]').first.set('Last Name')
    find('a', text: 'Controller').click # Unfocuses input to trigger change

    expect(page).to have_content '.permit(:last_name,'
    expect(page).not_to have_content '.permit(:name,'
  end

  scenario 'user changes existing attribute type' do
    find('a', text: 'Views').click

    expect(page).to have_content 'f.text_field name'
    expect(page).not_to have_content 'f.number_field name'

    find('.attribute-button').click
    all(:xpath, '//option[@value="integer"]', visible: :all).first.select_option
    find('a', text: 'Views').click

    expect(page).to have_content 'f.number_field name'
  end

  scenario 'user adds new attribute' do
    expect(page).not_to have_content '.permit(:height,'
    find('a', text: 'Views').click
    expect(page).not_to have_content 'f.number_field height'

    find('.attribute-button').click
    all('.disabled-attribute').first.click
    page.all(:xpath, '//input[@name="attribute-name"]').last.set('Height')
    all(:xpath, '//option[@value="integer"]', visible: :all)[-2].select_option
    find('a', text: 'Views').click

    expect(page).to have_content 'f.number_field height'
    find('a', text: 'Controller').click
    expect(page).to have_content '.permit(:name, :email, :height'
  end

  scenario 'user removes attribute' do
    expect(page).to have_content '.permit(:name,'

    find('.attribute-button').click
    within(all('.attribute-row').first) do
      all('.delete.icon').first.trigger('click')
    end

    expect(page).not_to have_content '.permit(:name,'
  end

  scenario 'user changes to singular' do
    find('a', text: 'Routes').click
    expect(page).to have_content 'resources :user'

    check 'singular'
    find('a', text: 'Routes').click

    expect(page).to have_content 'resource :user'
  end
end
