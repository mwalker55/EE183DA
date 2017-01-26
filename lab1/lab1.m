clear;

%declaring all DH parameter syms
syms a0 a1 a2 a3 a4;
syms alpha0 alpha1 alpha2 alpha3 alpha4;
syms theta1 theta2 theta3 theta4;
syms d1 d2 d3 d4;

%formalizing DH parameters into single matrix
dH_sym = [a1 alpha1 theta1 d1;
      a2 alpha2 theta2 d2;
      a3 alpha3 theta3 d3;
      a4 alpha4 theta4 d4];
  
%initializing total transform matrix for joint 1; special case since two
%parameters are taken from '0th' joint
t_mat_sym = [cos(theta1) -sin(theta1) 0 a0;
         cos(alpha0)*sin(theta1) cos(alpha0)*cos(theta1) -sin(alpha0) -d1*sin(alpha0);
         sin(alpha0)*sin(theta1) sin(alpha0)*cos(theta1) cos(alpha0) d1*cos(alpha0);
         0 0 0 1];

%iterating through each joint's transform matrix and multiplying it into total transform product
for n=2:4
   mat = [cos(dH_sym(n,3)) -sin(dH_sym(n,3)) 0 dH_sym(n-1,1);
          cos(dH_sym(n-1,2))*sin(dH_sym(n,3)) cos(dH_sym(n-1,2))*cos(dH_sym(n,3)) -sin(dH_sym(n-1,2)) -dH_sym(n,4)*sin(dH_sym(n-1,2));
          sin(dH_sym(n-1,2))*sin(dH_sym(n,3)) sin(dH_sym(n-1,2))*cos(dH_sym(n,3)) cos(dH_sym(n-1, 2)) dH_sym(n,4)*cos(dH_sym(n-1,2));
          0 0 0 1];
   t_mat_sym = t_mat_sym*mat;
end
%at this point, t_mat_sym is a symbolic transform matrix to represent end
%effector in base reference frame as a function of all dH parameters, with
%only [theta1 theta2 theta3 theta4] being variable

%extracting the desired operational state variables from full transform matrix as
%described in report
op_space_sym = [t_mat_sym(1,4);
            t_mat_sym(2,4);
            t_mat_sym(3,4);
            atan2(t_mat_sym(3,2), t_mat_sym(3,3));
            atan2(-t_mat_sym(3,1), sqrt(t_mat_sym(3,2)^2+t_mat_sym(3,3)^2));
            atan2(t_mat_sym(2,1), t_mat_sym(1,1))];
%creates Jacobian of operational state variables with respect to four configuration
%state variables; top 3 rows will be linear velocity Jacobian and bottom 3
%rows will be angular velociy Jacobian
jac = jacobian(op_space_sym, [theta1 theta2 theta3 theta4]);        

%defines the DH parameters for some robot configuration
dH_real_init = [0 pi/2 pi/3 0;
           0 pi/2 pi/6 0;
           .38 pi/2 .8*pi 0;
           0 pi/2 .3*pi 0];

%uses forward kinematics result to compute position and orientation of end effector based on DH parameters       
op_space_real_init = double(subs(op_space_sym, [dH_sym vertcat(alpha0, zeros(3,1)) vertcat(a0, zeros(3,1))], [dH_real_init zeros(4,2)]));

%six operational state variables of desired endpoint for inverse kinematics
op_space_real_final = [0.327750113113536;-0.0497483625439159;0.185755117771391;-0.555489147219452;-0.233603167177685;0.458872364063971];
%defines the step for inverse kinematics
dx = .001*(op_space_real_final - op_space_real_init);
dH_real_final = dH_real_init;
for i=1:1000 
    %multiplies inverse Jacobian evaluated at current configuration state
    %and multiplies it by step to get change in configuration state
    dq = pinv(double(subs(jac, [dH_sym vertcat(alpha0, zeros(3,1)) vertcat(a0, zeros(3,1))], [dH_real_final zeros(4,2)])))*dx;
    %updates each configuration state variable
    dH_real_final(1,3) = dH_real_final(1,3)+dq(1);
    dH_real_final(2,3) = dH_real_final(2,3)+dq(2);
    dH_real_final(3,3) = dH_real_final(3,3)+dq(3);
    dH_real_final(4,3) = dH_real_final(4,3)+dq(4);
end
