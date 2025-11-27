using Godot;
using System;

// 1. Change the base class to Node2D
public partial class BulletLogic : Node2D
{
    [Export] public float Speed = 50f;

    private GlobalValues globalValues;

    public bool isInversion { get; set; } = false;

    // NOTE: If you need collision detection, make the root node an Area2D and manage it there.

    public override void _Ready()
    {
        // Still necessary for the custom pause logic to run
        ProcessMode = ProcessModeEnum.Always;

        globalValues = GetNode<GlobalValues>("/root/GlobalValues");
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

            // 3. Move the position directly along the forward vector (Transform.X)
            // This is the simplest straight-line movement and entirely bypasses MoveAndSlide().
            Position += Transform.X.Normalized() * step;
        }
        // When paused, no movement happens because the loop skips the code block.
    }

    // NOTE: If you switch to Node2D, you must implement your own
    // collision detection (e.g., using an Area2D child and checking signals).
}