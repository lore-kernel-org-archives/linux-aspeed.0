From: Rob Herring <robh@kernel.org>
Date: Thu, 29 Jun 2017 15:12:25 -0500
Subject: [PATCH 1/4] ARM: aspeed: g4: Add USB functions to pinctrl bindings
In-Reply-To: <20170627021214.23323-2-andrew@aj.id.au>
References: <20170627021214.23323-1-andrew@aj.id.au>
 <20170627021214.23323-2-andrew@aj.id.au>
Message-ID: <20170629201225.exf4ax6az3m6zeb4@rob-hp-laptop>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 27, 2017 at 11:42:11AM +0930, Andrew Jeffery wrote:
> The AST2400 contains several USB controllers:
> 
> * USB 1.1 Host Controller
> * USB 2.0 Host Controller
> * Combined USB 2.0 Virtual Hub and USB 1.1 HID Controller
> 
> Pins for three ports are routed to the three controllers such that:
> 
> * Port 1 is a dedicated USB 1.1 host port
> * Port 2 is shared between the USB 1.1 host and HID controllers
> * Port 3 is shared between the USB 2.0 host and Hub controllers
> 
> As the pins for port 1 are fixed function there is no associated mux
> function or group described in the bindings. Ports 2 and 3 are muxed as
> above, and the table below describes the mapping between pinmux function
> names and ports:
> 
> Port  | USB Version  | USB Mode  | Mux Function
> ------|--------------|-----------|-------------
> 1     | 1.1          | Host      | -
> 2     | 1.1          | Host      | USB11H2
> 2     | 1.1          | Device    | USB11D1
> 3     | 2.0          | Host      | USB2H1
> 3     | 2.0          | Device    | USB2D1
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-aspeed.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
