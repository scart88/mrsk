require "mrsk/commands/base"

class Mrsk::Commands::Builder::Multiarch < Mrsk::Commands::Base
  def create
    docker :buildx, :create, "--use", "--name", builder_name
  end

  def remove
    docker :buildx, :rm, builder_name
  end

  def push
    docker :buildx, :build, "--push", "--platform linux/amd64,linux/arm64", "-t", config.absolute_image, "."
  end

  def pull
    docker :pull, config.absolute_image
  end

  def info
    combine \
      docker(:context, :ls),
      docker(:buildx, :ls)
  end

  private
    def builder_name
      "mrsk-#{config.service}"
    end
end
