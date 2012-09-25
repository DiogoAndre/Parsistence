module Parsistence
  module User
    include Parsistence::Model

    attr_accessor :PFUser
    
    RESERVED_KEYS = [:objectId, :username, :password, :email]

    def initialize(pf=nil)
      if pf
        self.PFObject = pf
      else
        self.PFObject = PFObject.objectWithClassName(self.class.to_s)
      end

      self
    end
    
    def PFObject=(value)
      @PFObject = value
      @PFUser = @PFObject
    end
    
    def PFUser=(value)
      self.PFObject = value
    end

    module ClassMethods
      include Parsistence::Model::ClassMethods

      def all
        query = PFQuery.queryForUser
        users = query.findObjects
        users
      end
      
      def currentUser
        if PFUser.currentUser
          return @current_user ||= self.new(PFUser.currentUser)
        end
        nil
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end
end
