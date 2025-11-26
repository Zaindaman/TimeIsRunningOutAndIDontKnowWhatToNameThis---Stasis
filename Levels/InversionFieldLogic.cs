using Godot;
using System;
using static Godot.DisplayServer;

public partial class InversionFieldLogic : Area2D
{
    public override void _Ready()
    {
        ProcessMode = ProcessModeEnum.Pausable;

        // Connect the "body_entered" signal to a method in this script
        BodyEntered += OnBodyEntered;
        // Connect the "body_exited" signal if you need to know when bodies leave
        BodyExited += OnBodyExited;
    }

    private void OnBodyEntered(Node2D body)
    {
        GD.Print($"Body entered: {body.Name}");
    }


    private void OnBodyExited(Node2D body)
    {
        GD.Print($"Body exited: {body.Name}");
    }

}
