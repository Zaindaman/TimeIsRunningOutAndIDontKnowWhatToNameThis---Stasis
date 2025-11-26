using Godot;
using System;

public partial class BulletLogic : CharacterBody2D
{
    [Export] public float Speed = 50f;

    private bool isInversion = false;

    public override void _PhysicsProcess(double delta)
    {
        Vector2 forward = Transform.X; // direction the bullet is facing
        Position += forward * Speed * (float)delta;
    }
}