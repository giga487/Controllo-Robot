/*
 * Tavola3_11_FL.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "Tavola3_11_FL".
 *
 * Model version              : 1.146
 * Simulink Coder version : 9.0 (R2018b) 24-May-2018
 * C source code generated on : Fri Jul 19 10:57:15 2019
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "Tavola3_11_FL.h"
#include "Tavola3_11_FL_private.h"

/* Block signals (default storage) */
B_Tavola3_11_FL_T Tavola3_11_FL_B;

/* Continuous states */
X_Tavola3_11_FL_T Tavola3_11_FL_X;

/* Block states (default storage) */
DW_Tavola3_11_FL_T Tavola3_11_FL_DW;

/* Real-time model */
RT_MODEL_Tavola3_11_FL_T Tavola3_11_FL_M_;
RT_MODEL_Tavola3_11_FL_T *const Tavola3_11_FL_M = &Tavola3_11_FL_M_;

/*
 * This function updates continuous states using the ODE3 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
  static const real_T rt_ODE3_A[3] = {
    1.0/2.0, 3.0/4.0, 1.0
  };

  static const real_T rt_ODE3_B[3][3] = {
    { 1.0/2.0, 0.0, 0.0 },

    { 0.0, 3.0/4.0, 0.0 },

    { 2.0/9.0, 1.0/3.0, 4.0/9.0 }
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE3_IntgData *id = (ODE3_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T hB[3];
  int_T i;
  int_T nXc = 8;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  Tavola3_11_FL_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  Tavola3_11_FL_step();
  Tavola3_11_FL_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  Tavola3_11_FL_step();
  Tavola3_11_FL_derivatives();

  /* tnew = t + hA(3);
     ynew = y + f*hB(:,3); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE3_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, tnew);
  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model step function */
void Tavola3_11_FL_step(void)
{
  real_T s_x;
  real_T v_x;
  real_T w_x;
  real_T cb_x;
  real_T db_x;
  real_T hb_x;
  real_T kb_x;
  real_T lb_x;
  real_T qb_x;
  real_T rb_x;
  real_T r;
  real_T t;
  static const int8_T a[16] = { 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0 };

  real_T tmp[8];
  int32_T i;
  real_T rtb_z_idx_2;
  real_T rtb_v_idx_0;
  real_T E_idx_0;
  real_T E_idx_2;
  real_T E_idx_1;
  real_T E_idx_3;
  real_T inv_E_idx_1;
  real_T x_tmp;
  real_T rtb_z_idx_2_tmp;
  real_T rtb_z_idx_2_tmp_0;
  real_T rtb_z_idx_2_tmp_1;
  real_T rtb_z_idx_2_tmp_2;
  real_T rtb_z_idx_2_tmp_3;
  real_T rtb_v_idx_0_tmp;
  real_T rtb_z_idx_2_tmp_4;
  real_T rtb_z_idx_2_tmp_5;
  real_T rtb_z_idx_2_tmp_6;
  real_T rtb_z_idx_2_tmp_7;
  real_T rtb_z_idx_2_tmp_8;
  real_T rtb_v_idx_0_tmp_tmp;
  real_T rtb_z_idx_2_tmp_9;
  real_T rtb_z_idx_2_tmp_a;
  real_T rtb_z_idx_2_tmp_tmp;
  real_T rtb_z_idx_2_tmp_tmp_0;
  if (rtmIsMajorTimeStep(Tavola3_11_FL_M)) {
    /* set solver stop time */
    if (!(Tavola3_11_FL_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&Tavola3_11_FL_M->solverInfo,
                            ((Tavola3_11_FL_M->Timing.clockTickH0 + 1) *
        Tavola3_11_FL_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&Tavola3_11_FL_M->solverInfo,
                            ((Tavola3_11_FL_M->Timing.clockTick0 + 1) *
        Tavola3_11_FL_M->Timing.stepSize0 + Tavola3_11_FL_M->Timing.clockTickH0 *
        Tavola3_11_FL_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(Tavola3_11_FL_M)) {
    Tavola3_11_FL_M->Timing.t[0] = rtsiGetT(&Tavola3_11_FL_M->solverInfo);
  }

  /* MATLAB Function: '<Root>/h(x)' incorporates:
   *  Integrator: '<Root>/Integrator'
   */
  Tavola3_11_FL_B.h1 = Tavola3_11_FL_X.Integrator_CSTATE[0];
  Tavola3_11_FL_B.h2 = Tavola3_11_FL_X.Integrator_CSTATE[1];
  Tavola3_11_FL_B.h3 = Tavola3_11_FL_X.Integrator_CSTATE[2];
  Tavola3_11_FL_B.h4 = Tavola3_11_FL_X.Integrator_CSTATE[3];
  Tavola3_11_FL_B.h5 = Tavola3_11_FL_X.Integrator_CSTATE[4];
  if (rtmIsMajorTimeStep(Tavola3_11_FL_M)) {
  }

  /* MATLAB Function: '<Root>/Coord' incorporates:
   *  Integrator: '<Root>/Integrator'
   *  MATLAB Function: '<Root>/Non_Linear_f '
   *  MATLAB Function: '<Root>/ingresso linearizzante'
   */
  x_tmp = cos(Tavola3_11_FL_X.Integrator_CSTATE[3]);
  rtb_z_idx_2_tmp = sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]);
  rtb_z_idx_2_tmp_0 = cos(Tavola3_11_FL_X.Integrator_CSTATE[2]);
  rtb_z_idx_2_tmp_1 = sin(Tavola3_11_FL_X.Integrator_CSTATE[3]);
  rtb_z_idx_2_tmp_2 = Tavola3_11_FL_X.Integrator_CSTATE[6] *
    Tavola3_11_FL_X.Integrator_CSTATE[6];
  rtb_z_idx_2_tmp_3 = Tavola3_11_FL_X.Integrator_CSTATE[4] *
    Tavola3_11_FL_X.Integrator_CSTATE[4];
  rtb_z_idx_2_tmp_4 = 35.0 * rtb_z_idx_2_tmp_0 / 16.0 + 3.1125;
  rtb_z_idx_2_tmp_5 = 2.19 * rtb_z_idx_2_tmp_0 + 3.11;
  rtb_z_idx_2_tmp_6 = 35.0 * x_tmp / 64.0 + 1.001875;
  t = sin(3.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) * 1.99 - 6.77 *
    rtb_z_idx_2_tmp_1;
  rtb_z_idx_2_tmp_7 = 0.547 * x_tmp + 1.0;
  rtb_z_idx_2_tmp_8 = sin(Tavola3_11_FL_X.Integrator_CSTATE[2]);
  rtb_z_idx_2_tmp_tmp = t * rtb_z_idx_2_tmp_2;
  rtb_z_idx_2_tmp_tmp_0 = rtb_z_idx_2_tmp_6 * Tavola3_11_FL_X.Integrator_CSTATE
    [7] / rtb_z_idx_2_tmp_4;
  rtb_z_idx_2_tmp_9 = Tavola3_11_FL_X.Integrator_CSTATE[5] *
    Tavola3_11_FL_X.Integrator_CSTATE[6];
  rtb_z_idx_2_tmp_a = rtb_z_idx_2_tmp_9 * rtb_z_idx_2_tmp_8;
  rtb_z_idx_2 = ((((rtb_z_idx_2_tmp * 3.28 * rtb_z_idx_2_tmp_2 / (x_tmp * x_tmp *
    4.79 - 12.5) + 173.0 * rtb_z_idx_2_tmp_1 / (x_tmp * x_tmp * 4.79 - 12.5)) -
                   rtb_z_idx_2_tmp_3 * 2.39 * rtb_z_idx_2_tmp / (x_tmp * x_tmp *
    4.79 - 12.5)) * rtb_z_idx_2_tmp_7 / rtb_z_idx_2_tmp_5 +
                  ((rtb_z_idx_2_tmp_tmp_0 - rtb_z_idx_2_tmp * 23.5 / (x_tmp *
    x_tmp * 4.79 - 12.5)) - rtb_z_idx_2_tmp_tmp)) + rtb_z_idx_2_tmp_3 * 2.19 *
                 rtb_z_idx_2_tmp / (x_tmp * x_tmp * 4.79 - 12.5)) *
    -rtb_z_idx_2_tmp_0 - rtb_z_idx_2_tmp_a;
  rtb_v_idx_0_tmp_tmp = Tavola3_11_FL_X.Integrator_CSTATE[5] * rtb_z_idx_2_tmp_0;

  /* MATLAB Function: '<Root>/Control' incorporates:
   *  Integrator: '<Root>/Integrator'
   *  MATLAB Function: '<Root>/Coord'
   */
  rtb_v_idx_0_tmp = rtb_v_idx_0_tmp_tmp * 5.0;
  rtb_v_idx_0 = (-0.1 * Tavola3_11_FL_X.Integrator_CSTATE[0] - rtb_v_idx_0_tmp)
    - 10.0 * rtb_z_idx_2;
  rtb_z_idx_2 = (-0.1 * Tavola3_11_FL_X.Integrator_CSTATE[1] - rtb_v_idx_0_tmp)
    - 10.0 * rtb_z_idx_2;

  /* MATLAB Function: '<Root>/ingresso linearizzante' incorporates:
   *  Integrator: '<Root>/Integrator'
   *  MATLAB Function: '<Root>/Non_Linear_f '
   */
  s_x = x_tmp * x_tmp * 4.79 - 12.5;
  v_x = x_tmp * x_tmp * 4.79 - 12.5;
  w_x = x_tmp * x_tmp * 4.79 - 12.5;
  cb_x = x_tmp * x_tmp * 4.79 - 12.5;
  db_x = x_tmp * x_tmp * 4.79 - 12.5;
  hb_x = x_tmp * x_tmp * 4.79 - 12.5;
  kb_x = x_tmp * x_tmp * 4.79 - 12.5;
  lb_x = x_tmp * x_tmp * 4.79 - 12.5;
  qb_x = x_tmp * x_tmp * 4.79 - 12.5;
  rb_x = x_tmp * x_tmp * 4.79 - 12.5;
  E_idx_0 = -(rtb_z_idx_2_tmp_6 * rtb_z_idx_2_tmp_0) / rtb_z_idx_2_tmp_4;
  rtb_v_idx_0_tmp = Tavola3_11_FL_X.Integrator_CSTATE[5] * rtb_z_idx_2_tmp_8;
  E_idx_2 = (t * (2.0 * Tavola3_11_FL_X.Integrator_CSTATE[6]) - 6.57 *
             Tavola3_11_FL_X.Integrator_CSTATE[6] * rtb_z_idx_2_tmp *
             rtb_z_idx_2_tmp_7 / ((x_tmp * x_tmp * 4.79 - 12.5) *
              rtb_z_idx_2_tmp_5)) * rtb_z_idx_2_tmp_0 - rtb_v_idx_0_tmp;
  E_idx_1 = -(rtb_z_idx_2_tmp_6 * rtb_z_idx_2_tmp_8) / rtb_z_idx_2_tmp_4;
  E_idx_3 = ((sin(3.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) * 1.99 - 6.77 *
              sin(Tavola3_11_FL_X.Integrator_CSTATE[3])) * (2.0 *
              Tavola3_11_FL_X.Integrator_CSTATE[6]) - 6.57 *
             Tavola3_11_FL_X.Integrator_CSTATE[6] * sin(2.0 *
              Tavola3_11_FL_X.Integrator_CSTATE[3]) * (0.547 * cos
              (Tavola3_11_FL_X.Integrator_CSTATE[3]) + 1.0) / ((x_tmp * x_tmp *
    4.79 - 12.5) * (2.19 * cos(Tavola3_11_FL_X.Integrator_CSTATE[2]) + 3.11))) *
    rtb_z_idx_2_tmp_8 + rtb_v_idx_0_tmp_tmp;
  if (fabs(E_idx_1) > fabs(E_idx_0)) {
    r = E_idx_0 / E_idx_1;
    t = 1.0 / (r * E_idx_3 - E_idx_2);
    E_idx_3 = E_idx_3 / E_idx_1 * t;
    inv_E_idx_1 = -t;
    E_idx_0 = -E_idx_2 / E_idx_1 * t;
    t *= r;
  } else {
    r = E_idx_1 / E_idx_0;
    t = 1.0 / (E_idx_3 - r * E_idx_2);
    E_idx_3 = E_idx_3 / E_idx_0 * t;
    inv_E_idx_1 = -r * t;
    E_idx_0 = -E_idx_2 / E_idx_0 * t;
  }

  r = cos(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]);
  rtb_z_idx_2_tmp = ((((((((cos(3.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) *
    5.98 - 6.77 * x_tmp) * rtb_z_idx_2_tmp_2 + r * 46.9 / (x_tmp * x_tmp * 4.79
    - 12.5)) - (((((173.0 * x_tmp / (x_tmp * x_tmp * 4.79 - 12.5) + 1666.0 *
                    x_tmp * (rtb_z_idx_2_tmp_1 * rtb_z_idx_2_tmp_1) / (s_x * s_x))
                   - rtb_z_idx_2_tmp_3 * 4.79 * r / (x_tmp * x_tmp * 4.79 - 12.5))
                  + rtb_z_idx_2_tmp_2 * 6.57 * r / (x_tmp * x_tmp * 4.79 - 12.5))
                 - rtb_z_idx_2_tmp_3 * 22.9 * rtb_z_idx_2_tmp * x_tmp *
                 rtb_z_idx_2_tmp_1 / (v_x * v_x)) + rtb_z_idx_2_tmp_2 * 31.4 *
                rtb_z_idx_2_tmp * x_tmp * rtb_z_idx_2_tmp_1 / (w_x * w_x)) *
    rtb_z_idx_2_tmp_7 / rtb_z_idx_2_tmp_5) + ((sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) * 3.28 *
    (Tavola3_11_FL_X.Integrator_CSTATE[6] * Tavola3_11_FL_X.Integrator_CSTATE[6])
    / (x_tmp * x_tmp * 4.79 - 12.5) + 173.0 * sin
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 - 12.5)) -
    Tavola3_11_FL_X.Integrator_CSTATE[4] * Tavola3_11_FL_X.Integrator_CSTATE[4] *
    2.39 * sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp *
    4.79 - 12.5)) * (0.547 * rtb_z_idx_2_tmp_1) / rtb_z_idx_2_tmp_5) -
                        rtb_z_idx_2_tmp_3 * 4.38 * r / (x_tmp * x_tmp * 4.79 -
    12.5)) + 35.0 * Tavola3_11_FL_X.Integrator_CSTATE[7] * rtb_z_idx_2_tmp_1 /
                       (rtb_z_idx_2_tmp_4 * 64.0)) + rtb_z_idx_2_tmp * 225.0 *
                      x_tmp * rtb_z_idx_2_tmp_1 / (cb_x * cb_x)) -
                     rtb_z_idx_2_tmp_3 * 21.0 * rtb_z_idx_2_tmp * x_tmp *
                     rtb_z_idx_2_tmp_1 / (db_x * db_x)) *
    (Tavola3_11_FL_X.Integrator_CSTATE[4] * rtb_z_idx_2_tmp_0) + ((((((sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) * 3.28 *
    (Tavola3_11_FL_X.Integrator_CSTATE[6] * Tavola3_11_FL_X.Integrator_CSTATE[6])
    / (x_tmp * x_tmp * 4.79 - 12.5) + 173.0 * sin
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 - 12.5)) -
    Tavola3_11_FL_X.Integrator_CSTATE[4] * Tavola3_11_FL_X.Integrator_CSTATE[4] *
    2.39 * sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp *
    4.79 - 12.5)) * (0.547 * cos(Tavola3_11_FL_X.Integrator_CSTATE[3]) + 1.0) /
    (2.19 * cos(Tavola3_11_FL_X.Integrator_CSTATE[2]) + 3.11) + (((35.0 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) / 64.0 + 1.001875) *
    Tavola3_11_FL_X.Integrator_CSTATE[7] / (35.0 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[2]) / 16.0 + 3.1125) - sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) * 23.5 / (x_tmp * x_tmp * 4.79 - 12.5))
    - (sin(3.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) * 1.99 - 6.77 * sin
       (Tavola3_11_FL_X.Integrator_CSTATE[3])) *
    (Tavola3_11_FL_X.Integrator_CSTATE[6] * Tavola3_11_FL_X.Integrator_CSTATE[6])))
    + Tavola3_11_FL_X.Integrator_CSTATE[4] * Tavola3_11_FL_X.Integrator_CSTATE[4]
    * 2.19 * sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp *
    4.79 - 12.5)) * (Tavola3_11_FL_X.Integrator_CSTATE[6] * rtb_z_idx_2_tmp_8) -
    (4.38 * Tavola3_11_FL_X.Integrator_CSTATE[4] * rtb_z_idx_2_tmp / (x_tmp *
    x_tmp * 4.79 - 12.5) - 4.79 * Tavola3_11_FL_X.Integrator_CSTATE[4] *
     rtb_z_idx_2_tmp * rtb_z_idx_2_tmp_7 / ((x_tmp * x_tmp * 4.79 - 12.5) *
    (2.19 * cos(Tavola3_11_FL_X.Integrator_CSTATE[2]) + 3.11))) *
    (Tavola3_11_FL_X.Integrator_CSTATE[7] * rtb_z_idx_2_tmp_0)) - (((((sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) * 3.28 *
    (Tavola3_11_FL_X.Integrator_CSTATE[6] * Tavola3_11_FL_X.Integrator_CSTATE[6])
    / (x_tmp * x_tmp * 4.79 - 12.5) + 173.0 * sin
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 - 12.5)) -
    Tavola3_11_FL_X.Integrator_CSTATE[4] * Tavola3_11_FL_X.Integrator_CSTATE[4] *
    2.39 * sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp *
    4.79 - 12.5)) * (rtb_z_idx_2_tmp_7 * (2.19 * rtb_z_idx_2_tmp_8)) /
    (rtb_z_idx_2_tmp_5 * rtb_z_idx_2_tmp_5) + rtb_z_idx_2_tmp_6 * (35.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[7] * rtb_z_idx_2_tmp_8) /
    (rtb_z_idx_2_tmp_4 * rtb_z_idx_2_tmp_4 * 16.0)) * rtb_z_idx_2_tmp_0 -
    ((((sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) * 3.28 *
        (Tavola3_11_FL_X.Integrator_CSTATE[6] *
         Tavola3_11_FL_X.Integrator_CSTATE[6]) / (x_tmp * x_tmp * 4.79 - 12.5) +
        173.0 * sin(Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp *
    4.79 - 12.5)) - Tavola3_11_FL_X.Integrator_CSTATE[4] *
       Tavola3_11_FL_X.Integrator_CSTATE[4] * 2.39 * sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 - 12.5)) *
      (0.547 * cos(Tavola3_11_FL_X.Integrator_CSTATE[3]) + 1.0) / (2.19 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[2]) + 3.11) + (((35.0 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) / 64.0 + 1.001875) *
    Tavola3_11_FL_X.Integrator_CSTATE[7] / (35.0 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[2]) / 16.0 + 3.1125) - sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) * 23.5 / (x_tmp * x_tmp * 4.79 - 12.5))
    - (sin(3.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) * 1.99 - 6.77 * sin
       (Tavola3_11_FL_X.Integrator_CSTATE[3])) *
    (Tavola3_11_FL_X.Integrator_CSTATE[6] * Tavola3_11_FL_X.Integrator_CSTATE[6])))
     + Tavola3_11_FL_X.Integrator_CSTATE[4] * Tavola3_11_FL_X.Integrator_CSTATE
     [4] * 2.19 * sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp *
    x_tmp * 4.79 - 12.5)) * rtb_z_idx_2_tmp_8) + rtb_z_idx_2_tmp_9 *
    rtb_z_idx_2_tmp_0) * Tavola3_11_FL_X.Integrator_CSTATE[6]);
  rtb_z_idx_2_tmp_0 = ((((((((((cos(3.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) *
    5.98 - 6.77 * cos(Tavola3_11_FL_X.Integrator_CSTATE[3])) *
    (Tavola3_11_FL_X.Integrator_CSTATE[6] * Tavola3_11_FL_X.Integrator_CSTATE[6])
    + cos(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) * 46.9 / (x_tmp * x_tmp *
    4.79 - 12.5)) - (((((173.0 * cos(Tavola3_11_FL_X.Integrator_CSTATE[3]) /
    (x_tmp * x_tmp * 4.79 - 12.5) + 1666.0 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) * (rtb_z_idx_2_tmp_1 *
    rtb_z_idx_2_tmp_1) / (hb_x * hb_x)) - Tavola3_11_FL_X.Integrator_CSTATE[4] *
                        Tavola3_11_FL_X.Integrator_CSTATE[4] * 4.79 * cos(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 - 12.5)) +
                       Tavola3_11_FL_X.Integrator_CSTATE[6] *
                       Tavola3_11_FL_X.Integrator_CSTATE[6] * 6.57 * cos(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 - 12.5)) -
                      Tavola3_11_FL_X.Integrator_CSTATE[4] *
                      Tavola3_11_FL_X.Integrator_CSTATE[4] * 22.9 * sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) * cos
                      (Tavola3_11_FL_X.Integrator_CSTATE[3]) * sin
                      (Tavola3_11_FL_X.Integrator_CSTATE[3]) / (kb_x * kb_x)) +
                     Tavola3_11_FL_X.Integrator_CSTATE[6] *
                     Tavola3_11_FL_X.Integrator_CSTATE[6] * 31.4 * sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) * cos
                     (Tavola3_11_FL_X.Integrator_CSTATE[3]) * sin
                     (Tavola3_11_FL_X.Integrator_CSTATE[3]) / (lb_x * lb_x)) *
    (0.547 * cos(Tavola3_11_FL_X.Integrator_CSTATE[3]) + 1.0) / (2.19 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[2]) + 3.11)) + ((sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) * 3.28 *
    (Tavola3_11_FL_X.Integrator_CSTATE[6] * Tavola3_11_FL_X.Integrator_CSTATE[6])
    / (x_tmp * x_tmp * 4.79 - 12.5) + 173.0 * sin
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 - 12.5)) -
    Tavola3_11_FL_X.Integrator_CSTATE[4] * Tavola3_11_FL_X.Integrator_CSTATE[4] *
    2.39 * sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp *
    4.79 - 12.5)) * (0.547 * sin(Tavola3_11_FL_X.Integrator_CSTATE[3])) / (2.19 *
    cos(Tavola3_11_FL_X.Integrator_CSTATE[2]) + 3.11)) -
    Tavola3_11_FL_X.Integrator_CSTATE[4] * Tavola3_11_FL_X.Integrator_CSTATE[4] *
    4.38 * cos(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp *
    4.79 - 12.5)) + 35.0 * Tavola3_11_FL_X.Integrator_CSTATE[7] * sin
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) / ((35.0 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[2]) / 16.0 + 3.1125) * 64.0)) + sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) * 225.0 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) * sin
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) / (qb_x * qb_x)) -
    Tavola3_11_FL_X.Integrator_CSTATE[4] * Tavola3_11_FL_X.Integrator_CSTATE[4] *
    21.0 * sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) * sin
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) / (rb_x * rb_x)) *
                        (Tavola3_11_FL_X.Integrator_CSTATE[4] *
    rtb_z_idx_2_tmp_8) - (4.38 * Tavola3_11_FL_X.Integrator_CSTATE[4] * sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 - 12.5) - 4.79
    * Tavola3_11_FL_X.Integrator_CSTATE[4] * sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) * (0.547 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) + 1.0) / ((x_tmp * x_tmp * 4.79 -
    12.5) * (2.19 * cos(Tavola3_11_FL_X.Integrator_CSTATE[2]) + 3.11))) *
                        (Tavola3_11_FL_X.Integrator_CSTATE[7] *
    rtb_z_idx_2_tmp_8)) - ((((sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) *
    3.28 * (Tavola3_11_FL_X.Integrator_CSTATE[6] *
            Tavola3_11_FL_X.Integrator_CSTATE[6]) / (x_tmp * x_tmp * 4.79 - 12.5)
    + 173.0 * sin(Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79
    - 12.5)) - Tavola3_11_FL_X.Integrator_CSTATE[4] *
    Tavola3_11_FL_X.Integrator_CSTATE[4] * 2.39 * sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 - 12.5)) *
    (0.547 * cos(Tavola3_11_FL_X.Integrator_CSTATE[3]) + 1.0) / (2.19 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[2]) + 3.11) + (((35.0 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[3]) / 64.0 + 1.001875) *
    Tavola3_11_FL_X.Integrator_CSTATE[7] / (35.0 * cos
    (Tavola3_11_FL_X.Integrator_CSTATE[2]) / 16.0 + 3.1125) - sin(2.0 *
    Tavola3_11_FL_X.Integrator_CSTATE[3]) * 23.5 / (x_tmp * x_tmp * 4.79 - 12.5))
    - (sin(3.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) * 1.99 - 6.77 * sin
       (Tavola3_11_FL_X.Integrator_CSTATE[3])) *
    (Tavola3_11_FL_X.Integrator_CSTATE[6] * Tavola3_11_FL_X.Integrator_CSTATE[6])))
    + Tavola3_11_FL_X.Integrator_CSTATE[4] * Tavola3_11_FL_X.Integrator_CSTATE[4]
    * 2.19 * sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp *
    4.79 - 12.5)) * (Tavola3_11_FL_X.Integrator_CSTATE[6] * rtb_z_idx_2_tmp_0))
    - ((((((sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) * 3.28 *
            (Tavola3_11_FL_X.Integrator_CSTATE[6] *
             Tavola3_11_FL_X.Integrator_CSTATE[6]) / (x_tmp * x_tmp * 4.79 -
             12.5) + 173.0 * sin(Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp *
             x_tmp * 4.79 - 12.5)) - Tavola3_11_FL_X.Integrator_CSTATE[4] *
           Tavola3_11_FL_X.Integrator_CSTATE[4] * 2.39 * sin(2.0 *
            Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 - 12.5))
          * (0.547 * cos(Tavola3_11_FL_X.Integrator_CSTATE[3]) + 1.0) / (2.19 *
           cos(Tavola3_11_FL_X.Integrator_CSTATE[2]) + 3.11) + (((35.0 * cos
             (Tavola3_11_FL_X.Integrator_CSTATE[3]) / 64.0 + 1.001875) *
            Tavola3_11_FL_X.Integrator_CSTATE[7] / (35.0 * cos
             (Tavola3_11_FL_X.Integrator_CSTATE[2]) / 16.0 + 3.1125) - sin(2.0 *
             Tavola3_11_FL_X.Integrator_CSTATE[3]) * 23.5 / (x_tmp * x_tmp *
             4.79 - 12.5)) - (sin(3.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) *
            1.99 - 6.77 * sin(Tavola3_11_FL_X.Integrator_CSTATE[3])) *
           (Tavola3_11_FL_X.Integrator_CSTATE[6] *
            Tavola3_11_FL_X.Integrator_CSTATE[6]))) +
         Tavola3_11_FL_X.Integrator_CSTATE[4] *
         Tavola3_11_FL_X.Integrator_CSTATE[4] * 2.19 * sin(2.0 *
          Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 - 12.5))
        * rtb_z_idx_2_tmp_0 + (((sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3])
           * 3.28 * (Tavola3_11_FL_X.Integrator_CSTATE[6] *
                     Tavola3_11_FL_X.Integrator_CSTATE[6]) / (x_tmp * x_tmp *
            4.79 - 12.5) + 173.0 * sin(Tavola3_11_FL_X.Integrator_CSTATE[3]) /
           (x_tmp * x_tmp * 4.79 - 12.5)) - Tavola3_11_FL_X.Integrator_CSTATE[4]
          * Tavola3_11_FL_X.Integrator_CSTATE[4] * 2.39 * sin(2.0 *
           Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 - 12.5))
         * ((0.547 * cos(Tavola3_11_FL_X.Integrator_CSTATE[3]) + 1.0) * (2.19 *
           sin(Tavola3_11_FL_X.Integrator_CSTATE[2]))) / (rtb_z_idx_2_tmp_5 *
          rtb_z_idx_2_tmp_5) + (35.0 * cos(Tavola3_11_FL_X.Integrator_CSTATE[3])
          / 64.0 + 1.001875) * (35.0 * Tavola3_11_FL_X.Integrator_CSTATE[7] *
          sin(Tavola3_11_FL_X.Integrator_CSTATE[2])) / (rtb_z_idx_2_tmp_4 *
          rtb_z_idx_2_tmp_4 * 16.0)) * rtb_z_idx_2_tmp_8) + rtb_z_idx_2_tmp_a) *
    Tavola3_11_FL_X.Integrator_CSTATE[6];
  E_idx_3 = (-E_idx_3 * rtb_z_idx_2_tmp + -E_idx_0 * rtb_z_idx_2_tmp_0) +
    (E_idx_3 * rtb_v_idx_0 + E_idx_0 * rtb_z_idx_2);
  inv_E_idx_1 = (-inv_E_idx_1 * rtb_z_idx_2_tmp + -t * rtb_z_idx_2_tmp_0) +
    (inv_E_idx_1 * rtb_v_idx_0 + t * rtb_z_idx_2);

  /* MATLAB Function: '<Root>/Non_Linear_f ' incorporates:
   *  Integrator: '<Root>/Integrator'
   */
  tmp[0] = rtb_v_idx_0_tmp_tmp;
  tmp[1] = rtb_v_idx_0_tmp;
  tmp[2] = Tavola3_11_FL_X.Integrator_CSTATE[6];
  tmp[3] = Tavola3_11_FL_X.Integrator_CSTATE[4];
  tmp[4] = Tavola3_11_FL_X.Integrator_CSTATE[7];
  tmp[5] = (((rtb_z_idx_2_tmp_tmp + sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE
    [3]) * 23.5 / (x_tmp * x_tmp * 4.79 - 12.5)) - rtb_z_idx_2_tmp_tmp_0) -
            ((sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) * 3.28 *
              (Tavola3_11_FL_X.Integrator_CSTATE[6] *
               Tavola3_11_FL_X.Integrator_CSTATE[6]) / (x_tmp * x_tmp * 4.79 -
    12.5) + 173.0 * sin(Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp *
    4.79 - 12.5)) - Tavola3_11_FL_X.Integrator_CSTATE[4] *
             Tavola3_11_FL_X.Integrator_CSTATE[4] * 2.39 * sin(2.0 *
              Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp * 4.79 -
              12.5)) * (0.547 * cos(Tavola3_11_FL_X.Integrator_CSTATE[3]) + 1.0)
            / (2.19 * cos(Tavola3_11_FL_X.Integrator_CSTATE[2]) + 3.11)) -
    Tavola3_11_FL_X.Integrator_CSTATE[4] * Tavola3_11_FL_X.Integrator_CSTATE[4] *
    2.19 * sin(2.0 * Tavola3_11_FL_X.Integrator_CSTATE[3]) / (x_tmp * x_tmp *
    4.79 - 12.5);
  tmp[6] = 0.0;
  tmp[7] = 0.0;
  for (i = 0; i < 8; i++) {
    Tavola3_11_FL_B.d_x[i] = tmp[i] + ((real_T)a[i + 8] * inv_E_idx_1 + (real_T)
      a[i] * E_idx_3);
  }

  if (rtmIsMajorTimeStep(Tavola3_11_FL_M)) {
    /* Matfile logging */
    rt_UpdateTXYLogVars(Tavola3_11_FL_M->rtwLogInfo, (Tavola3_11_FL_M->Timing.t));
  }                                    /* end MajorTimeStep */

  if (rtmIsMajorTimeStep(Tavola3_11_FL_M)) {
    /* signal main to stop simulation */
    {                                  /* Sample time: [0.0s, 0.0s] */
      if ((rtmGetTFinal(Tavola3_11_FL_M)!=-1) &&
          !((rtmGetTFinal(Tavola3_11_FL_M)-(((Tavola3_11_FL_M->Timing.clockTick1
               +Tavola3_11_FL_M->Timing.clockTickH1* 4294967296.0)) * 0.2)) >
            (((Tavola3_11_FL_M->Timing.clockTick1+
               Tavola3_11_FL_M->Timing.clockTickH1* 4294967296.0)) * 0.2) *
            (DBL_EPSILON))) {
        rtmSetErrorStatus(Tavola3_11_FL_M, "Simulation finished");
      }
    }

    rt_ertODEUpdateContinuousStates(&Tavola3_11_FL_M->solverInfo);

    /* Update absolute time for base rate */
    /* The "clockTick0" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick0"
     * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick0 and the high bits
     * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++Tavola3_11_FL_M->Timing.clockTick0)) {
      ++Tavola3_11_FL_M->Timing.clockTickH0;
    }

    Tavola3_11_FL_M->Timing.t[0] = rtsiGetSolverStopTime
      (&Tavola3_11_FL_M->solverInfo);

    {
      /* Update absolute timer for sample time: [0.2s, 0.0s] */
      /* The "clockTick1" counts the number of times the code of this task has
       * been executed. The resolution of this integer timer is 0.2, which is the step size
       * of the task. Size of "clockTick1" ensures timer will not overflow during the
       * application lifespan selected.
       * Timer of this task consists of two 32 bit unsigned integers.
       * The two integers represent the low bits Timing.clockTick1 and the high bits
       * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
       */
      Tavola3_11_FL_M->Timing.clockTick1++;
      if (!Tavola3_11_FL_M->Timing.clockTick1) {
        Tavola3_11_FL_M->Timing.clockTickH1++;
      }
    }
  }                                    /* end MajorTimeStep */
}

/* Derivatives for root system: '<Root>' */
void Tavola3_11_FL_derivatives(void)
{
  XDot_Tavola3_11_FL_T *_rtXdot;
  _rtXdot = ((XDot_Tavola3_11_FL_T *) Tavola3_11_FL_M->derivs);

  /* Derivatives for Integrator: '<Root>/Integrator' */
  memcpy(&_rtXdot->Integrator_CSTATE[0], &Tavola3_11_FL_B.d_x[0], sizeof(real_T)
         << 3U);
}

/* Model initialize function */
void Tavola3_11_FL_initialize(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* initialize real-time model */
  (void) memset((void *)Tavola3_11_FL_M, 0,
                sizeof(RT_MODEL_Tavola3_11_FL_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&Tavola3_11_FL_M->solverInfo,
                          &Tavola3_11_FL_M->Timing.simTimeStep);
    rtsiSetTPtr(&Tavola3_11_FL_M->solverInfo, &rtmGetTPtr(Tavola3_11_FL_M));
    rtsiSetStepSizePtr(&Tavola3_11_FL_M->solverInfo,
                       &Tavola3_11_FL_M->Timing.stepSize0);
    rtsiSetdXPtr(&Tavola3_11_FL_M->solverInfo, &Tavola3_11_FL_M->derivs);
    rtsiSetContStatesPtr(&Tavola3_11_FL_M->solverInfo, (real_T **)
                         &Tavola3_11_FL_M->contStates);
    rtsiSetNumContStatesPtr(&Tavola3_11_FL_M->solverInfo,
      &Tavola3_11_FL_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&Tavola3_11_FL_M->solverInfo,
      &Tavola3_11_FL_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&Tavola3_11_FL_M->solverInfo,
      &Tavola3_11_FL_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&Tavola3_11_FL_M->solverInfo,
      &Tavola3_11_FL_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&Tavola3_11_FL_M->solverInfo, (&rtmGetErrorStatus
      (Tavola3_11_FL_M)));
    rtsiSetRTModelPtr(&Tavola3_11_FL_M->solverInfo, Tavola3_11_FL_M);
  }

  rtsiSetSimTimeStep(&Tavola3_11_FL_M->solverInfo, MAJOR_TIME_STEP);
  Tavola3_11_FL_M->intgData.y = Tavola3_11_FL_M->odeY;
  Tavola3_11_FL_M->intgData.f[0] = Tavola3_11_FL_M->odeF[0];
  Tavola3_11_FL_M->intgData.f[1] = Tavola3_11_FL_M->odeF[1];
  Tavola3_11_FL_M->intgData.f[2] = Tavola3_11_FL_M->odeF[2];
  Tavola3_11_FL_M->contStates = ((X_Tavola3_11_FL_T *) &Tavola3_11_FL_X);
  rtsiSetSolverData(&Tavola3_11_FL_M->solverInfo, (void *)
                    &Tavola3_11_FL_M->intgData);
  rtsiSetSolverName(&Tavola3_11_FL_M->solverInfo,"ode3");
  rtmSetTPtr(Tavola3_11_FL_M, &Tavola3_11_FL_M->Timing.tArray[0]);
  rtmSetTFinal(Tavola3_11_FL_M, 10.0);
  Tavola3_11_FL_M->Timing.stepSize0 = 0.2;

  /* Setup for data logging */
  {
    static RTWLogInfo rt_DataLoggingInfo;
    rt_DataLoggingInfo.loggingInterval = NULL;
    Tavola3_11_FL_M->rtwLogInfo = &rt_DataLoggingInfo;
  }

  /* Setup for data logging */
  {
    rtliSetLogXSignalInfo(Tavola3_11_FL_M->rtwLogInfo, (NULL));
    rtliSetLogXSignalPtrs(Tavola3_11_FL_M->rtwLogInfo, (NULL));
    rtliSetLogT(Tavola3_11_FL_M->rtwLogInfo, "tout");
    rtliSetLogX(Tavola3_11_FL_M->rtwLogInfo, "");
    rtliSetLogXFinal(Tavola3_11_FL_M->rtwLogInfo, "");
    rtliSetLogVarNameModifier(Tavola3_11_FL_M->rtwLogInfo, "rt_");
    rtliSetLogFormat(Tavola3_11_FL_M->rtwLogInfo, 4);
    rtliSetLogMaxRows(Tavola3_11_FL_M->rtwLogInfo, 0);
    rtliSetLogDecimation(Tavola3_11_FL_M->rtwLogInfo, 1);
    rtliSetLogY(Tavola3_11_FL_M->rtwLogInfo, "");
    rtliSetLogYSignalInfo(Tavola3_11_FL_M->rtwLogInfo, (NULL));
    rtliSetLogYSignalPtrs(Tavola3_11_FL_M->rtwLogInfo, (NULL));
  }

  /* block I/O */
  (void) memset(((void *) &Tavola3_11_FL_B), 0,
                sizeof(B_Tavola3_11_FL_T));

  /* states (continuous) */
  {
    (void) memset((void *)&Tavola3_11_FL_X, 0,
                  sizeof(X_Tavola3_11_FL_T));
  }

  /* states (dwork) */
  (void) memset((void *)&Tavola3_11_FL_DW, 0,
                sizeof(DW_Tavola3_11_FL_T));

  /* Matfile logging */
  rt_StartDataLoggingWithStartTime(Tavola3_11_FL_M->rtwLogInfo, 0.0,
    rtmGetTFinal(Tavola3_11_FL_M), Tavola3_11_FL_M->Timing.stepSize0,
    (&rtmGetErrorStatus(Tavola3_11_FL_M)));

  /* InitializeConditions for Integrator: '<Root>/Integrator' */
  memcpy(&Tavola3_11_FL_X.Integrator_CSTATE[0], &Tavola3_11_FL_P.Integrator_IC[0],
         sizeof(real_T) << 3U);
}

/* Model terminate function */
void Tavola3_11_FL_terminate(void)
{
  /* (no terminate code required) */
}
