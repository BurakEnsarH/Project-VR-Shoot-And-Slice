using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using TMPro;
public class ButtonPushClick : MonoBehaviour
{
    public float MinLocalY = 0.25f;
    public float MaxLocalY = 0.55f;
  
    public bool isBeingTouched = false;
    public bool isClicked = false;

    public Material greenMat;

    public GameObject timeCountDownCanvas;
    public TextMeshProUGUI timeText;

    public float smooth = 0.1f;
    // Start is called before the first frame update
    void Start()
    {
        // Start with button up top / popped up
        transform.localPosition = new Vector3(transform.localPosition.x, MaxLocalY, transform.localPosition.z);

        timeCountDownCanvas.SetActive(false);

    }

  

    private void Update()
    {
        Vector3 buttonDownPosition = new Vector3(transform.localPosition.x, MinLocalY, transform.localPosition.z);
        Vector3 buttonUpPosition = new Vector3(transform.localPosition.x, MaxLocalY, transform.localPosition.z);
        if (!isClicked)
        {
            if (!isBeingTouched && (transform.localPosition.y > MaxLocalY  || transform.localPosition.y < MaxLocalY))
            {
                transform.localPosition = Vector3.Lerp(transform.localPosition, buttonUpPosition, Time.deltaTime * smooth);
            }

            if (transform.localPosition.y < MinLocalY)
            {
                isClicked = true;               
                transform.localPosition = buttonDownPosition;
                OnButtonDown();
            }
        }
      
    }


    void OnButtonDown()
    {
        GetComponent<MeshRenderer>().material = greenMat;
        GetComponent<Collider>().isTrigger = true;

        ////Playing Sound
        AudioManager.instance.buttonClickSound.gameObject.transform.position = transform.position;
        AudioManager.instance.buttonClickSound.Play();

        //Start the game
        StartCoroutine(StartGame(3));
      
    }


    IEnumerator StartGame(float countDownValue)
    {
        timeText.text = countDownValue.ToString();
        timeCountDownCanvas.SetActive(true);

        
        while (countDownValue > 0)
        {

            yield return new WaitForSeconds(1.0f);
            countDownValue -= 1;

            timeText.text = countDownValue.ToString();

        }
        //Load Scene
        SceneLoader.instance.LoadScene("GameScene");
        
        
    }

    private void OnTriggerEnter(Collider other)
    {
        if (isClicked)
        {
            ////Playing Sound
            AudioManager.instance.buttonClickSound.gameObject.transform.position = transform.position;
            AudioManager.instance.buttonClickSound.Play();
        }
    }

    private void OnCollisionStay(Collision collision)
    {
        if (collision.collider.gameObject.tag != "BackButton")
        {
            isBeingTouched = true;
        }

    }

    private void OnCollisionExit(Collision collision)
    {
        if (collision.collider.gameObject.tag != "BackButton")
        {
            isBeingTouched = false;

        }
    }



}
