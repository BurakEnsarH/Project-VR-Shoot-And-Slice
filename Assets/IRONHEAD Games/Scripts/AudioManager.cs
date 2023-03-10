using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;
public class AudioManager : MonoBehaviour
{

    public AudioSource sliceSound;
    public AudioSource gunSound;
    public AudioSource musicTheme;
    public AudioSource buttonClickSound;


    public static AudioManager instance;

    private void Awake()
    {
        if (instance != null && instance != this)
        {
            Destroy(this.gameObject);
            return;
        }

        instance = this;
    }

   
}
