# Currículo de Lucas Bastos Rezende dos Santos

Currículo em formato de site: <https://curriculolucas.duckdns.org:8444>

Desenvolvedor back-end em C#, Python e JavaScript/TypeScript, em Porto Velho (RO). O site reúne experiência, formação, projetos, certificados e um gráfico das contribuições no GitHub, carregado ao vivo.

## Páginas

- `site/index.html` — currículo: sobre, competências, atividade no GitHub, experiência, formação, projetos e ferramentas.
- `site/certificados.html` — linha do tempo dos certificados, com os PDFs em `site/uploads/`.

As fontes (Source Serif 4 e JetBrains Mono) e o React ficam no próprio repositório, em `site/fonts/` e `site/vendor/`, então a página não carrega nada de CDN.

## Como publicar

O site é estático e roda num container com [Caddy](https://caddyserver.com/). O certificado HTTPS é emitido pelo desafio DNS-01 do DuckDNS, porque as portas 80 e 443 estão bloqueadas na rede de casa.

```bash
cp .env.example .env   # preencha o DUCKDNS_TOKEN
docker compose up -d --build
```

O `docker-compose.yml` sobe dois serviços:

- `web`: Caddy servindo `site/` na porta 8444, sem privilégios, com sistema de arquivos somente leitura e limites de CPU e memória.
- `duckdns`: mantém o domínio apontando para o IP atual, que muda de tempos em tempos.

Os cabeçalhos de segurança (CSP, HSTS, bloqueio de iframe etc.) e o cache estão no `Caddyfile`.
