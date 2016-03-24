# Feature: Home page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
describe 'Home page' do

  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see "Welcome"
  it 'enables sorting jobs' do
    id_char = 'a'
    10.times {Job.create(name: 'Job', id_char: id_char.next!)}
    Job.find_by(id_char: 'd').update_attribute(:more_important_jobs, 'h')
    Job.find_by(id_char: 'i').update_attribute(:more_important_jobs, 'dh')
    Job.find_by(id_char: 'f').update_attribute(:more_important_jobs, 'idh')
    Job.find_by(id_char: 'g').update_attribute(:more_important_jobs, 'fidh')
    Job.find_by(id_char: 'e').update_attribute(:more_important_jobs, 'gfidh')
    Job.find_by(id_char: 'b').update_attribute(:more_important_jobs, 'hdifge')
    visit root_path
    find('#sort_jobs_string').set 'bcdefghij'
    click_on 'Sort'
    expect(page).to have_content 'hdifgebcj'
  end

  it 'enables creating job' do
    visit root_path
    find('#job_name').set 'Job'
    find('#job_id_char').set 'h'
    find('#job_more_important_jobs').set 'abc'
    click_on 'Create Job'
    expect(Job.last.name).to eq('Job')
    expect(Job.last.id_char).to eq('h')
    expect(Job.last.more_important_jobs).to eq('abc')
    expect(page).to have_content 'Job created'
  end

end
