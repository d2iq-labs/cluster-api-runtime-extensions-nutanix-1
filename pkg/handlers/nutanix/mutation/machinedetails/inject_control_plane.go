// Copyright 2023 D2iQ, Inc. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

package machinedetails

import (
	"github.com/d2iq-labs/cluster-api-runtime-extensions-nutanix/api/v1alpha1"
	"github.com/d2iq-labs/cluster-api-runtime-extensions-nutanix/common/pkg/capi/clustertopology/patches/selectors"
	"github.com/d2iq-labs/cluster-api-runtime-extensions-nutanix/pkg/handlers/generic/clusterconfig"
)

func NewControlPlanePatch() *nutanixMachineDetailsPatchHandler {
	return newNutanixMachineDetailsPatchHandler(
		clusterconfig.MetaVariableName,
		[]string{
			clusterconfig.MetaControlPlaneConfigName,
			v1alpha1.NutanixVariableName,
			VariableName,
		},
		selectors.InfrastructureControlPlaneMachines(
			"v1beta1",
			"NutanixMachineTemplate",
		),
	)
}
