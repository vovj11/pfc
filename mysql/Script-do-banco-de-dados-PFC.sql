create database pfc;
use pfc;

create table if not exists area(PK_codTipoArea int auto_increment primary key,nomeArea varchar(255));
create table if not exists tipoCurso(PK_codTipoCurso int auto_increment primary key,descricao varchar(255));
create table if not exists modalidade(PK_codModalidade int auto_increment primary key,descricao varchar(255));
create table if not exists curso(PK_codCurso int auto_increment primary key,nomeCurso varchar(255),FK_codTipoArea int,FK_codTipoCurso int,FK_codModalidade int,
    constraint FK_tipoAreaParaCurso foreign key(FK_codTipoArea) references area(PK_codTipoArea),
	constraint FK_tipoCursoParaCurso foreign key(FK_codTipoCurso) references tipoCurso(PK_codTipoCurso),
    constraint FK_modalidadeParaCurso foreign key(FK_codModalidade) references modalidade(PK_codModalidade));


/*PK do Status modificada por PK_codStatusCurso pq existia duas PK com mesmo nome*/
create table if not exists statusCurso(PK_codStatusCurso int auto_increment primary key,descricao varchar(255));
create table if not exists statusInstituicao(PK_codStatusInstituicao int auto_increment primary key,descricao varchar(255));
create table if not exists instituicao(PK_codInstituicao int auto_increment primary key,nome varchar(255),UF varchar(2),cidade varchar(255),FK_codStatus int,
	constraint FK_statusParaStatusCurso foreign key(FK_codStatus) references statusCurso(PK_codStatusCurso));

create table if not exists cursoDaInstituicao(PK_codCursoInstituicao int auto_increment primary key,numeroVagas int,outrasInfo text,FK_codInstituicao int,FK_codCurso int,FK_codStatusCurso int,
	constraint FK_instituicaoParaCursoInstituicao foreign key(FK_codInstituicao) references instituicao(PK_codInstituicao),
    constraint FK_cursoParaCursoInstituicao foreign key(FK_codCurso) references curso(PK_codCurso),
    constraint FK_statusCursoParaCursoInstituicao foreign key(FK_codStatusCurso) references statusCurso(PK_codStatusCurso));


create table if not exists disciplina(PK_codDisciplina int auto_increment primary key,nomeDisciplina varchar(255),cargaHoraria time);	
create table if not exists matrizCurricular(PK_codMatriz int auto_increment primary key,qtdSemestre int,cargaHoraria time,FK_codDisciplina int,FK_codCursoInstituicao int,
	constraint FK_disciplinaParaMatrizCurricular foreign key(FK_codDisciplina) references disciplina(PK_codDisciplina),
    constraint FK_cursoInstituicaoParaDisciplina foreign key(FK_codCursoInstituicao) references cursoDaInstituicao(PK_codCursoInstituicao));    

/*coluna data modificada para dataValor pq data é uma palavra reservada no mysql*/
create table if not exists valorCurso(CodValor int auto_increment primary key,dataValor date,valor double,FK_codCursoInstituicao int,
	constraint FK_cursoInstituicaoParaValor foreign key (FK_codCursoInstituicao) references cursoDaInstituicao(PK_codCursoInstituicao));    


drop database pfc;