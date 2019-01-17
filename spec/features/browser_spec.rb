require 'rails_helper'

RSpec.feature "Browsers", type: :feature do
  describe "the signin process", type: :feature do
    it "signs me in" do
      visit '/'
      click_link 'Регистрация'
      within("#new_user") do
        fill_in 'Email', with: 'user@test.com'
        fill_in 'Пароль', with: 'password'
        fill_in 'Подтверждение пароля', with: 'password'
      end
      click_button 'Регистрация'
      expect(page).to have_content 'В течение нескольких минут вы получите письмо с инструкциями по подтверждению вашей учётной записи.'
      open_email('user@test.com')
      expect(current_email).to have_content 'Добро пожаловать, user@test.com!'
      current_email.click_link 'Подтвердить аккаунт'
      expect(page).to have_content 'Ваша учётная запись успешно подтверждена.'
    end

    it "reconfirms me" do
      User.create!(email: "user@test.com", password: "password")
      visit '/users/sign_up'
      click_link 'Не получили письмо с подтверждением?'
      fill_in 'Email', with: 'user@test.com'
      click_button 'Отправить подтверждение снова'
      expect(page).to have_content 'В течение нескольких минут вы получите письмо с инструкциями по подтверждению вашей учётной записи.'
      open_email('user@test.com')
      expect(current_email).to have_content 'Добро пожаловать, user@test.com!'
      current_email.click_link 'Подтвердить аккаунт'
      expect(page).to have_content 'Ваша учётная запись успешно подтверждена.'
    end

    it "resets my password" do
      user = User.create!(email: "user@test.com", password: "password")
      user.confirm
      visit '/users/sign_in'
      click_link 'Забыли пароль?'
      fill_in 'Email', with: 'user@test.com'
      click_button 'Отправить сброс пароля'
      expect(page).to have_content 'В течение нескольких минут вы получите письмо с инструкциями по восстановлению вашего пароля.'
      open_email('user@test.com')
      expect(current_email).to have_content 'Здраствуйте, user@test.com!'
      current_email.click_link 'Изменить пароль'
      expect(page).to have_content 'Изменение пароля'
      fill_in 'Пароль', with: 'new_password'
      fill_in 'Подтверждение пароля', with: 'new_password'
      click_button 'Изменить пароль'
      expect(page).to have_content 'Ваш пароль успешно изменён. Теперь вы вошли в систему.'
    end
  end

  describe "the login process", type: :feature do
    it "logs me in" do
      user = User.create!(email: "user@test.com", password: "password")
      user.confirm
      visit '/'
      click_link 'Вход'
      within("#new_user") do
        fill_in 'Email', with: 'user@test.com'
        fill_in 'Пароль', with: 'password'
      end
      click_button 'Войти'
      expect(page).to have_content 'Вход в систему выполнен.'
      expect(page).to have_content 'Пользователь: user@test.com'
    end

    it "not logs me in without confirm" do
      User.create!(email: "user@test.com", password: "password")
      visit '/'
      click_link 'Вход'
      within("#new_user") do
        fill_in 'Email', with: 'user@test.com'
        fill_in 'Пароль', with: 'password'
      end
      click_button 'Войти'
      expect(page).to have_content 'Вы должны подтвердить вашу учётную запись.'
    end
  end
end
