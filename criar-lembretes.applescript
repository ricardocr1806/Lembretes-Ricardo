-- Cria as listas do Ricardo no app Lembretes (sincroniza com o iPhone via iCloud).
-- Rodar no Mac: osascript criar-lembretes.applescript
-- Pode rodar de novo sem duplicar: pula tarefas que já existem.

on garantirLista(nomeLista)
	tell application "Reminders"
		if not (exists list nomeLista) then
			make new list with properties {name:nomeLista}
		end if
		return list nomeLista
	end tell
end garantirLista

on adicionar(nomeLista, tarefas)
	set alvo to my garantirLista(nomeLista)
	tell application "Reminders"
		repeat with t in tarefas
			set t to t as text
			if not (exists (first reminder of alvo whose name is t and completed is false)) then
				make new reminder at end of alvo with properties {name:t}
			end if
		end repeat
	end tell
end adicionar

on adicionarComAlerta(nomeLista, titulo, notas, quando)
	set alvo to my garantirLista(nomeLista)
	tell application "Reminders"
		if not (exists (first reminder of alvo whose name is titulo and completed is false)) then
			make new reminder at end of alvo with properties {name:titulo, body:notas, remind me date:quando}
		end if
	end tell
end adicionarComAlerta

on dataHora(ano, mes, dia, hora, minuto)
	set d to current date
	set day of d to 1
	set year of d to ano
	set month of d to mes
	set day of d to dia
	set time of d to (hora * hours + minuto * minutes)
	return d
end dataHora

-- BRAND LEGACY
my adicionar("Brand Legacy", {¬
	"Fundação: definir produtos (entregáveis e promessa)", ¬
	"Assinar VPS", ¬
	"Verificar domínio", ¬
	"Criar app no Meta para automatizar anúncios", ¬
	"Criar plataforma com todas as infos para o time", ¬
	"Criar agente de IA (tipo Franklin): gestão + subir tráfego", ¬
	"Estratégia de cada funil", ¬
	"Estratégia de tráfego", ¬
	"Estratégia de social selling", ¬
	"Estratégia de prospecção", ¬
	"Estratégia de orgânico / viralização", ¬
	"Estratégia para chamar a galera pro evento", ¬
	"Estratégia de perpétuo", ¬
	"Estratégia de retenção dos clientes", ¬
	"Novas formas de vender para quem já é cliente"})

my adicionarComAlerta("Brand Legacy", "⚠️ Prazo: fechar Brand Legacy", "Conferir o que ficou pendente nesta lista.", my dataHora(2026, 11, 17, 9, 0))

-- EMPRESAS (olhar 1x por dia)
my adicionarComAlerta("Empresas", "Olhar as empresas hoje", ¬
	"N1: Mentor Scale, Dom" & linefeed & ¬
	"N2: Mercado Livre/TikTok Laura, Accutare (IA), Lumi USA" & linefeed & ¬
	"N3: Detailhub" & linefeed & ¬
	"N4: Ótica Persona, Dra. Veridiana", ¬
	my dataHora(2026, 11, 16, 8, 30))
-- Observação: o AppleScript do Lembretes não define repetição.
-- Depois de rodar, abrir esse lembrete e marcar "Repetir: Diariamente" (1 toque).
