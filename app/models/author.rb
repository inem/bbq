module AuthorTypes
  def author(object)
    if object.user.present?
      LoggedInAuthor.new(object.user)
    else
      NonLoggedInAuthor.new(object)
    end
  end

  class LoggedInAuthor
    def initialize(user)
      @user = user
    end

    def name
      @user.name
    end

    def email
      @user.email
    end
  end

  class NonLoggedInAuthor
    def initialize(object)
      @object = object
    end

    def name
      @object.user_name
    end

    def email
      @object.user_email
    end
  end
end