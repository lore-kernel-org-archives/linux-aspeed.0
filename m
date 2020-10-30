From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 30 Oct 2020 13:48:36 +1030
Subject: =?UTF-8?Q?Re:_[PATCH]_ARM:_dts:_aspeed-g6:_Fix_HVI3C_function-group_in_p?=
 =?UTF-8?Q?inctrl_dtsi?=
In-Reply-To: <20201029062723.20798-1-dylan_hung@aspeedtech.com>
References: <20201029062723.20798-1-dylan_hung@aspeedtech.com>
Message-ID: <c3b4c7d8-65fc-4196-b635-bf65ed3b44a1@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 29 Oct 2020, at 16:57, Dylan Hung wrote:
> The HVI3C shall be a group of I3C function, not an independent function.
> Correct the function name from "HVI3C" to "I3C".
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>

Good catch. Thanks Dylan.

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
