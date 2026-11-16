
# Llamafile Runtime

Container Docker responsável por executar um modelo de inteligência artificial utilizando o **Llamafile**, disponibilizando uma API HTTP para processamento de solicitações.

Atualmente, o projeto utiliza o modelo **Qwen3.5-0.8B-Q8_0**, disponibilizado pela Mozilla, e oferece uma API compatível com o formato OpenAI.

## Construção da imagem

Na raiz do projeto, execute:

```bash
docker build -t llamafile-runtime .
```

Esse comando constrói a imagem Docker com o ambiente necessário para executar o modelo.

Durante a construção, o script `download-model.sh` realiza o download do modelo e o disponibiliza no diretório configurado no container.

## Execução do container

Após construir a imagem, execute:

```bash
docker run -d --name llamafile-ia -p 8080:8080 llamafile-runtime
```


## API de inferência

O Llamafile disponibiliza uma API HTTP compatível com o padrão OpenAI, permitindo enviar mensagens ao modelo e receber respostas geradas pela inteligência artificial.

### Exemplo

Endpoint

```http
POST http://localhost:8080/v1/chat/completions
```

Content-Type

```http
application/json
```

Body

```json
{
  "messages": [
    {
      "role": "user",
      "content": "Explique o que é inteligência artificial."
    }
  ],
  "temperature": 0.7,
  "max_tokens": 300,
  "stream": false
}
```