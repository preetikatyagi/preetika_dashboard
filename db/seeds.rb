now = Time.now


role_data = [
{ :code	=> 'administrator', :name =>	'Administrator'},
{ :code	=> 'patient', :name =>	'Patient'},
{ :code	=> 'analyst', :name =>	'Analyst'},
{ :code	=> 'sequencer', :name =>	'Sequencer'},
{ :code	=> 'clinician', :name =>	'Clincian'}
]

roles = Role.create(role_data)


admin = User.create(
	:name => 'Site Administrator',
	:login	=> 'admin',
	:email	=> 'admin@example.com',
	# :salt	=> '7e3041ebc2fc05a40c60028e2c4901a81035d3cd',
	:salt	=> 'ac3478d69a3c81fa62e60f5c3696165a4e5e6ac4', # SHA1('0')
	:password	=> 'password',
	:password_confirmation	=> 'password',
	:created_at	=> now,
	:updated_at	=> now)
if admin.activated_at.nil?
	admin.activate!
end

r = Role.find_by_code('administrator')
admin.roles << r


patient_role = Role.find_by_code('patient')
for i in 1..4 do
	patient = User.create(
		:name	=> "Patient #{i}",
		:login	=> "patient#{i}",
		:email	=> "patient#{i}@example.com",
		:salt	=> 'ac3478d69a3c81fa62e60f5c3696165a4e5e6ac4',
		:password	=> 'password',
		:password_confirmation	=> 'password',
		:created_at	=> now,
		:updated_at	=> now)
	patient.roles << patient_role
	patient.activate!
end

# Create orientations.
# up = Orientation.create!(:name => 'Up')
# down = Orientation.create!(:name => 'Down')
# orientations = [up, down]

# Create phenotypes.
# sensitivity = Phenotype.create!(:name => 'Sensitivity')
# resistence = Phenotype.create!(:name => 'Resistence')
# phenotypes = [sensitivity, resistence]
