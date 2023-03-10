using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Shooting : MonoBehaviour
{
   
    public float fireRate = 0.1f;
    public GameObject bulletPrefab;

    float elapsedTime;

    public Transform nozzleTransform;

 
    public Animator gunAnimator;


    public OVRInput.Button ShootingButton;

    public GameObject slicerGameobject;

    // Update is called once per frame
    void Update()
    {
        //elapsed time
        elapsedTime += Time.deltaTime;

        if (Input.GetMouseButtonDown(0) || OVRInput.GetDown(ShootingButton, OVRInput.Controller.LTouch))
        {
            if (elapsedTime > fireRate)
            {
                Shoot();
                
                elapsedTime = 0;
            }
        }

    }

    private void Shoot()
    {
        //Play sound
        AudioManager.instance.gunSound.gameObject.transform.position = nozzleTransform.position;
        AudioManager.instance.gunSound.Play();

        //Play animation
        gunAnimator.SetTrigger("Fire");

      
        //Create the bullet
        GameObject bulletGameobject = Instantiate(bulletPrefab, nozzleTransform.position, Quaternion.Euler(0, 0, 0));
        bulletGameobject.transform.forward = nozzleTransform.forward;

        Physics.IgnoreCollision(bulletGameobject.GetComponent<Collider>(),slicerGameobject.GetComponent<Collider>());

    }

   


}
