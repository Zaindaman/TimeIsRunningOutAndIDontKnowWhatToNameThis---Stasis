using Godot;
using System;

public partial class BulletSpawner : CharacterBody2D
{
    [Export] public PackedScene Bullet;
    [Export] public float xOffsetDistance = 200f;
    [Export] public float yOffsetDistance = 0f;

    private GlobalValues globalValues;
    private Timer _myTimer;

    public override void _Ready()
    {
        ProcessMode = ProcessModeEnum.Always;
        globalValues = GetNode<GlobalValues>("/root/GlobalValues");
        _myTimer = GetNode<Timer>("Timer");
        _myTimer.Start();
        _myTimer.Timeout += _on_timer_timeout;
    }

    public override void _Process(double delta)
    {
        // Timer pause/unpause logic remains clean
        if (globalValues.isBulletTime)
        {
            if (!_myTimer.IsStopped())
            {
                _myTimer.Stop();
            }
        }
        else
        {
            if (_myTimer.IsStopped())
            {
                _myTimer.Start();
            }
        }
    }

    // Removed the separate PauseTimer/UnpauseTimer functions for brevity
    // private void PauseTimer() { _myTimer.Stop(); }
    // private void UnpauseTimer() { _myTimer.Start(); }


    private void _on_timer_timeout()
    {
        if (Bullet == null)
            return;

        BulletLogic newBullet = Bullet.Instantiate<BulletLogic>();

        // Get vectors based on spawner rotation and scale
        Vector2 forwardVector = Transform.X;
        Vector2 perpendicularVector = Transform.Y;

        // Calculate spawn position
        Vector2 spawnPosition = GlobalPosition
               + (forwardVector * xOffsetDistance)
               + (perpendicularVector * yOffsetDistance);

        newBullet.GlobalPosition = spawnPosition;

        // The key to straight movement: set the bullet's rotation
        newBullet.GlobalRotation = GlobalRotation;

        // SetDirection is now vestigial but called for completeness
        newBullet.SetDirection(1f);

        GetTree().CurrentScene.AddChild(newBullet);
    }
}