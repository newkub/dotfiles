import { defineConfig } from './src/types/define-config';

export default defineConfig({
  ai: [
    {
      provider: "openrouter",
      model: "gpt-4.1",
      apiKey: "process.env.OPENROUTER_API_KEY"
    }
  ],
  aicommit: {
    aistage: true,
    scope: "auto",
    autoStage: true,
    type: "conventional",
    stage: "auto",
    confirm: "auto",
    push: "auto",
    commitLanguage: "english"
  },
  hooks: {
    afterMerge: "git commit -m 'Merge {source} into {target}'",
    preCommit: "bun run lint",
    postCommit: "echo 'Commit successful!'"
  },
  branch: {
    newBranch: "{type}/{ticket}-{description}",
    protectedBranches: [
      "main",
      "develop"
    ]
  },
  release: {
    publishCommand: "bun run publish",
    generateChangelog: true,
    versioning: "semantic"
  }
});
