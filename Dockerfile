# Copyright 2021 The Sigstore Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ARG RUNTIME_IMAGE=gcr.io/distroless/base:debug

FROM golang@sha256:c994ea4c0e524ea97ea7b4b21c19b968170a0c804b2fa7eee3c70c779fe84211 as build

WORKDIR /go/src/cosign
ADD . /go/src/cosign

RUN make cosign

FROM $RUNTIME_IMAGE

COPY --from=build /go/src/cosign/cosign /bin/

ENTRYPOINT [ "/bin/cosign" ]
