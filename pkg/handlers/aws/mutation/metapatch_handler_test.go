// Copyright 2023 D2iQ, Inc. All rights reserved.
// SPDX-License-Identifier: Apache-2.0

package mutation

import (
	"testing"

	"sigs.k8s.io/controller-runtime/pkg/manager"

	"github.com/d2iq-labs/cluster-api-runtime-extensions-nutanix/common/pkg/capi/clustertopology/handlers/mutation"
	"github.com/d2iq-labs/cluster-api-runtime-extensions-nutanix/pkg/handlers/generic/clusterconfig"
<<<<<<< HEAD
	"github.com/d2iq-labs/cluster-api-runtime-extensions-nutanix/pkg/handlers/generic/mutation/users"
	userstests "github.com/d2iq-labs/cluster-api-runtime-extensions-nutanix/pkg/handlers/generic/mutation/users/tests"
=======
	"github.com/d2iq-labs/cluster-api-runtime-extensions-nutanix/pkg/handlers/generic/workerconfig"
>>>>>>> 4571fcb (test: move users unit tests)
)

func metaPatchGeneratorFunc(mgr manager.Manager) func() mutation.GeneratePatches {
	return func() mutation.GeneratePatches {
		return MetaPatchHandler(mgr).(mutation.GeneratePatches)
	}
}

func TestGeneratePatches(t *testing.T) {
	t.Parallel()

	mgr := testEnv.Manager

}
