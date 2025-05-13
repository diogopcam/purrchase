# 📚 Wiki do Projeto – Fluxo de Trabalho com Gitflow

## 📌 Visão Geral

Este projeto segue o modelo de **Gitflow**, um fluxo de trabalho robusto baseado em ramificações que facilita o gerenciamento de versões e o desenvolvimento colaborativo.

Estrutura principal de branches:

- `main`: Contém o código em produção.
- `develop`: Contém a última versão estável em desenvolvimento.
- `feature/*`: Utilizada para desenvolvimento de novas funcionalidades.

---

## 🔀 Branches Principais

### `main`
- Representa a **versão de produção** do projeto.
- Cada commit nesta branch deve estar em produção e ser versionado (tag).
- Merges nesta branch são realizados a partir de `develop` por meio de pull requests (PRs) e **após aprovação**.

### `develop`
- Contém o **código em desenvolvimento contínuo**.
- Serve como base para criação de novas branches de feature.
- Após a finalização de um ciclo de desenvolvimento (sprint, milestone etc.), é feito o merge com a `main`.

---

## 🌱 Branches de Feature

### Convenção de nome
```bash
feature/nome-descritivo
