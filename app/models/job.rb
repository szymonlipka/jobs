class Job < ActiveRecord::Base
  validates :id_char, uniqueness: true, length: { is: 1 }, presence: true
  validates :name, presence: true

  def self.order_by_dependencies(string)
    return string if string.size == 0 # already sorted
    if string.size == 1
      if job = Job.find_by(id_char: string)
        if job.more_important_jobs.include?(string)
          raise 'jobs can’t depend on themselves'
        else
          return string
        end
      else
        return ''
      end
    end
    swapped = true
    jobs = Job.where(id_char: string.split(''))
    number_of_circles = 0
    ##
    # since circling without end in this problem is possible the loop stops when it reaches max number of
    # circles and raises an error
    while swapped && number_of_circles < string.size ** 2 + 1 do 
      swapped = false
      i = 0
      while i < string.size - 1
        if job = jobs.detect {|f| f[:id_char] == string[i]}
          if job.more_important_jobs
            if job.more_important_jobs.include?(string[i])
              raise 'jobs can’t depend on themselves'
            else
              # next line takes common part of everything thats after current character and characters
              # which are more important then current
              chars_to_move = (string[i..string.size-1].chars & job.more_important_jobs.chars).join
              if !chars_to_move.empty?
                string.delete!(chars_to_move)
                string.insert(i, chars_to_move)
                i += chars_to_move.size
                swapped = true
              end
            end
          end
        else
          string.delete!(string[i])
        end
        i+=1
      end
      number_of_circles += 1
    end
    if swapped # loop ended because of reaching max number of circles and swap still was made then it raises error
      raise 'Dependencies circuled'
    else
      string
    end
  end

end
