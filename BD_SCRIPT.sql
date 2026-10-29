CREATE SCHEMA CHRONIX;
USE CHRONIX;

CREATE TABLE company(
	id_company INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(45) NOT NULL,
    company_cep VARCHAR(45) NOT NULL,
    company_number VARCHAR(45) NOT NULL,
    company_email VARCHAR(45) NOT NULL UNIQUE,
    company_cnpj VARCHAR(45) NOT NULL UNIQUE,
    company_phone VARCHAR(45) NOT NULL UNIQUE);
    
CREATE TABLE unity(
	id_unity INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_company INT NOT NULL,
    unity_state VARCHAR(45) NOT NULL,
    unity_city VARCHAR(45) NOT NULL,
    unity_cep VARCHAR(45) NOT NULL,
    unity_number INT NOT NULL,
    unity_type ENUM('Matriz', 'Filial') NOT NULL,
    FOREIGN KEY(fk_id_company) REFERENCES company(id_company));
    
CREATE TABLE department(
	id_department INT AUTO_INCREMENT PRIMARY KEY,
	fk_id_unity INT NOT NULL,
    department_name VARCHAR(45) NOT NULL,
    FOREIGN KEY(fk_id_unity) REFERENCES unity (id_unity));

CREATE TABLE employee(
	id_employee INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(45) NOT NULL,
    employee_cpf VARCHAR(14) NOT NULL UNIQUE,
    employee_email VARCHAR(45) NOT NULL UNIQUE,
    employee_birth DATE NOT NULL,
    fk_id_department INT NOT NULL,
	FOREIGN KEY(fk_id_department) REFERENCES department (id_department)); 
    
CREATE TABLE permission(
	id_permission INT AUTO_INCREMENT PRIMARY KEY,
    permission_name ENUM('Pessoal', 'Gerente', 'RH','DBA'));
    
CREATE TABLE contract(
	id_contract INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_employee INT NOT NULL,
    fk_id_permission INT NOT NULL,
    position VARCHAR(45) NOT NULL,
    salary DECIMAL NOT NULL,
    schedule_time INT NOT NULL,
    schedule_days INT NOT NULL,
    schedule_shift ENUM('Diurno','Noturno','Misto') NOT NULL, 
    dangerousness VARCHAR(45),
    unhealthy ENUM('1','2','3'),
    contract_description TEXT NOT NULL,
    status BOOLEAN NOT NULL,
    FOREIGN KEY(fk_id_permission) REFERENCES permission(id_permission),
    FOREIGN KEY(fk_id_employee) REFERENCES employee (id_employee));

CREATE TABLE attachment(
	id_attachment INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_employee INT NOT NULL,
    date_attachment DATE NOT NULL,
    document BLOB NOT NULL,
    document_type VARCHAR(45) NOT NULL,
    deferred BOOLEAN NOT NULL,
    FOREIGN KEY(fk_id_employee) REFERENCES employee (id_employee));
    
CREATE TABLE clock(
	id_clock INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_employee INT NOT NULL,
    clock TIMESTAMP NOT NULL,
    clock_type ENUM('Entrada', 'Saída'),
    FOREIGN KEY(fk_id_employee) REFERENCES employee (id_employee));
    
CREATE TABLE bank(
	id_bank INT AUTO_INCREMENT PRIMARY KEY,
    fk_id_employee INT NOT NULL,
    bank VARCHAR(45) NOT NULL,
    branch VARCHAR(45) NOT NULL,
    account VARCHAR(45) NOT NULL UNIQUE,
    FOREIGN KEY(fk_id_employee) REFERENCES employee (id_employee));
    
CREATE TABLE login(
	fk_id_employee INT PRIMARY KEY,
    login VARCHAR(45) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    FOREIGN KEY(fk_id_employee) REFERENCES employee (id_employee));