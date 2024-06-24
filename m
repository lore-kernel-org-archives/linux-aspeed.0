From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Mon, 24 Jun 2024 10:36:45 +0930
Subject: [PATCH v4 1/2] dt-bindings: pinctrl: aspeed,ast2600-pinctrl:
 add NCSI groups
In-Reply-To: <20240621093142.698529-2-potin.lai.pt@gmail.com>
References: <20240621093142.698529-1-potin.lai.pt@gmail.com>
	 <20240621093142.698529-2-potin.lai.pt@gmail.com>
Message-ID: <dba36e40c132561d9474f6742f3a18782f4d3983.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 2024-06-21 at 17:31 +0800, Potin Lai wrote:
> In the NCSI pin table, the reference clock output pin (RMIIXRCLKO) is not
> needed on the management controller side.
> 
> Add "NCSI" pin groups that are equivalent to the RMII pin groups, but
> without the RMIIXRCLKO pin.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
