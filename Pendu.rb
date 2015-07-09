load 'class/Personne.rb'

class JeuPendu
	attr_accessor :mot_hasard, :mot, :fin_du_jeu, :mot_joueur, :vies_restantes, :joueur, :lettre_essaye

	def initialize(joueur)

		# On Choisi un mot au hasard dans le fichier !
		fichier = File.open("words.txt",'r').readlines
		@mot_hasard = fichier[rand(fichier.size)]


		# On initialise les variables

		@mot = []
		@lettre_essaye = []
		@fin_du_jeu = false
		@mot_joueur = {}
		@vies_restantes = 7
		@joueur = joueur
		puts " -------------------------------------------"
		puts " -- Bienvenue à vous #{joueur.getPseudo}. --"
		puts " -------------------------------------------"
		puts "\n"

		# On stock le mot dans un tableau

		i = 0
		mot_hasard.size.times do
			@mot << mot_hasard[i]
			@mot_joueur[i] = "*"
			i = i + 1
		end

	end

	def compare(lettre)

		trouve = false
		
		deja = false
		i = 0
		# On vérifie si la lettre entrée par l'utilisateur a déjà été entrée
		while i < lettre_essaye.size && !deja

			if lettre_essaye[i] == lettre[0]
				deja = true
			end
			i = i+1
		end
		if !deja # On ajoute la lettre
			lettre_essaye << lettre[0]
			clear = true
		end

		if lettre_essaye.length == 0
			lettre_essaye[0] = lettre[0]
		end

		i = 0

		if !deja

			# On vérifie si la lettre est dans le mot
			while i < mot.size
				if mot[i] == lettre[0] # Si la lettre est dans le mot
					trouve = true
					mot_joueur[i] = mot[i] # On ajoute la lettre dans la variable mot_joueur
				end	
				i = i + 1
			end
			if trouve
				puts "La lettre #{lettre} a été trouvée !"
			else
				puts "Cette lettre n'est pas dans le mot !"
				lose
			end
		else
			puts "Cette lettre a déjà été essayé !"
		end
	end

	def actual
		print "Le mot à trouver est : "

		mot_joueur.length.times do |lettre| #On affiche le mot du joueur
			print mot_joueur[lettre]

		end
		print "\n"
	end

	def lose
		@vies_restantes = vies_restantes-1
	end


	def getLife
		return vies_restantes
	end

	def end_life
		if vies_restantes == 0
			puts "\n"
			puts "Pendu ! Vous avez perdu #{joueur.getPseudo} !"
			puts "Le mot était \"#{mot_hasard}\"."
			@fin_du_jeu = true
		else
			i = 0
			trouve = true
			while i < mot_joueur.size && trouve # On vérifie si le mot a ete trouve entierement
				if mot_joueur[i] != mot[i]
					trouve = false
				end
				i = i+1
			end
			if trouve == true # Si il a ete trouve entiérement
				puts "\n"
				puts "Félicitation #{joueur.getPseudo} vous avez gagné !" 
				@fin_du_jeu = true
			end
		end
	end

	def getEnd
		return fin_du_jeu
	end

end
puts "\n"
puts "--------------------------------"
puts "Vous avez lancé le jeu du pendu"
puts "--------------------------------"
puts "\n"


joueur = Personne.new

pendu = JeuPendu.new(joueur)

while(!pendu.getEnd)
	pendu.actual
	puts "Vous avez #{pendu.getLife} vies restantes !"
	puts "\n"
	print "Quel est votre lettre ?: " 
	lettre = gets.chomp.to_s
	pendu.compare(lettre)
	pendu.end_life
end
