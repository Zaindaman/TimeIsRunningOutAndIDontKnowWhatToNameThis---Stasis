using Godot;
using System;

public partial class BulletSpawner : CharacterBody2D
{
    [Export] public PackedScene Bullet;
    [Export] public float xOffsetDistance = 100f;
    // 🎯 NEW: Export a float for the vertical offset
    [Export] public float yOffsetDistance = 0f;

    private GlobalValues globalValues;

    private Timer _myTimer;

    public override void _Ready()
    {
        ProcessMode = ProcessModeEnum.Always;

        globalValues = GetNode<GlobalValues>("/root/GlobalValues");


        _myTimer = GetNode<Timer>("Timer");

        // Start the timer immediately so the pause/unpause logic works
        _myTimer.Start();

        _myTimer.Timeout += _on_timer_timeout; // Connect the Timeout signal
    }

    public override void _Process(double delta)
    {
        if (globalValues.isBulletTime)
        {
            if (!_myTimer.IsStopped())
            {
                PauseTimer();
            }
        }
        else
        {
            if (_myTimer.IsStopped())
            {
                UnpauseTimer();
            }
        }
    }

    public void PauseTimer()
    {
        _myTimer.Stop(); // Stop preserves time_left, acting as a pause
    }

    public void UnpauseTimer()
    {
        _myTimer.Start(); // Start resumes or restarts the timer
    }


    private void _on_timer_timeout()
    {
        if (Bullet == null)
            return;

        // Instantiate the bullet
        BulletLogic newBullet = Bullet.Instantiate<BulletLogic>();

        // 🎯 FIX: Horizontal offset (along local X-axis)
        Vector2 xOffset = Transform.X * xOffsetDistance * MathF.Sign(GlobalScale.X);

        // Transform.Y gives the local 'up' direction regardless of spawner rotation
        Vector2 yOffset = Transform.Y * yOffsetDistance;

        // Combine the spawner's position, the horizontal, and the vertical offsets
        Vector2 spawnPosition = GlobalPosition + xOffset + yOffset;

        newBullet.Position = spawnPosition;

        // Set the bullet's movement direction based on spawner's X scale
        newBullet.SetDirection(GlobalScale.X);

        // Optional: match bullet rotation to spawner
        newBullet.GlobalRotation = GlobalRotation;

        // Add bullet to the current scene
        GetTree().CurrentScene.AddChild(newBullet);
    }
}