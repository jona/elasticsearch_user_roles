class Role
  include Tire::Model::Persistence

  property :name,           type: 'string', index: 'not_analyzed'
  property :created_at,     type: 'date', class: Time, default: Proc.new{ Time.now }

  def self.add_role(user, roles)
    roles.each do |key, r|
      if r == "1"
        role = Role.find_by_name(key)
        role = Role.create(name: key) unless role
        UserRole.create(role_id: role.id, user_id: user.id) unless UserRole.has_role?(user, role.id)
      else
        user.remove_role(Role.find_by_name(key)) if UserRole.find_by_user_id(user.id, Role.find_by_name(key))
      end
    end
  end

  def self.find_by_name(name)
    search(size: 1){ |s| s.query{ |q| q.term :name, name } }.first
  end

end