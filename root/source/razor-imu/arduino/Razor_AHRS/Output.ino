/* This file is part of the Razor AHRS Firmware */


#define g0 980.665f //acceleration due to gravity in cm/s^2
#define Accel_Scale(x) x*(g0/GRAVITY)

//scale_sensors: convert numerical readings from sensors to physical values
void scale_sensors()
{
  //first must normalize the acceleration vector
  float length = sqrt(accel[0] * accel[0] + accel[1] * accel[1] + accel[2] * accel[2]);
  accel[0] = (accel[0] / length) * g0;
  accel[1] = (accel[1] / length) * g0;
  accel[2] = (accel[2] / length) * g0;
  //Accel_Scale not needed because of normalized accelerations 
  /* accel[0] = Accel_Scale(accel[0]); */
  /* accel[1] = Accel_Scale(accel[1]); */
  /* accel[2] = Accel_Scale(accel[2]); */

}

// Output mine: yaw (heading) {MAG_Heading as well, for now}, then sensor values
void output_mine()
{
  float compass_offset = 11.0; //OFFSET for observed compass error (IN DEGREES) **STILL NEED TO MEASURE BETTER **ON BATTERIES** **ON FLOOR**, 17.0 might not be right***
  //have to account
  float my_yaw = yaw + TO_RAD(compass_offset); //since yaw is stored in radians
  float my_MAG = MAG_Heading + TO_RAD(compass_offset);
  if (my_yaw < 0)
  {
    my_yaw += 6.283185307; //2*pi
    my_MAG += 6.283185307;
  }
  float headings[3];
  float ypr[3];  
  ypr[0] = TO_DEG(yaw);
  ypr[1] = TO_DEG(pitch);
  ypr[2] = TO_DEG(roll);
  headings[0] = TO_DEG(my_yaw);
  headings[1] = TO_DEG(my_MAG);
  headings[2] = TO_DEG(MAG_Heading);
  if (output_format == OUTPUT__FORMAT_BINARY)
  {
    unsigned char buf[4]; //can do this bc we know unsigned long is 32 bits
    unsigned char buf2[4]; //for dt
    memcpy(buf, &timestamp, 4);
    memcpy(buf2, &dt, 4);
    Serial.write((byte*) ypr, 12);  // No new-line
    Serial.write((byte*) headings, 12); //these 4 lines are 3xfloats
    Serial.write((byte*) accel, 12);   // No new-line between
    Serial.write((byte*) magnetom, 12);
    Serial.write((byte*) gyro, 12);
    Serial.write(buf, 4);
    Serial.write(buf2, 4);
  }
  else if (output_format == OUTPUT__FORMAT_TEXT)
  {
    Serial.print("millis()="); Serial.print(timestamp); Serial.print(",");
    Serial.print("dt="); Serial.print(dt); Serial.print(",");
    Serial.print("Yaw="); Serial.print(ypr[0]); Serial.print(",");
    Serial.print("Pitch="); Serial.print(ypr[1]); Serial.print(",");
    Serial.print("Roll="); Serial.print(ypr[2]); Serial.print(",");

    Serial.print("Yaw(offset)="); Serial.print(headings[0]); Serial.print(",");
    Serial.print("MAG_H(offset)="); Serial.print(headings[1]); Serial.print(",");
    Serial.print("MAG_H(raw)="); Serial.print(headings[2]); Serial.print(",");

    Serial.print("Ax="); Serial.print(accel[0]); Serial.print(",");
    Serial.print("Ay="); Serial.print(accel[1]); Serial.print(",");
    Serial.print("Az="); Serial.print(accel[2]); Serial.print(",");

    Serial.print("Mx="); Serial.print(magnetom[0]); Serial.print(",");
    Serial.print("My="); Serial.print(magnetom[1]); Serial.print(",");
    Serial.print("Mz="); Serial.print(magnetom[2]); Serial.print(",");

    Serial.print("Gx="); Serial.print(gyro[0]); Serial.print(",");
    Serial.print("Gy="); Serial.print(gyro[1]); Serial.print(",");
    Serial.print("Gz="); Serial.print(gyro[2]); Serial.println();

  }
}

// Output angles: yaw, pitch, roll
void output_angles()
{
  if (output_format == OUTPUT__FORMAT_BINARY)
  {
    float ypr[3];  
    ypr[0] = TO_DEG(yaw);
    ypr[1] = TO_DEG(pitch);
    ypr[2] = TO_DEG(roll);
    Serial.write((byte*) ypr, 12);  // No new-line
  }
  else if (output_format == OUTPUT__FORMAT_TEXT)
  {
    Serial.print("#YPR=");
    Serial.print(TO_DEG(yaw)); Serial.print(",");
    Serial.print(TO_DEG(pitch)); Serial.print(",");
    Serial.print(TO_DEG(roll)); Serial.println();
  }
}

void output_calibration(int calibration_sensor)
{
  if (calibration_sensor == 0)  // Accelerometer
  {
    // Output MIN/MAX values
    Serial.print("accel x,y,z (min/max) = ");
    for (int i = 0; i < 3; i++) {
      if (accel[i] < accel_min[i]) accel_min[i] = accel[i];
      if (accel[i] > accel_max[i]) accel_max[i] = accel[i];
      Serial.print(accel_min[i]);
      Serial.print("/");
      Serial.print(accel_max[i]);
      if (i < 2) Serial.print("  ");
      else Serial.println();
    }
  }
  else if (calibration_sensor == 1)  // Magnetometer
  {
    // Output MIN/MAX values
    Serial.print("magn x,y,z (min/max) = ");
    for (int i = 0; i < 3; i++) {
      if (magnetom[i] < magnetom_min[i]) magnetom_min[i] = magnetom[i];
      if (magnetom[i] > magnetom_max[i]) magnetom_max[i] = magnetom[i];
      Serial.print(magnetom_min[i]);
      Serial.print("/");
      Serial.print(magnetom_max[i]);
      if (i < 2) Serial.print("  ");
      else Serial.println();
    }
  }
  else if (calibration_sensor == 2)  // Gyroscope
  {
    // Average gyro values
    for (int i = 0; i < 3; i++)
      gyro_average[i] += gyro[i];
    gyro_num_samples++;
      
    // Output current and averaged gyroscope values
    Serial.print("gyro x,y,z (current/average) = ");
    for (int i = 0; i < 3; i++) {
      Serial.print(gyro[i]);
      Serial.print("/");
      Serial.print(gyro_average[i] / (float) gyro_num_samples);
      if (i < 2) Serial.print("  ");
      else Serial.println();
    }
  }
}

void output_sensors_text(char raw_or_calibrated)
{
  Serial.print("#A-"); Serial.print(raw_or_calibrated); Serial.print('=');
  Serial.print(accel[0]); Serial.print(",");
  Serial.print(accel[1]); Serial.print(",");
  Serial.print(accel[2]); Serial.println();

  Serial.print("#M-"); Serial.print(raw_or_calibrated); Serial.print('=');
  Serial.print(magnetom[0]); Serial.print(",");
  Serial.print(magnetom[1]); Serial.print(",");
  Serial.print(magnetom[2]); Serial.println();

  Serial.print("#G-"); Serial.print(raw_or_calibrated); Serial.print('=');
  Serial.print(gyro[0]); Serial.print(",");
  Serial.print(gyro[1]); Serial.print(",");
  Serial.print(gyro[2]); Serial.println();
}

void output_sensors_binary()
{
  Serial.write((byte*) accel, 12);
  Serial.write((byte*) magnetom, 12);
  Serial.write((byte*) gyro, 12);
}

void output_sensors()
{
  if (output_mode == OUTPUT__MODE_SENSORS_RAW)
  {
    if (output_format == OUTPUT__FORMAT_BINARY)
      output_sensors_binary();
    else if (output_format == OUTPUT__FORMAT_TEXT)
      output_sensors_text('R');
  }
  else if (output_mode == OUTPUT__MODE_SENSORS_CALIB)
  {
    // Apply sensor calibration
    compensate_sensor_errors();
    
    if (output_format == OUTPUT__FORMAT_BINARY)
      output_sensors_binary();
    else if (output_format == OUTPUT__FORMAT_TEXT)
      output_sensors_text('C');
  }
  else if (output_mode == OUTPUT__MODE_SENSORS_BOTH)
  {
    if (output_format == OUTPUT__FORMAT_BINARY)
    {
      output_sensors_binary();
      compensate_sensor_errors();
      output_sensors_binary();
    }
    else if (output_format == OUTPUT__FORMAT_TEXT)
    {
      output_sensors_text('R');
      compensate_sensor_errors();
      output_sensors_text('C');
    }
  }
}

