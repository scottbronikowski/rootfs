
(cl:in-package :asdf)

(defsystem "trajectory_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "JointTrajectoryPoint" :depends-on ("_package_JointTrajectoryPoint"))
    (:file "_package_JointTrajectoryPoint" :depends-on ("_package"))
    (:file "JointTrajectory" :depends-on ("_package_JointTrajectory"))
    (:file "_package_JointTrajectory" :depends-on ("_package"))
  ))