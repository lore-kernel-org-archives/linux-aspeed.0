From: Andrew Lunn <andrew@lunn.ch>
Date: Thu, 24 Mar 2022 22:23:27 +0100
Subject: [PATCH] ARM: dts: aspeed: add Nuvia DC-SCM BMC
In-Reply-To: <20220324164551.359570-1-quic_jaehyoo@quicinc.com>
References: <20220324164551.359570-1-quic_jaehyoo@quicinc.com>
Message-ID: <YjzhT4gOJ9SKy6q+@lunn.ch>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Mar 24, 2022 at 09:45:51AM -0700, Jae Hyun Yoo wrote:
> From: Graeme Gregory <quic_ggregory@quicinc.com>
> 
> +&mac2 {
> +	status = "okay";
> +
> +	phy-mode = "rgmii";

Are you sure about this? That PHY are you using? It is more normal to
use rgmii-id.

    Andrew
