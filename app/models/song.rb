class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes


    def genre_name=(name)
      self.genre = Genre.find_or_create_by(name: name)
    end

    def genre_name
      if self.genre
        self.genre.name
      else
        nil
      end
    end

    def artist_name=(name)
      self.artist = Artist.find_or_create_by(name: name)
    end

    def artist_name
      if self.artist
        self.artist.name
      else
        nil
      end
    end

    def note_contents=(content)
      # binding.pry
      # content = content.reject!
      content.each do |each_note|
        # binding.pry
        if !Note.find_by(content: each_note)
          self.notes << Note.create(content: each_note)

        end
      end
    end

    def note_contents
        content_arr = []
        self.notes.collect do |note|
          if note.content != nil
            content_arr << note.content
          end
        end
        content_arr.reject {|c| c.empty?}


    end

end
