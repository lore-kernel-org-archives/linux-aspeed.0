From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Tue, 06 Aug 2024 12:31:38 +0930
Subject: [PATCH v7 0/2] Add Meta(Facebook) Catalina BMC(AST2600)
In-Reply-To: <20240805-potin-catalina-dts-v7-0-286bfd2ab93b@gmail.com>
References: <20240805-potin-catalina-dts-v7-0-286bfd2ab93b@gmail.com>
Message-ID: <1c6598d080d488005b14e127396dd7db72bc4ca4.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 2024-08-05 at 23:46 +0800, Potin Lai wrote:
> Add Linux device tree entry related to Meta(Facebook) Catalina specific
> devices connected to BMC(AST2600) SoC.
> 
> Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
> ---
> Changes in v7:
> - drop 'pinctrl-names' in gpio0 node
> - change 'vref' to 'vref-supply' in adc0 & adc1 nodes
> - add p1v8_bmc_aux & p2v5_bmc_aux nodes
> - change Signed-off tag email as same as sender.
> - Link to v6: https://lore.kernel.org/r/20240802-potin-catalina-dts-v6-0-0b8f61b80688 at gmail.com

Thanks, I've applied these to be picked up via the BMC tree.

Andrew
