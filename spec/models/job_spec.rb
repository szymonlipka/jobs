require 'rails_helper'

RSpec.describe Job, type: :model do

  describe 'db columns' do
    it { should have_db_column :name }
    it { should have_db_column :id_char }
  end

  describe 'validations' do
    it { should validate_uniqueness_of :id_char }
    it { should validate_presence_of :id_char }
    it { should validate_presence_of :name }
  end

  describe 'ordering method' do

    it 'brings empty string if there is empty string passed' do
      expect(Job.order_by_dependencies("")).to eq("")
    end

    describe 'non-empty string passed' do
      before(:each) do
        id_char = 'a'
        10.times {Job.create(name: 'Job', id_char: id_char.next!)}
      end
      it 'brings same orders as passed when no dependencies is set in passed jobs' do
        expect(Job.order_by_dependencies("bcdefghij")).to eq("bcdefghij")
      end
      it 'brings good order when one, simple dependency is set in passed jobs' do
        Job.find_by(id_char: 'e').update_attribute(:more_important_jobs, 'f')
        expect(Job.order_by_dependencies("bcdefghij")).to eq("bcdfeghij")
      end
      it 'brings good order when complicated dependencies are set in passed jobs' do
        Job.find_by(id_char: 'd').update_attribute(:more_important_jobs, 'h')
        Job.find_by(id_char: 'i').update_attribute(:more_important_jobs, 'dh')
        Job.find_by(id_char: 'f').update_attribute(:more_important_jobs, 'idh')
        Job.find_by(id_char: 'g').update_attribute(:more_important_jobs, 'fidh')
        Job.find_by(id_char: 'e').update_attribute(:more_important_jobs, 'gfidh')
        Job.find_by(id_char: 'b').update_attribute(:more_important_jobs, 'hdifge')
        expect(Job.order_by_dependencies("bcdefghij")).to eq("hdifgebcj")
      end
      it 'rises argument error when job is self-dependent' do
        Job.find_by(id_char: 'b').update_attribute(:more_important_jobs, 'b')
        expect{Job.order_by_dependencies("bcdefghij")}.to raise_error 'jobs can’t depend on themselves'
      end
      it 'rises error when dependencies are circuled' do
        Job.find_by(id_char: 'c').update_attribute(:more_important_jobs, 'e')
        Job.find_by(id_char: 'd').update_attribute(:more_important_jobs, 'c')
        Job.find_by(id_char: 'e').update_attribute(:more_important_jobs, 'd')
        expect{Job.order_by_dependencies("bcdefghij")}.to raise_error 'Dependencies circuled'
      end
    end
  end
end
