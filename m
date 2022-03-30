From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 30 Mar 2022 12:30:30 +1030
Subject: [PATCH v3 2/7] pinctrl: pinctrl-aspeed-g6: remove FWQSPID group
 in pinctrl
In-Reply-To: <20220329173932.2588289-3-quic_jaehyoo@quicinc.com>
References: <20220329173932.2588289-1-quic_jaehyoo@quicinc.com>
 <20220329173932.2588289-3-quic_jaehyoo@quicinc.com>
Message-ID: <a90b8916-337e-44e7-ac01-64ce66e62140@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 30 Mar 2022, at 04:09, Jae Hyun Yoo wrote:
> FWSPIDQ2 and FWSPIDQ3 are not part of FWSPI18 interface so remove
> FWQSPID group in pinctrl. These pins must be used with the FWSPI
> pins that are dedicated for boot SPI interface which provides
> same 3.3v logic level.
>
> Fixes: 2eda1cdec49f ("pinctrl: aspeed: Add AST2600 pinmux support")
> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
