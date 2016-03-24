class Job < ActiveRecord::Base
  validates :id_char, uniqueness: true
  
  def self.order_by_dependencies(string)
    return string if string.size <= 1 # already sorted
    swapped = true
    jobs = Job.where(id_char: string.split(''))
    number_of_circulments = 0
    ##
    # since circuling in this problem is possible the loop stops when it reaches max number of
    # circulments and raises error
    while swapped && number_of_circulments < string.size ** 2 + 1 do 
      swapped = false
      i = 0
      while i < string.size - 1
        job = jobs.detect {|f| f[:id_char] == string[i]}
        if job.more_important_jobs && job.more_important_jobs.include?(string[i])
          raise ArgumentError
        elsif job.more_important_jobs
          chars_to_move = (string[i..string.size-1].chars & job.more_important_jobs.chars).join
          if !chars_to_move.empty?
            string.delete!(chars_to_move)
            string.insert(i, chars_to_move)
            i += chars_to_move.size
            swapped = true
          end
        end
        i+=1
      end
      number_of_circulments += 1
    end
    if swapped # loop ended because of reaching max number of circulments and swap still was made then it raises error
      raise 'Dependencies circuled'
    else
      string
    end
  end

end
