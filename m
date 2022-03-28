From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 28 Mar 2022 13:39:14 +1030
Subject: [PATCH v2 1/5] ARM: dts: aspeed-g6: remove FWQSPID group in
 pinctrl dtsi
In-Reply-To: <20220325154048.467245-2-quic_jaehyoo@quicinc.com>
References: <20220325154048.467245-1-quic_jaehyoo@quicinc.com>
 <20220325154048.467245-2-quic_jaehyoo@quicinc.com>
Message-ID: <f55316d5-43cb-49cd-ba4b-6730c2a9b91c@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Sat, 26 Mar 2022, at 02:10, Jae Hyun Yoo wrote:
> FWSPIDQ2 and FWSPIDQ3 are not part of FWSPI18 interface so remove
> FWQSPID group in pinctrl dtsi. These pins must be used with the
> FWSPI pins that are dedicated for boot SPI interface which provides
> same 3.3v logic level.
>
> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> Fixes: 2f6edb6bcb2f ("ARM: dts: aspeed: Fix AST2600 quad spi group")
> ---
> Changes in v2:
>  * Rebased it on the latest.
>  * Updated 'Fixes' while rebasing it on the latest.
>
> Note:
>  * Removing 'pinctrl_fwqspid_default' doesn't break any existing DT since
>    it has not been used in any DTs.

Can you please send a patch to the bindings to drop the broken 
function/group given they never worked and no-one could be using them?

Other than that,

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
