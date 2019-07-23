# docker-valecultura

## Pré requisitos
* Docker - Mais informações [aqui](http://pt.slideshare.net/vinnyfs89/docker-essa-baleia-vai-te-conquistar?qid=aed7b752-f313-4515-badd-f3bf811c8a35&v=&b=&from_search=1).
* docker-compose - Mais informações [aqui](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=2ahUKEwiKr87u07bhAhWxHbkGHXZdBeYQFjAAegQIBBAB&url=https%3A%2F%2Fdocs.docker.com%2Fcompose%2F&usg=AOvVaw02oes91geDSZ-H__u_XMxc).

## Subindo a aplicação via docker-compose (recomendado para desenvolvimento)

* Baixe o repositório e execute os comandos abaixo:
```
cd /var/www
git clone https://github.com/culturagovbr/docker-valecultura
cd docker-valecultura
cp docker-compose.yml-sample docker-compose.yml
docker-compose up --build
```

O container subirá no endereço abaixo: 
* http://localhost

Por padrão, está configurado para subir na porta 80. Caso queira, modifique o arquivo docker-compose.yml.

Configuração padrão (80 redireciona para porta 80 do container):
```
    ports:
      - "80:80"
```

Configurando para subir na porta 8080
```
    ports:
      - "8080:80"
```

Por último, configure o banco de dados com as credenciais corretas. Você pode modificar diretamente no servidor hospedeiro do container, modificando a pasta que será mapeada como volume (./app):
```
[editor] /var/www/docker-valecultura/app/portal-vale-cultura/projeto/application/configs/db.ini
```

No db.ini, altere:
```
resources.db.params.host = "hostname"
resources.db.params.dbname = "dbname"
resources.db.params.username = "username"
resources.db.params.password = "password"
```

## Subindo a aplicação via Dockerfile

* Baixe o repositório e execute os comandos abaixo:

```
cd /var/www
git clone https://github.com/culturagovbr/docker-valecultura
cd docker-valecultura
docker build -t culturagovbr/valecultura-web:1.0 -t culturagovbr/valecultura-web:latest .
```

O código `-t culturagovbr/valecultura-web:1.0` significa que você criará uma imagem chamada 'valecultura-web' com a tag '1.0' e o `.` significa que você fará o build no diretório atual.

Você pode executar o comando abaixo para criar um novo container usando a imagem recém criada. Detalhe: `$(pwd)` significa seu diretório atual. Você pode mudá-lo se quiser.
```
 docker run -it -v $(pwd)portal-vale-cultura:/var/www -v $(pwd)/log/apache2:/var/log/apache2 --name valecultura-webv1.0 -e APPLICATION_ENV="development" -p 80:80 -p 9000:9000 -p 8888:8888 culturagovbr/valecultura-web:latest
```

Para desenvolvimento
```
 docker run -it -v $(pwd)portal-vale-cultura:/var/www --name valecultura-webv1.0 -e APPLICATION_ENV="development" -p 80:80 culturagovbr/valecultura-web:latest
```

## Monitorando o estado do servidor
```
docker exec -it valecultura-webv1.0 bash -c "cd /tmp && wget 127.0.0.1/server-status -o server-status && cat server-status"
```

## Extra

Se você quiser verificar algo dentro do seu container, pode acessar usando o comando abaixo:
```
docker exec -it valecultura-webv1.0 bash
```

Veja os autores deste repositório:
* [Authors](./Authors.md).
