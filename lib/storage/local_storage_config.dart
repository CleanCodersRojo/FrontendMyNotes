const databaseConfig = {
  // Nombre del archivo para acceder a la
  // base de datos
  'filename': 'local_storage.db',
  // Versión de la base de datos
  'version': 1,
  // Esquema para crear la base de datos
  'note_scheme': '''
    CREATE TABLE notas (
      id TEXT,
      content TEXT,
      sync_create INTEGER DEFAULT 0,
      sync_update INTEGER DEFAULT 0,
      sync_delete INTEGER DEFAULT 0
    );
  ''',
};
