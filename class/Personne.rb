class Personne 
	attr_accessor :pseudo

	def initialize
		print "Quel est votre pseudo ?: "
		@pseudo = gets.chomp.to_s
	end

	def getPseudo
		return pseudo
	end
end