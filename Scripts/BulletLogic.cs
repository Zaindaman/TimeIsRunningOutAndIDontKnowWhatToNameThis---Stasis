using Godot;
using System;

// 1. Change the base class to Node2D
public partial class BulletLogic : Node2D
{
    [Export] public float Speed = 50f;

    private GlobalValues globalValues;

    public bool isInversion { get; set; } = false;

    private Area2D _area2D;

    private Timer _lifetimeTimer;

    // NOTE: If you need collision detection, make the root node an Area2D and manage it there.

    public override void _Ready()
    {
        // Still necessary for the custom pause logic to run
        ProcessMode = ProcessModeEnum.Always;

        globalValues = GetNode<GlobalValues>("/root/GlobalValues");
        _area2D = GetNode<Area2D>("Area2D");
        _area2D.Monitorable = true;


        _lifetimeTimer = GetNode<Timer>("BulletLifeTime");

        _lifetimeTimer.Timeout += _on_bullet_life_time_timeout;

        _lifetimeTimer.Start();
    }

    // SetDirection is retained for spawner compatibility, but unused
    public void SetDirection(float baseDirection) { }

    // 2. Use _Process(double delta) for smooth, non-physics movement
    public override void _Process(double delta)
    {
        // If NOT paused, OR (IF paused AND exempt)
        if (!globalValues.isBulletTime || isInversion)
        {
            // Calculate the forward step amount
            float step = Speed * (float)delta;

            _area2D.Monitorable = true;

            Position += Transform.X.Normalized() * step;

            _lifetimeTimer.Paused = false;
        }
        else
        {

            _area2D.Monitorable = false;
            _lifetimeTimer.Paused = true;
        }
    }


    private void _on_bullet_life_time_timeout()
    {
        QueueFree();
    }
}