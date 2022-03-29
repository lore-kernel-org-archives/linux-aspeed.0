From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Mar 2022 18:38:37 -0500
Subject: [PATCH v3 5/7] dt-bindings: pinctrl: aspeed-g6: add FWQSPI
 function/group
In-Reply-To: <20220329173932.2588289-6-quic_jaehyoo@quicinc.com>
References: <20220329173932.2588289-1-quic_jaehyoo@quicinc.com>
 <20220329173932.2588289-6-quic_jaehyoo@quicinc.com>
Message-ID: <YkOYfSArIo/LyawY@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 29 Mar 2022 10:39:30 -0700, Jae Hyun Yoo wrote:
> Add FWQSPI function/group to support QSPI mode on the dedicated
> FWSPI interface.
> 
> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> ---
> Changes in v3:
>  * Newly added in v3. (Andrew)
> 
>  .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
