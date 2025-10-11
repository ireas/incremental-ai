# Localization

This localization framework allows loading YAML files from assets and serving the correct translation for the currently active language.

Each language should have a separate asset file to lead that must be registered in the repository. New languages must be added to the enum.


> [!TIP]
> Localized strings can contain placeholders that get injected at runtime. Each placeholder is identified by a unique key wrapped in curly
> brackets.
>
> Example: This String contains a **{placeholder}** that can be injected at runtime.
>
> The placeholder key is _case-insensitive_!


> [!WARNING]
> A validation makes sure that each localization must contain exactly the _same set of keys_ and each translated String must have _equal
> number of placeholders_ as Strings with same key in other localizations.
