From: Andrew Jeffery <andrew@aj.id.au>
Date: Wed, 30 Mar 2022 12:32:41 +1030
Subject: [PATCH v3 4/7] pinctrl: pinctrl-aspeed-g6: add FWQSPI
 function-group
In-Reply-To: <20220329173932.2588289-5-quic_jaehyoo@quicinc.com>
References: <20220329173932.2588289-1-quic_jaehyoo@quicinc.com>
 <20220329173932.2588289-5-quic_jaehyoo@quicinc.com>
Message-ID: <484751b1-86d0-40e6-b5cd-013ef076f3e5@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 30 Mar 2022, at 04:09, Jae Hyun Yoo wrote:
> From: Johnny Huang <johnny_huang@aspeedtech.com>
>
> Add FWSPIDQ2 (AE12) and FWSPIDQ3 (AF12) function-group to support
> AST2600 FW SPI quad mode. These pins can be used with dedicated FW
> SPI pins - FWSPICS0# (AB14), FWSPICK (AF13), FWSPIMOSI (AC14)
> and FWSPIMISO (AB13).
>
> Signed-off-by: Johnny Huang <johnny_huang@aspeedtech.com>
> Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
