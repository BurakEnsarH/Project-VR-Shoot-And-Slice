using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
using UnityEngine.UI;
public class GameSceneManager : MonoBehaviour
{
    [Header("UI")]
    public TextMeshProUGUI timeText;
    public Image progressBarImage;
    public GameObject timerUI_Gameobject;

    [Header("Managers")]
    public GameObject cubeSpawnManager;

    //Audio related
    float audioClipLength;
    private float timeToStartGame = 5.0f;

    public GameObject currentScoreUI_Gameobject;
    public GameObject finalScoreUI_Gameobject;

    // Start is called before the first frame update
    void Start()
    {
        //Getting the duration of the song
        audioClipLength = AudioManager.instance.musicTheme.clip.length;
        Debug.Log(audioClipLength);

        //Starting the countdown with song
        StartCoroutine(StartCountdown(audioClipLength));

        //Resetting progress bar
        progressBarImage.fillAmount = Mathf.Clamp(0, 0, 1);



        finalScoreUI_Gameobject.SetActive(false);
        currentScoreUI_Gameobject.SetActive(true);
    }


    public IEnumerator StartCountdown(float countdownValue)
    {
        while (countdownValue > 0)
        {
            yield return new WaitForSeconds(1.0f);
            countdownValue -= 1;

            timeText.text = ConvertToMinAndSeconds(countdownValue);

            progressBarImage.fillAmount = (AudioManager.instance.musicTheme.time / audioClipLength);

        }
        GameOver();
    }


    public void GameOver()
    {
        Debug.Log("Game Over");
        timeText.text = ConvertToMinAndSeconds(0);

        //Disable cube spawning
        cubeSpawnManager.SetActive(false);

        //Disable timer UI
        timerUI_Gameobject.SetActive(false);

        currentScoreUI_Gameobject.SetActive(false);
        finalScoreUI_Gameobject.SetActive(true);

        //Putting the Final Score UI in front of the OVRCameraRig
        finalScoreUI_Gameobject.transform.rotation = Quaternion.Euler(Vector3.zero);
        finalScoreUI_Gameobject.transform.position = GameObject.Find("OVRCameraRig").transform.position+ new Vector3(0,2.0f,4.0f);

    }


    private string ConvertToMinAndSeconds(float totalTimeInSeconds)
    {
        string timeText = Mathf.Floor(totalTimeInSeconds / 60).ToString("00") + ":" + Mathf.FloorToInt(totalTimeInSeconds % 60).ToString("00");
        return timeText;
    }


    public void BackToLobbyScene()
    {
        SceneLoader.instance.LoadScene("LobbyScene");
    }
  
}
