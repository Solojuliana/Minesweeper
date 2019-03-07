import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 50;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); 
//ArrayList of just the minesweeper buttons that are mined



void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int row = 0; row < NUM_ROWS; row++){
      for(int col = 0; col < NUM_COLS; col++){
        buttons[row][col] = new MSButton(row,col);
      }
    }
    
    setBombs();
}
public void setBombs()
{
    //your code
    while(bombs.size()<NUM_BOMBS)
    {
      int r = (int)(Math.random()*NUM_ROWS);
      int c = (int)(Math.random()*NUM_COLS);
      if(!bombs.contains(buttons[r][c]));
      {
          bombs.add(buttons[r][c]);
          //System.out.println(r + ", " + c);
      }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for (int r=0; r<NUM_ROWS; r++)
  {
    for (int c=0; c<NUM_COLS; c++)
    {
      if (!buttons[r][c].isClicked() && !bombs.contains(buttons[r][c]))
      {
        return false;
      }
    }
  }
    return false;
}
public void displayLosingMessage()
{
    //your code here
  for (int r=0; r<NUM_ROWS; r++)
  {
    for (int c=0; c<NUM_COLS; c++)
    {
      if (bombs.contains(buttons[r][c])&& !buttons[r][c].isClicked())
      {
        buttons[r][c].marked=false;
        buttons[r][c].clicked=true;
      }
    }
  }
  buttons[9][9].label="Y";
  buttons[9][10].label="O";
  buttons[9][11].label="U";
  buttons[9][12].label="";
  buttons[10][8].label="L";
  buttons[10][9].label="O";
  buttons[10][10].label="S";
  buttons[10][11].label="E";
  buttons[10][12].label="!";
}
public void displayWinningMessage()
{
    //your code here
  buttons[9][9].label="Y";
  buttons[9][10].label="O";
  buttons[9][11].label="U";
  buttons[9][12].label="";
  buttons[10][8].label="W";
  buttons[10][9].label="O";
  buttons[10][10].label="N";
  buttons[10][11].label="!";
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
   
    
    public void mousePressed () 
    {
        
        //your code here
        if(mouseButton==LEFT&&!marked){
            clicked = true;
        if(bombs.contains(this)){
            displayLosingMessage();

        }else if(countBombs(r,c)>0){
            label=""+countBombs(r,c);
        }
        else
        {
          if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
            buttons[r][c-1].mousePressed();
          if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
            buttons[r][c+1].mousePressed();
          if(isValid(r-1,c) && !buttons[r-1][c].isClicked())
            buttons[r-1][c].mousePressed();
          if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
            buttons[r+1][c].mousePressed();
          if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
            buttons[r-1][c-1].mousePressed();
          if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
            buttons[r+1][c+1].mousePressed();
          if(isValid(r-1,c+1) && !buttons[r-1][c+1].isClicked())
            buttons[r-1][c+1].mousePressed();
          if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
            buttons[r+1][c-1].mousePressed();
          }
      }
      if(mouseButton ==RIGHT){
          marked=!marked;
      }
    }

    public void draw () 
    {    
        if(marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r>=0 && r<NUM_ROWS && c>=0 && c<NUM_COLS)
          return true;
        else
          return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //how to check if return is greater than zero?
        for(int r = row-1; r<=row+1; r++)
         {
           for(int c = col -1; c<=col+1; c++){
             if(isValid(r,c) && bombs.contains(buttons[r][c]))
             {
               numBombs++;
             }
           }
         }
        return numBombs;
    }
}
