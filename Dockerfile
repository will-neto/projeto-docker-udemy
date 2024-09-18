# Docker lê o arquivo Dockerfile para identificar as instruções que devem ser executadas para construir as imagens

# FROM => define a imagem base 

# RUN/COPY/ADD/etc => comandos que modificam o sistema de arquivos, o Docker (1) cria um contêiner temporário para execução, (2) gera uma nova camada na imagem com as mudanças
#                       feitas pelo comando e (3) descarta o contêiner temporário, mas as alterações são preservadas na imagem

# Se uma camada não tem alteração, o Docker reutiliza camadas por meio de cache

# O processo continua até que todas as instruções sejam executadas. A imagem final é a combinação das camadas criadas

FROM node

# Cria ou entra em pasta /app que é gerada na imagem
WORKDIR /app

# A partir deste comando é criada a pasta /app dentro do contêiner temporário
# É feita a copia dos arquivos package-lock.json e package.json (da máquina HOST) para a pasta /app no contêiner temporário
# Após a cópia, é criada a camada na imagem e descartado o contêiner
COPY package*.json .

# A execução do comando é feita no diretório /app
# Como o diretório já foi criado na camada anterior (COPY), ele utiliza a pasta já existente, onde já contem os arquivos copiados dentro
RUN npm install

# Copia demais arquivos do host para a pasta app
COPY . .

# Específica que a aplicação node estará disposta na porta 3000, mas não deixa ela acessivel automaticamente para acesso via host
# O mapemento deve ser feito via atributo "-p" quando criado/executado o contêiner
EXPOSE 3000

# Executa o comando abaixo no diretorio /app para executar a aplicação node
CMD ["node", "app.js"]