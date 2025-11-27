using Godot;
using System;

public partial class BulletSpawner : CharacterBody2D
{
    [Export] public PackedScene Bullet;
    [Export] public float xOffsetDistance = 100f;
    [Export] public float yOffsetDistance = 0f;

    // ... (GlobalValues and Timer setup remains the same) ...
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
        // ... (Pause/Unpause logic remains the same) ...
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

    public void PauseTimer() { _myTimer.Stop(); }
    public void UnpauseTimer() { _myTimer.Start(); }


    private void _on_timer_timeout()
    {
        if (Bullet == null)
            return;

        BulletLogic newBullet = Bullet.Instantiate<BulletLogic>();

        // 1. Get the forward vector. This correctly handles spawner rotation and flip/scale.
        // Transform.X always points along the node's local X-axis.
        Vector2 forwardVector = Transform.X.Normalized();

        // 2. Calculate the perpendicular (local Y) vector.
        Vector2 perpendicularVector = Transform.Y;

        // 3. NEW SPAWN POSITION CALCULATION:
        // Use the forward vector for the X offset, and the perpendicular vector for the Y offset.
        Vector2 spawnPosition = GlobalPosition
                              + (forwardVector * xOffsetDistance)
                              + (perpendicularVector * yOffsetDistance);

        newBullet.GlobalPosition = spawnPosition; // Use GlobalPosition when setting to scene

        // 4. Set the bullet's rotation to match the spawner.
        // This is the cleanest way to set the bullet's direction.
        newBullet.GlobalRotation = GlobalRotation;

        // 5. Tell the bullet its base direction is simply '1' (forward). 
        // The rotation already handles the facing direction.
        newBullet.SetDirection(1f);

        // Add bullet to the current scene
        GetTree().CurrentScene.AddChild(newBullet);
    }
}