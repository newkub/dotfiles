# Dynamic sources
$containers = [DynamicSource]@{
    Name = "Containers";
    Description = "List of running containers";
    CommandExpression = { 
        docker ps --format "{{.Names}}" 
    };
    Cache = [Cache]@{
        ByCurrentWorkingDirectory = $true;
        ByTime = New-TimeSpan -Seconds 10 ;
        ByCommand = @("kill", "run", "stop", "start","rm","pause")
    }
}

$allContainers = [DynamicSource]@{
    Name = "All Containers";
    Description = "List of all containers (running + stopped)";
    CommandExpression = { 
        docker ps -a --format "{{.Names}}" 
    };
    Cache = [Cache]@{ 
        ByCurrentWorkingDirectory = $true;
        ByTime = New-TimeSpan -Seconds 10 ;
        ByCommand = @("kill", "run", "stop", "start","rm","pause")
    }
}

$images = [DynamicSource]@{
    Name = "Images";
    Description = "List of Docker images";
    CommandExpression = { 
        docker images --format "{{.Repository}}:{{.Tag}}" 
    };
    Cache = [Cache]@{ 
        ByTime = New-TimeSpan -Seconds 30 
    }
}

$volumes = [DynamicSource]@{
    Name = "Volumes";
    Description = "List of Docker volumes";
    CommandExpression = { 
        docker volume ls --format "{{.Name}}" 
    };
    Cache = [Cache]@{ 
        ByTime = New-TimeSpan -Seconds 30 
    }
}

$dockerContexts = [DynamicSource]@{
    Name = "Docker Contexts";
    Description = "List of Docker contexts";
    CommandExpression = { 
        docker context ls --format "{{.Name}}" 
    };
    Cache = [Cache]@{ 
        ByTime = New-TimeSpan -Seconds 10 
    }
}

# Docker PowerTypeDictionary
[PowerTypeDictionary]@{
    Keys        = @("docker");
    Name        = "Docker";
    Description = "Docker CLI management";
    Platforms   = [Platforms]::All;
    State       = [DictionaryState]::Experimental -bor [DictionaryState]::Incomplete;
    Source      = "Hand crafted";
    Url         = "https://docs.docker.com/engine/reference/commandline/cli/";
    Parameters  = @(
        # Containers
        [CommandParameter]@{
            Keys = @("ps");
            Name = "ps";
            Description = "List containers";
            Parameters = @(
                [FlagParameter]@{ 
                    Keys=@("-a","--all"); 
                    Name="all"; 
                    Description="Show all containers" 
                }
            )
        },
        [CommandParameter]@{
            Keys = @("run");
            Name = "run";
            Description = "Run a new container";
            Parameters = @(
                [ValueParameter]@{ 
                    Name="image"; 
                    Description="Image to run"; 
                    Source=$images 
                }
            )
        },
        [CommandParameter]@{
            Keys = @("exec");
            Name = "exec";
            Description = "Run command in a running container";
            Parameters = @(
                [ValueParameter]@{ 
                    Name="container"; 
                    Description="Container to exec into"; 
                    Source=$containers 
                }
            )
        },
        [CommandParameter]@{
            Keys = @("stop");
            Name = "stop";
            Description = "Stop container(s)";
            Parameters = @(
                [ValueParameter]@{ 
                    Name="container"; 
                    Description="Container to stop"; 
                    Source=$containers 
                }
            )
        },
        [CommandParameter]@{
            Keys = @("rm");
            Name = "rm";
            Description = "Remove container(s)";
            Parameters = @(
                [ValueParameter]@{ 
                    Name="container"; 
                    Description="Container to remove"; 
                    Source=$allContainers 
                }
            )
        },
        # Images
        [CommandParameter]@{ 
            Keys=@("images"); 
            Name="images"; 
            Description="List images" 
        },
        [CommandParameter]@{ 
            Keys=@("rmi");
            Name="rmi"; 
            Description="Remove image"; 
            Parameters=@(
                [ValueParameter]@{ 
                    Name="image"; 
                    Description="Image to remove"; 
                    Source=$images 
                }
            )
        },
        [CommandParameter]@{ 
            Keys=@("tag"); 
            Name="tag"; 
            Description="Tag an image"; 
            Parameters=@(
                [ValueParameter]@{ 
                    Name="image"; 
                    Description="Image to tag"; 
                    Source=$images 
                }
            )
        },
        [CommandParameter]@{ 
            Keys=@("push"); 
            Name="push"; 
            Description="Push an image to registry"; 
            Parameters=@(
                [ValueParameter]@{ 
                    Name="image"; 
                    Description="Image to push"; 
                    Source=$images 
                }
            )
        },
        [CommandParameter]@{ 
            Keys=@("pull"); 
            Name="pull"; 
            Description="Pull an image"; 
            Parameters=@(
                [ValueParameter]@{ 
                    Name="image"; 
                    Description="Image to pull"; 
                    Source=$images 
                }
            )
        },

        # Contexts
        [CommandParameter]@{
            Keys = @("context");
            Name = "context";
            Description = "Manage Docker contexts";
            Parameters = @(
                [ValueParameter]@{ 
                    Keys=@("ls"); 
                    Name="ls"; 
                    Description="List contexts" 
                },
                [ValueParameter]@{ 
                    Keys=@("inspect"); 
                    Name="inspect"; 
                    Description="Inspect context"; 
                    Source=$dockerContexts 
                },
                [ValueParameter]@{ 
                    Keys=@("use"); 
                    Name="use"; 
                    Description="Switch context"; 
                    Source=$dockerContexts 
                }
            )
        },

        # System
        [CommandParameter]@{
            Keys=@("system");
            Name="system";
            Description="Inspect/manage Docker system";
            Parameters=@(
                [ValueParameter]@{ 
                    Keys=@("df"); 
                    Name="df"; 
                    Description="Show disk usage" 
                },
                [ValueParameter]@{ 
                    Keys=@("prune"); 
                    Name="prune"; 
                    Description="Remove unused objects" 
                },
                [ValueParameter]@{ 
                    Keys=@("info"); 
                    Name="info"; 
                    Description="Show system info" 
                },
                [ValueParameter]@{ 
                    Keys=@("events"); 
                    Name="events"; 
                    Description="Show events log" 
                }
            )
        },

        # Volumes
        [CommandParameter]@{
            Keys=@("volume");
            Name="volume";
            Description="Manage volumes";
            Parameters=@(
                [ValueParameter]@{ 
                    Keys=@("ls"); 
                    Name="ls"; 
                    Description="List volumes"; 
                    Source=$volumes 
                },
                [ValueParameter]@{ 
                    Keys=@("rm"); 
                    Name="rm"; 
                    Description="Remove volume"; 
                    Source=$volumes 
                }
            )
        },

        # Networks, Plugins, Swarm, Logs
        [CommandParameter]@{ 
            Keys=@("network"); 
            Name="network"; 
            Description="Manage networks" 
        },
        [CommandParameter]@{ 
            Keys=@("plugin"); 
            Name="plugin"; 
            Description="Manage plugins"; 
            Parameters=@(
            [ValueParameter]@{ 
                Keys=@("install"); 
                Name="install"; 
                Description="Install plugin" }
            )
        },
        [CommandParameter]@{ 
            Keys=@("swarm"); 
            Name="swarm"; 
            Description="Manage swarm" 
        },
        [CommandParameter]@{ 
            Keys=@("logs"); 
            Name="logs"; 
            Description="Show container logs"; 
            Parameters=@(
                [ValueParameter]@{ 
                    Name="container"; 
                    Description="Container to show logs"; 
                    Source=$containers 
                }
            )
        },
        [CommandParameter]@{ 
            Keys=@("start"); 
            Name="start"; 
            Description="Start one or more stopped containers."; 
            Parameters = @(
                [ValueParameter]@{ 
                    Name="container"; 
                    Description="Container to start."; 
                    Source=$containers 
                }
            )
        },
        [CommandParameter]@{ 
            Keys=@("pause"); 
            Name="pause"; 
            Description="Pause all processes within one or more containers."; 
            Parameters = @(
                [ValueParameter]@{ 
                    Name="container"; 
                    Description="Container to pause."; 
                    Source=$containers 
                }
            )
        },
        [CommandParameter]@{ 
            Keys=@("unpause"); 
            Name="unpause"; 
            Description="Unpause all processes within one or more containers."; 
            Parameters = @(
                [ValueParameter]@{ 
                    Name="container"; 
                    Description="Container to unpause."; 
                    Source=$containers 
                }
            )
        }
    )
}
