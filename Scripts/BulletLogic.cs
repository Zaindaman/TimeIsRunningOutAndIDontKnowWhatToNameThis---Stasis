using Godot;
using System;

public partial class BulletLogic : CharacterBody2D
{
    [Export] public float Speed = 50f;
    private float _direction = 1f; // 1 = right, -1 = left

    private GlobalValues globalValues;

    public override void _Ready()
    {
        globalValues = GetNode<GlobalValues>("/root/GlobalValues");
    }

    // Backing field for inversion state
    public bool isInversion { get; set; } = false;




    // Call this from the spawner to set direction
    public void SetDirection(float spawnerScaleX)
    {
        _direction = MathF.Sign(spawnerScaleX); // +1 or -1
    }

    public override void _Process(double delta)
    {

        if (globalValues.isBulletTime)
        {
            if (isInversion)
            {
                Vector2 forward = Transform.X * _direction;
                Position += forward * Speed * (float)delta;
            }
            else
            {
                Vector2 forward = Vector2.Zero; // bullet doesn’t move
            }
        }
        else
        {
            Vector2 forward = Transform.X * _direction;
            Position += forward * Speed * (float)delta;
        }
    }
}
