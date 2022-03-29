From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Mar 2022 18:38:13 -0500
Subject: [PATCH v3 3/7] dt-bindings: pinctrl: aspeed-g6: remove FWQSPID
 group
In-Reply-To: <20220329173932.2588289-4-quic_jaehyoo@quicinc.com>
References: <20220329173932.2588289-1-quic_jaehyoo@quicinc.com>
 <20220329173932.2588289-4-quic_jaehyoo@quicinc.com>
Message-ID: <YkOYZQQ2D4zuBspP@robh.at.kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 29 Mar 2022 10:39:28 -0700, Jae Hyun Yoo wrote:
> FWQSPID is not a group of FWSPID so remove it.
> 
> Fixes: 7488838f2315 ("dt-bindings: pinctrl: aspeed: Document AST2600 pinmux")
> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> ---
> Changes in v3:
>  * Newly added in v3. (Andrew)
> 
>  .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
