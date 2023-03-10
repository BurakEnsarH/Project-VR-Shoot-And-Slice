using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VibrationManager : MonoBehaviour
{


    public static VibrationManager instance;

    private void Awake()
    {
        if (instance != null && instance != this)
        {
            Destroy(this.gameObject);
            return;
        }

        instance = this;
        DontDestroyOnLoad(gameObject);
    }



    public void VibrateController(float duration, float frequency, float amplitude, OVRInput.Controller controller)
    {
        StartCoroutine(VibrateForSeconds(duration,frequency,amplitude,controller));
    }

    IEnumerator VibrateForSeconds(float duration, float frequency, float amplitude, OVRInput.Controller controller)
    {
        //Starts the vibration
        OVRInput.SetControllerVibration(frequency,amplitude,controller);

        //Executing the vibration for the duration seconds
        yield return new WaitForSeconds(duration);

        //Stops vibration after duration seconds
        OVRInput.SetControllerVibration(0,0,controller);

    }

















}
