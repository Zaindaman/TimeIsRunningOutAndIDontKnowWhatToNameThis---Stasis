using Godot;
using System;

public partial class BulletSpawner : CharacterBody2D
{
    [Export]
    public PackedScene Bullet;
    [Export]
    public float offsetDistance = 100f;


    private void _on_timer_timeout()
    {
        Node2D newBullet = Bullet.Instantiate<Node2D>();

        Vector2 spawnPosition = GlobalPosition + new Vector2(MathF.Cos(Rotation), MathF.Sin(Rotation)) * offsetDistance;

        newBullet.Position = spawnPosition;

        GetTree().CurrentScene.AddChild(newBullet);


    }

}
