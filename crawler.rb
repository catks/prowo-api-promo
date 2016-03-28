require 'nokogiri'
require 'open-uri'
require 'json'

PAGE_URL="http://www.hardmob.com.br/promocoes/"
page = Nokogiri::HTML(open(PAGE_URL))

Promocao = Struct.new(:nome,:preco)
promocoes = []
nome_promos = page.xpath("//*[contains(@class,'nonsticky')]/div/div/h3/a") #xpath retorna o texto das promocoes
nome_promos.each{|elemento|
          promocoes << Promocao.new(
            elemento.text, #nome
            elemento.text[/[R\$\s*|\s*](\d*[,|.]\d{2})/,1] #preco regex para pegar o preço
          )
}
hardmob_pagina1 = %Q({"promocoes":#{promocoes.map { |promo| Hash[promo.each_pair.to_a] }.to_json}})
puts hardmob_pagina1
