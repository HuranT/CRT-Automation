from math import floor
from random import seed, random, choice

#https://faker.readthedocs.io/en/master/index.html
from faker import Faker
from faker.providers import person

fake = Faker()
fake.add_provider(person)
seed()  # init rand generator

def get_opp_reference():
    issn1 = floor(1000 + random() * 9999);
    issn2 = floor(1000 + random() * 1000);
    year = '16';
    integer = floor(10000 + random() * 88888);
    digitCheck = floor(random() * 5);

    return f"S{issn1}{issn2}{year}{integer}{digitCheck}"

def get_random_title():
    titles = ["Dr.", "Mr.", "Mrs.", "Ms."]
    return choice(titles)

def get_random_firstname():
    return fake.first_name()

def get_random_last_name():
    return fake.last_name()

def get_random_email(firstname, lastname, domain='elsevier.com.invalid'):
    return f"{firstname}.{lastname}@{domain}"

def get_random_building_number():
    return  fake.building_number()

def get_random_street_address():
    return fake.street_address()