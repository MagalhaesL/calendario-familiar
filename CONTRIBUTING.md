# Contributing to Calendário Familiar

Thank you for your interest in contributing to Calendário Familiar! This document provides guidelines and instructions for contributing to the project.

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)

## 🤝 Code of Conduct

- Be respectful and inclusive
- Welcome newcomers and help them get started
- Focus on constructive feedback
- Keep discussions professional

## 🚀 Getting Started

1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub
   ```

2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/calendario-familiar.git
   cd calendario-familiar
   ```

3. **Add upstream remote**
   ```bash
   git remote add upstream https://github.com/MagalhaesL/calendario-familiar.git
   ```

4. **Install dependencies**
   ```bash
   flutter pub get
   ```

5. **Generate Hive adapters**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

6. **Set up Firebase** (see FIREBASE_SETUP.md)

## 💻 Development Workflow

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow the coding standards
   - Write/update tests
   - Update documentation if needed

3. **Test your changes**
   ```bash
   flutter test
   flutter analyze
   ```

4. **Commit your changes**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

5. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Open a Pull Request**

## 📝 Coding Standards

### Dart/Flutter Style

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use the provided `analysis_options.yaml` configuration
- Run `flutter analyze` before committing

### File Organization

```
lib/
├── models/          # Data models (Hive annotations)
├── services/        # Business logic and API calls
├── providers/       # State management (Provider pattern)
├── views/           # UI screens
├── widgets/         # Reusable UI components
└── utils/           # Helper functions and constants
```

### Naming Conventions

- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Functions**: `camelCase`
- **Constants**: `SCREAMING_SNAKE_CASE` or `camelCase` for private

### Code Quality

- Keep functions small and focused
- Add comments for complex logic
- Use meaningful variable names
- Avoid deeply nested code
- Follow DRY (Don't Repeat Yourself)

### State Management

- Use Provider for state management
- Keep providers focused and single-purpose
- Use `ChangeNotifier` for mutable state
- Call `notifyListeners()` after state changes

## 📋 Commit Messages

Use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting)
- **refactor**: Code refactoring
- **test**: Adding or updating tests
- **chore**: Maintenance tasks

### Examples

```bash
feat(auth): add Google sign-in functionality
fix(calendar): correct date selection bug
docs(readme): update installation instructions
refactor(services): simplify firestore queries
test(models): add event model tests
```

## 🔄 Pull Request Process

1. **Update your branch**
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Ensure all tests pass**
   ```bash
   flutter test
   flutter analyze
   ```

3. **Create Pull Request**
   - Use a clear, descriptive title
   - Reference any related issues
   - Provide context and screenshots (for UI changes)
   - Request review from maintainers

4. **PR Template**
   ```markdown
   ## Description
   Brief description of changes
   
   ## Type of Change
   - [ ] Bug fix
   - [ ] New feature
   - [ ] Breaking change
   - [ ] Documentation update
   
   ## Testing
   How to test the changes
   
   ## Screenshots (if applicable)
   Add screenshots here
   
   ## Checklist
   - [ ] Code follows style guidelines
   - [ ] Tests added/updated
   - [ ] Documentation updated
   - [ ] No new warnings
   ```

5. **Address Review Feedback**
   - Make requested changes
   - Push updates to your branch
   - Re-request review when ready

## 🧪 Testing

### Unit Tests

```bash
flutter test test/event_model_test.dart
```

### Widget Tests

```dart
testWidgets('Login screen displays correctly', (tester) async {
  await tester.pumpWidget(MyApp());
  expect(find.text('Calendário Familiar'), findsOneWidget);
});
```

### Integration Tests

For integration tests, create files in `integration_test/` directory.

## 🐛 Reporting Bugs

Use GitHub Issues with the bug template:

```markdown
**Describe the bug**
Clear description of the issue

**To Reproduce**
Steps to reproduce:
1. Go to '...'
2. Click on '...'
3. See error

**Expected behavior**
What should happen

**Screenshots**
If applicable

**Device info**
- Device: [e.g. Pixel 5]
- OS: [e.g. Android 12]
- App Version: [e.g. 1.0.0]
```

## 💡 Feature Requests

Use GitHub Issues with the feature template:

```markdown
**Is your feature request related to a problem?**
Description of the problem

**Describe the solution you'd like**
Clear description of what you want

**Describe alternatives considered**
Other solutions you've considered

**Additional context**
Screenshots, mockups, etc.
```

## 📚 Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Provider Documentation](https://pub.dev/packages/provider)
- [Hive Documentation](https://docs.hivedb.dev/)

## ❓ Questions?

Feel free to open an issue with the "question" label or reach out to the maintainers.

Thank you for contributing! 🎉
