defmodule App.Repo.Migrations.AlterUploadsAddFiles do
  use Ecto.Migration

  def change do
    alter table(:uploads) do
      add :category, :string
      add :file2, :string
      add :file3, :string
      add :file4, :string
      add :file5, :string
      add :file6, :string
      add :file7, :string
      add :file8, :string
      add :files, {:array, :string}
    end
  end
end
