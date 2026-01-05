# Calendário Familiar

App em Flutter para cadastrar eventos e valores gastos em família, e programação da semana.

## 📱 Funcionalidades

### ✅ Implementadas

1. **Autenticação**
   - Login com Google Sign-In
   - Gerenciamento de sessão de usuário
   - Suporte a múltiplos usuários

2. **Gerenciamento de Família**
   - Criar estrutura familiar
   - Adicionar membros da família
   - Remover membros (exceto admin)
   - Visualizar todos os membros

3. **Calendário Semanal**
   - Visualização de calendário com formato semanal/mensal
   - Seleção de dias para ver eventos
   - Marcadores visuais para dias com eventos
   - Interface intuitiva e responsiva

4. **Gerenciamento de Eventos**
   - Criar novos eventos
   - Editar eventos existentes
   - Excluir eventos
   - Campos do evento:
     - Título (obrigatório)
     - Descrição (opcional)
     - Data e hora
     - Membros envolvidos
     - Custo/despesa (opcional)
     - Lembrete com notificação (opcional)

5. **Armazenamento Offline/Online**
   - Hive para armazenamento local offline
   - Sincronização automática com Firebase Firestore quando online
   - Dados persistem mesmo sem conexão

6. **Notificações Push**
   - Notificações locais para lembretes
   - Agendamento automático de notificações
   - Suporte para Android e iOS

## 🏗️ Arquitetura

O projeto segue uma arquitetura modular e escalável:

```
lib/
├── main.dart                 # Ponto de entrada do app
├── models/                   # Modelos de dados
│   ├── event_model.dart
│   ├── family_member_model.dart
│   └── user_model.dart
├── services/                 # Serviços de backend
│   ├── auth_service.dart
│   ├── firestore_service.dart
│   ├── hive_service.dart
│   └── notification_service.dart
├── providers/                # Gerenciamento de estado (Provider)
│   ├── auth_provider.dart
│   ├── event_provider.dart
│   └── family_provider.dart
├── views/                    # Telas da aplicação
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── create_event_screen.dart
│   ├── event_detail_screen.dart
│   └── family_management_screen.dart
├── widgets/                  # Componentes reutilizáveis
└── utils/                    # Utilitários
```

## 🚀 Como Executar

### Pré-requisitos

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / Xcode (para emuladores)
- Conta Firebase configurada

### Configuração do Firebase

1. Crie um projeto no [Firebase Console](https://console.firebase.google.com/)
2. Adicione um app Android e/ou iOS ao projeto
3. Baixe os arquivos de configuração:
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/Runner/`
4. Configure Firebase Authentication (Google Sign-In)
5. Configure Firebase Firestore
6. Configure as regras de segurança do Firestore

### Regras do Firestore (exemplo)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    match /families/{familyId} {
      allow read, write: if request.auth != null;
      
      match /members/{memberId} {
        allow read, write: if request.auth != null;
      }
      
      match /events/{eventId} {
        allow read, write: if request.auth != null;
      }
    }
  }
}
```

### Instalação

1. Clone o repositório:
```bash
git clone https://github.com/MagalhaesL/calendario-familiar.git
cd calendario-familiar
```

2. Instale as dependências:
```bash
flutter pub get
```

3. Gere os arquivos Hive (adapters):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Execute o app:
```bash
flutter run
```

## 📦 Dependências Principais

- **firebase_core** - Firebase inicialização
- **firebase_auth** - Autenticação Firebase
- **cloud_firestore** - Banco de dados Firestore
- **google_sign_in** - Login com Google
- **hive** - Armazenamento local
- **provider** - Gerenciamento de estado
- **table_calendar** - Componente de calendário
- **flutter_local_notifications** - Notificações locais
- **intl** - Internacionalização e formatação

## 🧪 Testes

Para rodar os testes:
```bash
flutter test
```

## 🏃‍♂️ Build

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 🔒 Segurança

- Autenticação via Firebase Authentication
- Dados sensíveis não são armazenados localmente em texto plano
- Comunicação segura com Firebase via HTTPS
- Regras de segurança do Firestore para controle de acesso

## 🤝 Contribuindo

Contribuições são bem-vindas! Por favor:

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/MinhaFeature`)
3. Commit suas mudanças (`git commit -m 'Adiciona MinhaFeature'`)
4. Push para a branch (`git push origin feature/MinhaFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto é open source.

## 👥 Autores

- **MagalhaesL** - [GitHub](https://github.com/MagalhaesL)

## 📞 Suporte

Para suporte, abra uma issue no repositório do GitHub.
