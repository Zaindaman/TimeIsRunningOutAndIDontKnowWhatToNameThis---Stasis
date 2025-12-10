using Godot;
using System;
using System.Collections.Generic;

public partial class InversionFieldLogic : Area2D
{
	private readonly HashSet<CharacterBody2D> bodiesInField = new();


	private GlobalValues globalValues;


	public override void _Ready()
	{
		globalValues = GetNode<GlobalValues>("/root/GlobalValues");

		ProcessMode = ProcessModeEnum.Always;

		BodyEntered += OnBodyEntered;
		BodyExited += OnBodyExited;
	}

	private void OnBodyEntered(Node body)
	{

        if (body is CharacterBody2D charBody)
        {
            charBody.Set("isInversion", true);
            var prop = charBody.GetType().GetProperty("isInversion");
            if (prop != null) prop.SetValue(charBody, true);
            GD.Print($"{charBody.Name} exited inversion field (bullet time active)");
        }

    }

    private void OnBodyExited(Node body)
    {
        if (body is CharacterBody2D charBody)
        {
            charBody.Set("isInversion", false);
            var prop = charBody.GetType().GetProperty("isInversion");
            if (prop != null) prop.SetValue(charBody, false);
            GD.Print($"{charBody.Name} exited inversion field (bullet time active)");
        }
    }


}
