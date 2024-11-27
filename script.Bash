# Variáveis de ambiente
DB_HOST="seu_host"
DB_USER="seu_usuario"
DB_NAME="seu_banco"
DB_PASSWORD="sua_senha"

export PGPASSWORD=$DB_PASSWORD

# Aplicar todas as migrações pendentes
for file in migrations/*.sql; do
    echo "Executando $file..."
    psql -h $DB_HOST -U $DB_USER -d $DB_NAME -f $file

    if [ $? -eq 0 ]; then
        echo "Migração $file aplicada com sucesso!"
        # Registrar a migração no histórico
        psql -h $DB_HOST -U $DB_USER -d $DB_NAME -c \
            "INSERT INTO migration_history (migration_file, status) VALUES ('$file', 'success');"
    else
        echo "Erro ao aplicar migração $file"
        exit 1
    fi
done