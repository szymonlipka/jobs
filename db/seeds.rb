# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
id_char = 'a'
10.times {Job.create(name: 'Job', id_char: id_char.next!)}
Job.find_by(id_char: 'd').update_attribute(:more_important_jobs, 'h')
Job.find_by(id_char: 'i').update_attribute(:more_important_jobs, 'dh')
Job.find_by(id_char: 'f').update_attribute(:more_important_jobs, 'idh')
Job.find_by(id_char: 'g').update_attribute(:more_important_jobs, 'fidh')
Job.find_by(id_char: 'e').update_attribute(:more_important_jobs, 'gfidh')
Job.find_by(id_char: 'b').update_attribute(:more_important_jobs, 'hdifge')