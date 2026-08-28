//cheat engine search: 300000000-341FFFFFF
state("rpcs3")
{
}

init
{
  //vars.igtEU = (IntPtr)0x300646018; //EU version igt pointer
  vars.invEU = (IntPtr)0x3006465C8; //EU version inv pointer (13 on inv, 11 out)
  //vars.igtUS = (IntPtr)0x30054C190; //US version igt pointer
  vars.invUS = (IntPtr)0x30054DD20; //US version inv pointer (13 on inv, 11 out)
  //vars.igtJP = (IntPtr)0x30058C810; //JP version igt pointer
  vars.invJP = (IntPtr)0x30058E3C8; //JP version inv pointer (13 on inv, 11 out)
  vars.invState = 0;
  vars.pointerinv = IntPtr.Zero;
  /*
  vars.igt = 0.0d;
  vars.previgt = 0.0d;
  vars.previgt2 = 0.0d;
  vars.igtAux = 0.0d;
  vars.previnvState = 0;
  vars.lastTime = DateTime.UtcNow;
  vars.pointerigt = IntPtr.Zero;
  */
}

update
{
  // Determining the game version
  bool gameFound = false;
  var bytesEU = new byte[4] {0, 0, 0, 0};
  var bytesUS = new byte[4] {0, 0, 0, 0};
  var bytesJP = new byte[4] {0, 0, 0, 0};

  if (!gameFound)
  {
    if (memory.ReadBytes((IntPtr)vars.invEU, 4, out bytesEU))
    {
      Array.Reverse(bytesEU);
      if (BitConverter.ToInt32(bytesEU, 0) == 3)
      {
        gameFound = true;
        //vars.pointerigt = vars.igtEU;
        vars.pointerinv = vars.invEU;
      }
    }
    if (memory.ReadBytes((IntPtr)vars.invUS, 4, out bytesUS))
    {
      Array.Reverse(bytesUS);
      if (BitConverter.ToInt32(bytesUS, 0) == 3)
      {
        gameFound = true;
        //vars.pointerigt = vars.igtUS;
        vars.pointerinv = vars.invUS;
      }
    }
    if (memory.ReadBytes((IntPtr)vars.invJP, 4, out bytesJP))
    {
      Array.Reverse(bytesJP);
      if (BitConverter.ToInt32(bytesJP, 0) == 3)
      {
        gameFound = true;
        //vars.pointerigt = vars.igtJP;
        vars.pointerinv = vars.invJP;
      }
    }
  }

/*
  // calculates real time
  var now = DateTime.UtcNow;
  var dt = (float)(now - vars.lastTime).TotalSeconds;
  vars.lastTime = now;

  var bytes = new byte[4];
  if (memory.ReadBytes((IntPtr)vars.pointerigt, 4, out bytes))
  {
    Array.Reverse(bytes); // PS3 is big endian
    vars.igt = (double)BitConverter.ToSingle(bytes, 0);
  }
*/
  var bytes2 = new byte[4];
  if (memory.ReadBytes((IntPtr)vars.pointerinv, 4, out bytes2))
  {
    Array.Reverse(bytes2);
    vars.invState = BitConverter.ToInt32(bytes2, 0);
  }
/*
  bool conti = (vars.previgt2 == vars.igt && vars.invState != 12); //12 is pause menu

  if (vars.igt > vars.previgt)
  {
    vars.igtAux += (vars.igt - vars.previgt) + 0.00001d; // small correction to avoid losing time
  }
  else
  {
    if (conti && timer.CurrentPhase == TimerPhase.Running)
      vars.igtAux += dt; //timer continues on everything that is not pause menu
  }
  vars.previgt2 = vars.previgt;
  vars.previgt = vars.igt;
*/
}

isLoading
{
  if (vars.invState == 12) //12 is pause menu
  {
    return true;
  }
  else
  {
    return false;
  }
}

/*
start
{
  if (vars.invState == 11 && vars.previnvState == 9)
  {
    return true;
  }
  vars.previnvState = vars.invState;
}

onStart
{
  vars.igtAux = vars.igt;
}

isLoading
{
  return true;
}

onReset
{
  vars.igtAux = 0.0d;
  vars.igt = 0.0d;
  vars.previgt = 0.0d;
  vars.invState = 0;
  vars.previnvState = 0;
}

gameTime
{
  // IGT is in seconds
  return TimeSpan.FromSeconds((double)vars.igtAux);
}
*/
