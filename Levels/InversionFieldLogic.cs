using Godot;
using System;
using System.Collections.Generic;

public partial class InversionFieldLogic : Area2D
{
    private readonly HashSet<CharacterBody2D> bodiesInField = new();

    public override void _Ready()
    {
        ProcessMode = ProcessModeEnum.Always;

        // Connect signals
        BodyEntered += OnBodyEntered;
        BodyExited += OnBodyExited;
    }

    private void OnBodyEntered(Node body)
    {
        // Only set inversion if the body has the IsInversion property
        var prop = body.GetType().GetProperty("IsInversion");
        if (prop != null)
        {
            prop.SetValue(body, true);
            GD.Print($"{body.Name} entered inversion field");
        }
    }

    private void OnBodyExited(Node body)
    {
        var prop = body.GetType().GetProperty("IsInversion");
        if (prop != null)
        {
            prop.SetValue(body, false);
            GD.Print($"{body.Name} exited inversion field");
        }
    }
}