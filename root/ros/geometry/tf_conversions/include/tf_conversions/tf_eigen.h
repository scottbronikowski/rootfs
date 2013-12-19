/*
 * Copyright (c) 2009, Willow Garage, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the Willow Garage, Inc. nor the names of its
 *       contributors may be used to endorse or promote products derived from
 *       this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef CONVERSIONS_TF_EIGEN_H
#define CONVERSIONS_TF_EIGEN_H

#include "tf/transform_datatypes.h"
#include "Eigen/Core"
#include "Eigen/Geometry"

namespace tf {


/// Converts a tf Vector3 into an Eigen Vector3d
void VectorTFToEigen(const tf::Vector3& t, Eigen::Vector3d& k);

/// Converts an Eigen Vector3d into a tf Vector3
void VectorEigenToTF(const Eigen::Vector3d& k, tf::Vector3& t);

/// Converts a tf Quaternion into an Eigen Quaternion
void RotationTFToEigen(const tf::Quaternion& t, Eigen::Quaterniond& k);

/// Converts an Eigen Quaternion into a tf Quaternion
void RotationEigenToTF(const Eigen::Quaterniond& k, tf::Quaternion& t);

/// Converts a tf Transform into an Eigen Affine3d
void TransformTFToEigen(const tf::Transform &t, Eigen::Affine3d &k);

/// Converts an Eigen Affine3d into a tf Transform
void TransformEigenToTF(const Eigen::Affine3d &k, tf::Transform &t);

}

#endif
