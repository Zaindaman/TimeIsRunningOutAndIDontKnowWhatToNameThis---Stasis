using Godot;
using System;

public partial class BulletLogic : CharacterBody2D
{
    [Export] public float Speed = 50f;
    private float _direction = 1f; // 1 = right, -1 = left

    // Backing field for inversion state
    private bool _isInversion = false;

    // Property to control inversion
    public bool IsInversion
    {
        get => _isInversion;
        set
        {
            _isInversion = value;

            // Change processing mode based on inversion
            ProcessMode = _isInversion ? ProcessModeEnum.Always : ProcessModeEnum.Pausable;
            GD.Print($"{Name} inversion set to {_isInversion}");
        }
    }

    // Call this from the spawner to set direction
    public void SetDirection(float spawnerScaleX)
    {
        _direction = MathF.Sign(spawnerScaleX); // +1 or -1
    }

    public override void _Process(double delta)
    {
        // Move in the direction inherited from spawner
        Vector2 forward = Transform.X * _direction;
        Position += forward * Speed * (float)delta;
    }
}
