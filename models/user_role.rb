class UserRole
  include Tire::Model::Persistence

  associate :user
  associate :role

  property :role_id,             type: 'string', index: 'not_analyzed'
  property :user_id,             type: 'string', index: 'not_analyzed'
  property :created_at,          type: 'date', class: Time, default: Proc.new{ Time.now }

  def self.has_role?(user, id)
    search(size: 1){ |s| s.query{ |q| q.term :user_id, user.id } }.each do |role|
      if role.id == id
        return true
        break
      end
    end
    false
  end

  def self.find_by_user_id(user_id, role)
    search(size: 1) do 
      query do
        filtered do
          query{ all }
          filter :term, user_id: user_id
          filter :term, role_id: role.id
        end
      end
    end.first
  end

end