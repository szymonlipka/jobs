class Job < ActiveRecord::Base
  validates :id_char, uniqueness: true, length: { is: 1 }, presence: true
  validates :name, presence: true

  # next method is designed to order string of characters which represent jobs in db taking jobs which
  # are more important and moving them into left side of each character, main idea of solving the problem
  # is to use upgraded bubble sort 
  def self.order_by_dependencies(string)
    return string if string.size == 0
    if string.size == 1
      if job = Job.find_by(id_char: string)
        raise 'jobs can’t depend on themselves' if job.more_important_jobs.include?(string)
        return string
      else
        return ''
      end
    end
    swapped = true
    jobs = Job.where(id_char: string.split(''))
    number_of_circles = 0
    ##
    # Since in this problem circling without end is possible, the loop stops when it reaches max number of
    # circles and as error is raised
    while swapped && number_of_circles < string.size ** 2 + 1 do 
      swapped = false
      i = 0
      while i < string.size - 1
        if job = jobs.detect {|f| f[:id_char] == string[i]}
          if job.more_important_jobs.present?
            raise 'jobs can’t depend on themselves' if job.more_important_jobs.include?(string[i])
            # Next line takes common part of everything thats after current character and characters
            # which are more important then current
            chars_to_move = (string[i...string.size].chars & job.more_important_jobs.chars).join
            if chars_to_move.present?
              string.delete!(chars_to_move)
              string.insert(i, chars_to_move)
              i += chars_to_move.size # Possition of currently taken char moved after inserting
                                      # chars_to_move behind this char so i has so move ahead
              swapped = true
            end
          end
        else
          string.delete!(string[i]) # If variable jobs doesn't include currently taken char then the 
                                    # char doesn't represent any job so it has to be deleted
        end
        i+=1
      end
      number_of_circles += 1
    end
    # Loop ended because of reaching max number of circles and swap still was made then it raises error
    swapped ? raise('Dependencies circuled') : string
  end

end
