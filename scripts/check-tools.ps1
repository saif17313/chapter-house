$ErrorActionPreference = "Stop"

$tools = @(
  @{ Name = "git"; Command = "git"; Args = @("--version") },
  @{ Name = "node"; Command = "node"; Args = @("--version") },
  @{ Name = "npm"; Command = "npm"; Args = @("--version") },
  @{ Name = "flutter"; Command = "flutter"; Args = @("--version") },
  @{ Name = "dart"; Command = "dart"; Args = @("--version") },
  @{ Name = "docker"; Command = "docker"; Args = @("--version") },
  @{ Name = "supabase"; Command = "supabase"; Args = @("--version") },
  @{ Name = "gh"; Command = "gh"; Args = @("--version") }
)

foreach ($tool in $tools) {
  $command = Get-Command $tool.Command -ErrorAction SilentlyContinue
  if ($null -eq $command) {
    Write-Output "$($tool.Name): missing"
    continue
  }

  $output = & $tool.Command @($tool.Args) 2>&1 | Select-Object -First 1
  Write-Output "$($tool.Name): $output"
}
