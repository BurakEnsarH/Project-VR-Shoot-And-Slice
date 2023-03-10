using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SceneLoader : MonoBehaviour
{


    public OVROverlay overlay_Background;
    public OVROverlay overlay_LoadingText;


    public static SceneLoader instance;

    private void Awake()
    {
        if (instance !=null && instance != this)
        {
            Destroy(this.gameObject);
            return;
        }

        instance = this;
        DontDestroyOnLoad(gameObject);
    }



    public void LoadScene(string sceneName)
    {
        StartCoroutine(ShowOverlayAndLoad(sceneName));
    }

    IEnumerator ShowOverlayAndLoad(string sceneName)
    {
        overlay_Background.enabled = true;
        overlay_LoadingText.enabled = true;

        GameObject centerEyeAnchor = GameObject.Find("CenterEyeAnchor");
        overlay_LoadingText.gameObject.transform.position = centerEyeAnchor.transform.position + new Vector3(0f,0f,3f);



        //Waiting some seconds to prevent "pop" to new scene
        yield return new WaitForSeconds(5f);

        //Load Scene and wait until complete
        AsyncOperation asyncLoad = UnityEngine.SceneManagement.SceneManager.LoadSceneAsync(sceneName);

        while (!asyncLoad.isDone)
        {
            yield return null;
        }

        //Disabling the overlays again
        overlay_Background.enabled = false;
        overlay_LoadingText.enabled = false;

        yield return null;

    }

}
