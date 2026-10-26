<p align="center">
  <img src="https://img.shields.io/badge/Platform-iOS%2016%2B%20%7C%20macOS%2013%2B-blue" alt="Platform">
  <img src="https://img.shields.io/badge/Swift-5.9%2B-orange" alt="Swift">
  <img src="https://img.shields.io/badge/License-MIT-green" alt="License">
  <img src="https://img.shields.io/badge/status-early%20WIP-yellow" alt="Status">
  <a href="https://buymeacoffee.com/jcbuilds"><img src="https://img.shields.io/badge/Buy%20Me%20a%20Coffee-FFDD00?logo=buymeacoffee&logoColor=black" alt="Buy Me a Coffee"></a>
</p>

<h1 align="center">🧬 Foundry</h1>

<p align="center">
  <strong>On-device LoRA fine-tuning for iOS &amp; macOS.</strong><br>
  <em>Personalize a local LLM from inside your app — while it sleeps.</em>
</p>

<p align="center">
  Capture preferences • Train overnight • Hot-swap adapters • Zero cloud
</p>

---

Foundry lets your shipped iOS app *fine-tune its own model*. Users thumbs-up and thumbs-down responses inside your app. While the device charges overnight, Foundry trains a tiny LoRA adapter on those preferences and reloads it next morning. No API keys, no cloud, no data ever leaving the phone.

This is the missing piece between "ship a local LLM" and "ship a model that's actually *yours*."

## Why this is novel

Every other Apple-platform local-LLM stack treats the model as immutable: ship a GGUF, infer, repeat. The Python ecosystem has `peft`, `unsloth`, `trl` — but nothing comparable exists in Swift, and certainly nothing that runs on-device. Foundry closes that gap.

## Planned features

| Category | Capabilities |
|----------|-------------|
| 🧬 **LoRA training** | Train rank-4/8/16 adapters on top of any GGUF base model, on-device |
| 🔋 **Charge-time training** | Schedule training only while device is charging + idle, with thermal back-off |
| 🎚️ **Adapter hot-swap** | Load, unload, and blend LoRA adapters at runtime without reloading the base |
| 📚 **Preference capture** | Drop-in API for thumbs-up/down on streamed completions, with replay buffer |
| 🧪 **DPO &amp; SFT** | Both supervised fine-tuning and direct-preference optimization |
| 🔒 **Private by default** | All examples and adapters live in the app sandbox; nothing transmitted |
| 🤝 **Kuzco-native** | First-class integration with [Kuzco](https://github.com/haplollc/Kuzco) inference |

## Planned API (subject to change)

```swift
import Foundry
import Kuzco

let trainer = FoundryTrainer(
    base: "Llama-3.2-3B-Instruct.Q4_K_M.gguf",
    rank: 8,
    schedule: .whenChargingAndIdle
)

// Capture a preference inline with chat
trainer.record(prompt: prompt, chosen: goodResponse, rejected: badResponse)

// Trigger / monitor training
let run = try await trainer.train()
for await update in run.progress {
    print("loss: \(update.loss), step: \(update.step)/\(update.totalSteps)")
}

// Apply the resulting adapter at inference time
let session = try Kuzco.session(model: base, lora: run.adapterURL)
```

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/haplollc/Foundry.git", from: "0.1.0")
]
```

## Status

🚧 **Early WIP.** Public API is being designed alongside the Haplo iOS app, which will be the first consumer.

## License

MIT © [Haplo LLC](https://haplo.ai)
