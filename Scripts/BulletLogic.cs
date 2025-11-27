using Godot;
using System;

public partial class BulletLogic : CharacterBody2D
{
    [Export] public float Speed = 800f; // Ensure speed is fast!

    private float _direction = 1f; // Keep this, but it will always be 1 now
    private GlobalValues globalValues;
    private Area2D _area2D;

    public bool isInversion { get; set; } = false;

    public override void _Ready()
    {
        // ... (Node setup remains the same) ...
        _area2D = GetNode<Area2D>("Area2D");
        _area2D.Monitorable = true;
        globalValues = GetNode<GlobalValues>("/root/GlobalValues");
    }

    // Called by the spawner, now typically called with 1f
    public void SetDirection(float baseDirection)
    {
        _direction = baseDirection;
    }

    public override void _PhysicsProcess(double delta)
    {
        Vector2 velocity = Vector2.Zero;

        if (!globalValues.isBulletTime || (globalValues.isBulletTime && isInversion))
        {
            _area2D.Monitorable = true;

            // 🎯 FIX: Rely purely on the bullet's current rotation (Transform.X) 
            // for the forward vector. This is guaranteed to be consistent.
            velocity = Transform.X * _direction * Speed;
        }
        else
        {
            _area2D.Monitorable = false;
            // velocity remains Vector2.Zero
        }

        Velocity = velocity;
        MoveAndSlide();
    }
}