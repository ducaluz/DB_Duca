
CREATE TABLE producao_setor (
    id INTEGER NOT NULL,
    capacidade INTEGER NOT NULL,
    localEst INTEGER NOT NULL,
    created DATETIME NOT NULL,
    modified DATETIME NOT NULL,
    descricao VARCHAR NOT NULL,
    PRIMARY KEY (id),
    UNIQUE (descricao));

CREATE TABLE producao_tipomovimento (
    id INTEGER NOT NULL,
    descricao VARCHAR NOT NULL,
    created DATETIME NOT NULL,
    modified DATETIME NOT NULL,
    PRIMARY KEY (id));

CREATE TABLE producao_produto (
    id INTEGER NOT NULL,
    descricao VARCHAR NOT NULL,
    unidade VARCHAR NOT NULL,
    final BOOL NOT NULL,
    created DATETIME NOT NULL,
    modified DATETIME NOT NULL,
    codigoJiwa VARCHAR NOT NULL,
    qtdeCaixa INTEGER UNSIGNED NOT NULL,
    qtdeSaco INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (id), UNIQUE (descricao));

CREATE TABLE producao_produtofatorcorrecao (
    id INTEGER NOT NULL,
    dataFator DATE NOT NULL,
    fator DECIMAL NOT NULL,
    produto_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (produto_id) REFERENCES "producao_produto" ("id"));

CREATE TABLE producao_fichatecnica (
    id INTEGER NOT NULL,
    versao VARCHAR NOT NULL,
    rendimento INTEGER UNSIGNED NOT NULL,
    created DATETIME NOT NULL,
    modified DATETIME NOT NULL,
    produto_id INTEGER NOT NULL,
    pesoFinal DECIMAL NOT NULL, PRIMARY KEY (id),
    FOREIGN KEY (produto_id) REFERENCES "producao_produto" ("id"));

CREATE TABLE producao_fichaitens (
    id INTEGER NOT NULL,
    quantidade DECIMAL NOT NULL,
    tempo TIME NOT NULL,
    created DATETIME NOT NULL,
    modified DATETIME NOT NULL,
    fichaTecnica_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    setor_id INTEGER NOT NULL,
    observacao VARCHAR NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (fichaTecnica_id) REFERENCES "producao_fichatecnica" ("id"),
    FOREIGN KEY (produto_id) REFERENCES "producao_produto" ("id"),
    FOREIGN KEY (setor_id) REFERENCES "producao_setor" ("id"));

CREATE TABLE producao_ordemproducao (
    id INTEGER NOT NULL,
    dataProducao DATE NOT NULL,
    semana INTEGER UNSIGNED NOT NULL,
    quantidade INTEGER UNSIGNED NOT NULL,
    status VARCHAR NOT NULL,
    setorFinal_id INTEGER NOT NULL,
    fichaTecnica_id INTEGER NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (setorFinal_id) REFERENCES "producao_setor" ("id"),
    FOREIGN KEY (fichaTecnica_id) REFERENCES "producao_fichatecnica" ("id"));

CREATE TABLE producao_movimentoproducao (
    id INTEGER NOT NULL,
    dataMovimento DATE NOT NULL,
    EntradaSaida VARCHAR NOT NULL,
    tipoMovimento_id INTEGER NOT NULL,
    ordemProducao_id INTEGER NOT NULL,
    setor_id INTEGER NOT NULL,
    quantidade INTEGER UNSIGNED NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (tipoMovimento_id) REFERENCES "producao_tipomovimento" ("id"),
    FOREIGN KEY (ordemProducao_id) REFERENCES "producao_ordemproducao" ("id"),
    FOREIGN KEY (setor_id) REFERENCES "producao_setor" ("id"));

CREATE TABLE producao_ocorrencia (
    id INTEGER NOT NULL,
    dataOcorrencia DATE NOT NULL,
    dataInicio DATETIME NOT NULL,
    dataFinal DATETIME NOT NULL,
    descricao TEXT NOT NULL,
    setor_id INTEGER NOT NULL,
    tipoMovimento_id INTEGER NOT NULL,
    executor VARCHAR NOT NULL, PRIMARY KEY (id),
    FOREIGN KEY (setor_id) REFERENCES "producao_setor" ("id"),
    FOREIGN KEY (tipoMovimento_id) REFERENCES "producao_tipomovimento" ("id"));
