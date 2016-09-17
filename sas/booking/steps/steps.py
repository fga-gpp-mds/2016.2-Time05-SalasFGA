from aloe import step, world
from aloe_webdriver.util import find_field_by_id, find_any_field, find_field_by_value
from aloe_webdriver import TEXT_FIELDS
from selenium.common.exceptions import NoSuchElementException
from booking.models import UserProfile
from django.contrib.auth.models import User


@step(r'I type in "(.*)" to "(.*)"')
def fill_bootstrap_field(step, text, field):
	words_list = field.lower().split()
	words_list.insert(0, "id")
	id_field = "_".join(words_list)
	date_field = find_any_field(world.browser, TEXT_FIELDS, id_field)
	date_field.send_keys(text)


@step(r'I click on an element with id of "(.*)"')
def click_on_element_by_id(step, id):
	try:
		elem = world.browser.find_element_by_id(id)
	except NoSuchElementException:
		raise AssertionError("Element with ID '{}' not found.".format(id))
	elem.click()

@step(r'I click on an element "(.*)" called "(.*)"')
def click_on_element_by_value(step, value, typeelement):
	try:
		text = find_field_by_value(world.browser, typeelement, elementtext)
	except NoSuchElementException:
		raise AssertionError("Element not found.")
	text.click()

@step(r'I see "(.*)" on an element "(.*)"')
def find_element_value(step, elementtext, typeelement):
	try:
		text = find_field_by_value(world.browser, typeelement, elementtext)
	except NoSuchElementException:
		raise AssertionError("Element not found.")

@step(r'I register the user "(.*)" with the password "(.*)"')
def register_user(step, username, password):
	user = UserProfile()
	user.user = User()
	user.registration_number = "140016574"
	user.user.email = username
	user.user.first_name = "Usuário"
	user.user.set_password(password)
	user.save()

@step(r'I log in the user "(.*)" with the password "(.*)"')
def user_login(step, username, password):
	click_on_element_by_id(step, 'enter-button')
	fill_bootstrap_field(step, username, 'Username')
	fill_bootstrap_field(step, password, 'Password')
	click_on_element_by_id(step, 'btn-login')

