From: Rob Herring <robh@kernel.org>
Date: Tue, 14 Jun 2022 15:41:21 -0600
Subject: [PATCH v4 2/2] dt-bindings: aspeed-i2c: add properties for
 setting i2c clock duty cycle
In-Reply-To: <20220610054722.32229-3-potin.lai.pt@gmail.com>
References: <20220610054722.32229-1-potin.lai.pt@gmail.com>
 <20220610054722.32229-3-potin.lai.pt@gmail.com>
Message-ID: <20220614214121.GA2705772-robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 10 Jun 2022 13:47:22 +0800, Potin Lai wrote:
> Introduce a new property for setting a minimum duty cycle for clock high.
> 
> * i2c-clk-high-min-percent: a minimum percentage of clock high
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
>  Documentation/devicetree/bindings/i2c/aspeed,i2c.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
