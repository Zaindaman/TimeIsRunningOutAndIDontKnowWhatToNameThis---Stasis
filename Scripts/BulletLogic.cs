using Godot;
using System;

public partial class BulletLogic : CharacterBody2D
{
    [Export] public float Speed = 50f;

    private float _direction = 1f; // 1 = right, -1 = left
    private GlobalValues globalValues;

    public bool isInversion { get; set; } = false;

    public override void _Ready()
    {
        globalValues = GetNode<GlobalValues>("/root/GlobalValues");
    }

    // Called by the spawner
    public void SetDirection(float spawnerScaleX)
    {
        _direction = MathF.Sign(spawnerScaleX); // +1 or -1
        // No need to flip Scale here; direction is handled in _Process
    }

    public override void _Process(double delta)
    {
        Vector2 forward = Vector2.Zero;

        if (!globalValues.isBulletTime || (globalValues.isBulletTime && isInversion))
        {
            // Move in the bullet's local X, multiplied by direction
            forward = Transform.X.Normalized() * _direction;
        }

        Position += forward * Speed * (float)delta;
    }
}
