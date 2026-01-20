#!/usr/bin/env bash
# Healthcare AI Assistant - Setup Script

set -e  # Exit on error

echo "🏥 Setting up Healthcare AI Assistant..."
echo

# Check if uv is installed
if ! command -v uv &> /dev/null; then
    echo "❌ Error: uv is not installed"
    echo "   Install it from: https://docs.astral.sh/uv/getting-started/installation/"
    exit 1
fi

# Install dependencies
echo "📦 Installing dependencies with uv..."
uv sync
echo "✅ Dependencies installed"
echo

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    cp .env.example .env
    echo "📄 Created .env file from template"
    echo "   ⚠️  Please add your ANTHROPIC_API_KEY to .env before running the app"
    echo
fi

# Initialize database
echo "🗄️  Initializing database..."
if [ -f data/healthcare.db ]; then
    echo "   Database already exists at data/healthcare.db"
    read -p "   Do you want to reinitialize it? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm data/healthcare.db
        sqlite3 data/healthcare.db < src/database/init.sql
        echo "✅ Database reinitialized"
    else
        echo "   Keeping existing database"
    fi
else
    sqlite3 data/healthcare.db < src/database/init.sql
    echo "✅ Database initialized"
fi
echo

# Download sample transcripts (optional)
echo "📥 Would you like to download sample transcripts from Microsoft's clinical dataset?"
read -p "   This will help with testing. (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "   Downloading sample transcripts..."
    # Clone just the sample data (if repo is small) or download specific files
    # For now, we'll create a placeholder
    echo "   ℹ️  Please manually download samples from:"
    echo "   https://github.com/microsoft/clinical_visit_note_summarization_corpus"
    echo "   and place them in data/sample_transcripts/"
fi
echo

echo "✨ Setup complete!"
echo
echo "Next steps:"
echo "1. Add your ANTHROPIC_API_KEY to .env"
echo "2. Run: uv run chainlit run app.py"
echo "3. Open http://localhost:8000 in your browser"
echo
