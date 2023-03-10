using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
public class ScoreManager : MonoBehaviour
{

    public int currentScore; 
    public int highScore;

    [Header("UI Fields")]
    public TextMeshProUGUI hightScoreText;
    public TextMeshProUGUI currentScoreText;
    public TextMeshProUGUI finalScoreText;



    public static ScoreManager instance;

    private void Awake()
    {
        if (instance != null && instance != this)
        {
            Destroy(this.gameObject);
            return;
        }

        instance = this;
        // DontDestroyOnLoad(gameObject);
    }


    // Start is called before the first frame update
    void Start()
    {
        highScore = PlayerPrefs.GetInt("HighScore",0);
        hightScoreText.text = highScore.ToString();

        //Set the current score as 0.
        currentScoreText.text = "0";

    }


    public void AddScore(int scorePoint)
    {
        currentScore = currentScore + scorePoint;
        PlayerPrefs.SetInt("CurrentScore",currentScore);

        
        //Display the current score in UI
        currentScoreText.text = currentScore.ToString();

        //Also, update the final score
        finalScoreText.text = currentScore.ToString();

        if (currentScore > PlayerPrefs.GetInt("HighScore",0))
        {
            PlayerPrefs.SetInt("HighScore",currentScore);
            hightScoreText.text = currentScore.ToString();

        }
    }
}
