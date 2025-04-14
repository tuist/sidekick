defmodule PlasmaAgent.XDG do
  @moduledoc """
  XDG Base Directory Specification
  """

  def home do
    System.get_env("HOME")
  end

  def data_home do
    System.get_env("XDG_DATA_HOME") || Path.join(home(), ".local/share")
  end

  def config_home do
    System.get_env("XDG_CONFIG_HOME") || Path.join(home(), ".config")
  end

  def data_dirs do
    xdg_data_dirs = System.get_env("XDG_DATA_DIRS")

    if is_nil(xdg_data_dirs) do
      String.split(xdg_data_dirs, ":")
    else
      ["/usr/local/share", "/usr/share"]
    end
  end

  def config_dirs do
    System.get_env("XDG_CONFIG_DIRS") || [Path.join("/etc", "xdg")]
  end

  def cache_home do
    System.get_env("XDG_CACHE_HOME") || Path.join(home(), ".cache")
  end

  def runtime_dir do
    System.get_env("XDG_RUNTIME_DIR") ||
      raise """
      XDG_RUNTIME_DIR is not set. This directory is required for applications to
      communicate with each other. It should be set to a directory that is
      writable by the user and that is not shared with other users.
      """
  end
end
