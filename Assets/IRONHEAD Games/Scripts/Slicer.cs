using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using EzySlice;
public class Slicer : MonoBehaviour
{
    public Material MaterialAfterSlice;
    public LayerMask sliceMask;

    public bool isTouched;

    private void Update()
    {     
        if (isTouched == true)
        {
            isTouched = false;
            Collider[] objectsToBeSliced = Physics.OverlapBox(transform.position, new Vector3(1, 0.1f, 0.1f), transform.rotation, sliceMask);
            foreach (Collider objectToBeSliced in objectsToBeSliced)
            {
              
                SlicedHull slicedObject = SliceObject(objectToBeSliced.gameObject, MaterialAfterSlice);

                GameObject upperHullGameobject = slicedObject.CreateUpperHull(objectToBeSliced.gameObject, MaterialAfterSlice);
                GameObject lowerHullGameobject = slicedObject.CreateLowerHull(objectToBeSliced.gameObject, MaterialAfterSlice);

                //Play slice sound
                AudioManager.instance.sliceSound.gameObject.transform.position = objectToBeSliced.transform.position;
                AudioManager.instance.sliceSound.Play();

                //Starts the vibration
                VibrationManager.instance.VibrateController(0.4f, 1, 0.3f, OVRInput.Controller.RTouch);

                //Add score
                ScoreManager.instance.AddScore(ScorePoints.SWORDCUBE_SCOREPOINT);


                upperHullGameobject.transform.position = objectToBeSliced.transform.position;
                lowerHullGameobject.transform.position = objectToBeSliced.transform.position;
               

                MakeItPhysical(upperHullGameobject, objectToBeSliced.gameObject.GetComponent<Rigidbody>().velocity);
                MakeItPhysical(lowerHullGameobject, objectToBeSliced.gameObject.GetComponent<Rigidbody>().velocity);

                Destroy(objectToBeSliced.gameObject);
            }
        }

    }
    private void MakeItPhysical(GameObject obj, Vector3 _velocity)
    {
        obj.AddComponent<MeshCollider>().convex = true;
        obj.AddComponent<Rigidbody>();
        obj.GetComponent<Rigidbody>().velocity = -_velocity;

        int randomNumberX = Random.Range(0,2);
        int randomNumberY = Random.Range(0, 2);
        int randomNumberZ = Random.Range(0, 2);

        obj.GetComponent<Rigidbody>().AddForce(3*new Vector3(randomNumberX,randomNumberY,randomNumberZ),ForceMode.Impulse);       
        obj.AddComponent<DestroyAfterSeconds>();

    }

   

    private SlicedHull SliceObject(GameObject obj, Material crossSectionMaterial = null)
    {
        // slice the provided object using the transforms of this object
        return obj.Slice(transform.position, transform.up, crossSectionMaterial);
    }

}
